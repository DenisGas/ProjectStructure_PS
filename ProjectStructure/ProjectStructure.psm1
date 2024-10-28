# ProjectStructure.psm1

# Пути к конфигурациям
$script:configPath = Join-Path -Path $PSScriptRoot -ChildPath 'config.psd1'
$script:pluginsPath = Join-Path -Path $PSScriptRoot -ChildPath 'plugins'

function Get-AvailablePlugins {
    <#
    .SYNOPSIS
    Получает список доступных плагинов.

    .DESCRIPTION
    Возвращает информацию о всех доступных плагинах в директории plugins.

    .EXAMPLE
    Get-AvailablePlugins
    #>
    
    if (Test-Path -Path $script:pluginsPath) {
        $plugins = Get-ChildItem -Path $script:pluginsPath -Filter "*.psd1"
        return $plugins | ForEach-Object {
            @{
                Name = $_.BaseName
                Path = $_.FullName
            }
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
    
    # Загрузка основной конфигурации
    if (-not (Test-Path -Path $ConfigPath)) {
        throw "Configuration file not found: $ConfigPath"
    }
    
    $config = Import-PowerShellDataFile -Path $ConfigPath
    
    # Если плагины не указаны явно, проверяем настройки по умолчанию в конфиге
    if ($EnabledPlugins.Count -eq 0 -and $config.EnabledPlugins) {
        $EnabledPlugins = $config.EnabledPlugins
    }
    
    # Загрузка плагинов
    if (Test-Path -Path $script:pluginsPath) {
        $availablePlugins = Get-ChildItem -Path $script:pluginsPath -Filter "*.psd1"
        
        foreach ($plugin in $availablePlugins) {
            # Загружаем плагин только если он в списке включенных или список пуст
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
    Отображает структуру проекта в виде дерева с цветовым оформлением.

    .DESCRIPTION
    Функция Show-ProjectStructure визуализирует структуру директорий и файлов проекта
    с учетом настраиваемого цветового оформления и правил игнорирования.
    Поддерживает систему плагинов для расширения конфигурации.

    .PARAMETER Path
    Путь к директории проекта, структуру которой нужно отобразить.

    .PARAMETER Depth
    Максимальная глубина обхода директорий. -1 для полного обхода (по умолчанию).

    .PARAMETER ConfigPath
    Путь к основному конфигурационному файлу. По умолчанию используется config.psd1 из директории модуля.

    .PARAMETER EnabledPlugins
    Массив имен плагинов, которые нужно использовать. Если не указан, используются все доступные плагины
    или плагины, указанные в основном конфигурационном файле.

    .PARAMETER Verbose
    Включает подробный вывод информации о загрузке плагинов.

    .EXAMPLE
    Show-ProjectStructure -Path "C:\MyProject"
    Отображает структуру проекта с настройками по умолчанию.

    .EXAMPLE
    Show-ProjectStructure -Path "C:\MyProject" -EnabledPlugins @("web", "python")
    Отображает структуру проекта, используя только плагины web и python.

    .EXAMPLE
    Get-AvailablePlugins
    Показывает список доступных плагинов.
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
            $color = "Yellow"  # Желтый цвет по умолчанию для папок
            $folderConfig = $config.Folders[$item.Name]
            if ($folderConfig) {
                $color = $folderConfig.Color ?? $color  # Используем заданный цвет или желтый по умолчанию
                $ignored = $folderConfig.Ignore -eq $true
            }
            
            $folderIcon = $config.Icons.Folder
            Write-Host "$Indent├─ $folderIcon" -NoNewline
            Write-Host " $displayName" -ForegroundColor $color
            
            if ((-not $ignored) -and ($Depth -eq -1 -or $CurrentDepth -lt $Depth)) {
                Show-ProjectStructure `
                    -Path $item.FullName `
                    -Depth $Depth `
                    -ConfigPath $ConfigPath `
                    -EnabledPlugins $EnabledPlugins `
                    -CurrentDepth ($CurrentDepth + 1) `
                    -Indent "$Indent│  "
            }
        }
        else {
            $color = "Gray"  # Белый цвет по умолчанию для файлов
            $extension = $item.Extension
            $fileConfig = $config.Files[$extension]
            if ($fileConfig) {
                $color = $fileConfig.Color ?? $color  # Используем заданный цвет или белый по умолчанию
            }
            
            $icon = $config.Icons.Files[$extension]
            if (-not $icon) {
                $icon = $config.Icons.Default
            }
            
            Write-Host "$Indent├─ $icon" -NoNewline
            Write-Host " $displayName" -ForegroundColor $color
        }
    }
}

Export-ModuleMember -Function Show-ProjectStructure, Get-AvailablePlugins