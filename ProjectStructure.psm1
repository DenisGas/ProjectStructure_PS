# Paths to configurations
$script:configPath = Join-Path -Path $PSScriptRoot -ChildPath 'config.psd1'
$script:pluginsPath = Join-Path -Path $PSScriptRoot -ChildPath 'plugins'

function Get-ProjectModulePath {
    <#
    .SYNOPSIS
    Returns the path to the module directory.

    .DESCRIPTION
    This function returns the full path to the ProjectStructure module directory,
    which is useful for installing plugins.

    .EXAMPLE
    Get-ProjectModulePath
    #>
    return $PSScriptRoot
}

function Open-ProjectModuleFolder {
    <#
    .SYNOPSIS
    Opens the module directory in File Explorer.

    .DESCRIPTION
    This function opens the ProjectStructure module directory in Windows File Explorer,
    making it easy to access configuration files and plugins.

    .EXAMPLE
    Open-ProjectModuleFolder
    #>
    Invoke-Item $PSScriptRoot
}

function Get-AvailablePlugins {
    <#
    .SYNOPSIS
    Retrieves a list of available plugins.

    .DESCRIPTION
    Returns information about all available plugins in the plugins directory.

    .EXAMPLE
    Get-AvailablePlugins
    #>
    
    if (Test-Path -Path $script:pluginsPath) {
        $plugins = Get-ChildItem -Path $script:pluginsPath -Filter "*.psd1"
        return $plugins | ForEach-Object {
            @{"Name" = $_.BaseName; "Path" = $_.FullName }
        }
    }
    return @()
}

function Merge-Configurations {
    param (
        [Parameter(Mandatory = $true)]
        [hashtable]$BaseConfig,
        
        [Parameter(Mandatory = $true)]
        [hashtable]$PluginConfig
    )
    
    $mergedConfig = $BaseConfig.Clone()
    
    foreach ($key in $PluginConfig.Keys) {
        if ($mergedConfig.ContainsKey($key) -and $mergedConfig[$key] -is [hashtable]) {
            $mergedConfig[$key] = Merge-Configurations $mergedConfig[$key] $PluginConfig[$key]
        }
        else {
            $mergedConfig[$key] = $PluginConfig[$key]
        }
    }
    
    return $mergedConfig
}

function Import-ProjectConfiguration {
    param (
        [string]$ConfigPath = $script:configPath,
        [string[]]$EnabledPlugins = @()
    )
    
    # Load the main configuration
    if (-not (Test-Path -Path $ConfigPath)) {
        throw "Configuration file not found: $ConfigPath"
    }
    
    $config = Import-PowerShellDataFile -Path $ConfigPath
    
    # If plugins are not explicitly specified, check default settings in the config
    if ($EnabledPlugins.Count -eq 0 -and $config.EnabledPlugins) {
        $EnabledPlugins = $config.EnabledPlugins
    }
    
    # Loading plugins
    if (Test-Path -Path $script:pluginsPath) {
        $availablePlugins = Get-ChildItem -Path $script:pluginsPath -Filter "*.psd1"
        
        foreach ($plugin in $availablePlugins) {
            # Load the plugin only if it is in the enabled list or the list is empty
            if ($EnabledPlugins.Count -eq 0 -or $EnabledPlugins -contains $plugin.BaseName) {
                Write-Verbose "Loading plugin: $($plugin.BaseName)"
                $pluginConfig = Import-PowerShellDataFile -Path $plugin.FullName
                $config = Merge-Configurations -BaseConfig $config -PluginConfig $pluginConfig
            }
        }
    }
    
    return $config
}

function Show-ProjectStructure {
    <#
    .SYNOPSIS
    Displays the project structure as a tree with color styling.

    .DESCRIPTION
    The Show-ProjectStructure function visualizes the project's directory and file structure
    with customizable color styling and ignore rules.
    Supports a plugin system for extended configuration.

    .PARAMETER Path
    The path to the project directory whose structure should be displayed.

    .PARAMETER Depth
    The maximum depth for directory traversal. -1 for full traversal (default).

    .PARAMETER ConfigPath
    The path to the main configuration file. Defaults to config.psd1 from the module directory.

    .PARAMETER EnabledPlugins
    An array of plugin names to use. If not specified, all available plugins or plugins specified
    in the main configuration file are used.

    .PARAMETER Verbose
    Enables detailed information about plugin loading.

    .EXAMPLE
    Show-ProjectStructure -Path "C:\MyProject"
    Displays the project structure with default settings.

    .EXAMPLE
    Show-ProjectStructure -Path "C:\MyProject" -EnabledPlugins @("web", "python")
    Displays the project structure using only the web and python plugins.

    .EXAMPLE
    Get-AvailablePlugins
    Displays a list of available plugins.
    #>
    
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,
        
        [Parameter(Mandatory = $false)]
        [int]$Depth = 2,
        
        [Parameter(Mandatory = $false)]
        [string]$ConfigPath = $script:configPath,
        
        [Parameter(Mandatory = $false)]
        [string[]]$EnabledPlugins = @(),

        [Parameter(Mandatory = $false)]
        [switch]$NoStyle,
        
        [Parameter(DontShow)]
        [int]$CurrentDepth = 0,
        
        [Parameter(DontShow)]
        [string]$Indent = ""
    )

    try {
        $config = Import-ProjectConfiguration -ConfigPath $ConfigPath -EnabledPlugins $EnabledPlugins
    }
    catch {
        Write-Error "Error loading configuration: $_"
        return
    }
    
    $items = Get-ChildItem -Path $Path
    
    foreach ($item in $items) {
        $displayName = $item.Name
        $ignored = $false
        
        if ($item.PSIsContainer) {
            # Use default folder color from config or fallback to Yellow
            $color = if ($NoStyle) { "Yellow" } else { $config.Defaults.FolderColor ?? "Yellow" }
            $folderConfig = $config.Folders[$item.Name]
            # if ($folderConfig -and -not $NoStyle) {
            #     $color = $folderConfig.Color ?? $color
            #     $ignored = $folderConfig.Ignore -eq $true
            # }
            if ($folderConfig) {
                $ignored = $folderConfig.Ignore -eq $true
                if (-not $NoStyle) { 
                    $color = $folderConfig.Color ?? $color
                }
            }
            $folderIcon = if ($NoStyle) { "" } else { $config.Icons.Folder }
            Write-Host "$Indent├─ $folderIcon" -NoNewline
            Write-Host " $displayName" -ForegroundColor $color
            
            if ((-not $ignored) -and ($Depth -eq -1 -or $CurrentDepth -lt $Depth)) {
                Show-ProjectStructure `
                    -Path $item.FullName `
                    -Depth $Depth `
                    -ConfigPath $ConfigPath `
                    -EnabledPlugins $EnabledPlugins `
                    -NoStyle:$NoStyle `
                    -CurrentDepth ($CurrentDepth + 1) `
                    -Indent "$Indent│  "
            }
        }
        else {
            # Use default file color from config or fallback to Gray
            $color = if ($NoStyle) { "Gray" } else { $config.Defaults.FileColor ?? "Gray" }
            $extension = $item.Extension
            $fileConfig = $config.Files[$extension]
            if ($fileConfig -and -not $NoStyle) {
                $color = $fileConfig.Color ?? $color
            }
            
            $icon = if ($NoStyle) { "" } else {
                $config.Icons.Files[$extension] ?? $config.Icons.Default
            }
            
            Write-Host "$Indent├─ $icon" -NoNewline
            Write-Host " $displayName" -ForegroundColor $color
        }
    }
}

Export-ModuleMember -Function Show-ProjectStructure, Get-AvailablePlugins, Get-ProjectModulePath, Open-ProjectModuleFolder
