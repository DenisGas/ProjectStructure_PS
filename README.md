# ProjectStructure_PS

## Overview
ProjectStructure is a PowerShell module for visualizing project structures with support for color formatting, icons, and a plugin system. The module allows you to visually display directory and file structures considering their types and purposes.


## Preview
![Preview](https://github.com/user-attachments/assets/c30e7ad7-c131-4206-afd8-a52cd50a6f4c)


## Installation

```powershell
# Clone repository
git clone https://github.com/DenisGas/ProjectStructure_PS.git

# Install module for current user
Copy-Item -Path .\ProjectStructure -Destination "$HOME\Documents\WindowsPowerShell\Modules" -Recurse
```

## Main Functions

### Show-ProjectStructure

Displays the project structure as a tree with color formatting and icons.

```powershell
# Basic usage
Show-ProjectStructure -Path "C:\MyProject"

# Show structure with specific depth
Show-ProjectStructure -Path "C:\MyProject" -Depth 3

# Use specific plugins
Show-ProjectStructure -Path "C:\MyProject" -EnabledPlugins @("python", "web")

# Display without styles and icons
Show-ProjectStructure -Path "C:\MyProject" -NoStyle
```

#### Parameters:
- `-Path` (required): Path to project directory
- `-Depth` (default: 2): Directory traversal depth (-1 for full traversal)
- `-EnabledPlugins`: Array of plugin names to use
- `-NoStyle`: Disables color formatting and icons
- `-ConfigPath`: Path to alternative configuration file

### Get-AvailablePlugins

Gets a list of available plugins.

```powershell
# View all available plugins
Get-AvailablePlugins
```

### Get-ProjectModulePath

Returns the path to the module directory.

```powershell
# Get module path
$modulePath = Get-ProjectModulePath
```

### Open-ProjectModuleFolder

Opens the module directory in Windows Explorer.

```powershell
# Open module folder
Open-ProjectModuleFolder
```

## Configuration

### Main Configuration File (config.psd1)

```powershell
@{
    # Default enabled plugins
    EnabledPlugins = @(
        "web",
        "python"
    )
    
    # Default settings
    Defaults = @{
        FolderColor = "Yellow"  # Default folder color
        FileColor = "Gray"      # Default file color
    }
    
    # Folder settings
    Folders = @{
        "dist" = @{
            Ignore = $false
            Color = "DarkGray"
        }
    }
    
    # File settings
    Files = @{
        ".md" = @{
            Color = "Green"
        }
    }
    
    # Icons
    Icons = @{
        Folder = "📁"
        Default = "📄"
        Files = @{
            ".md" = "📝"
        }
    }
}
```

## Color Scheme
Available colors for use in configuration:
- Black
- DarkBlue
- DarkGreen
- DarkCyan
- DarkRed
- DarkMagenta
- DarkYellow
- Gray
- DarkGray
- Blue
- Green
- Cyan
- Red
- Magenta
- Yellow
- White

## Usage Examples

### Basic Project Structure View
```powershell
Show-ProjectStructure -Path "C:\Projects\MyWebApp"
```

### View with Limited Depth
```powershell
# Show only first two levels
Show-ProjectStructure -Path "C:\Projects\MyWebApp" -Depth 2
```

### Using Specific Plugins
```powershell
# Use only web development and Python plugins
Show-ProjectStructure -Path "C:\Projects\MyWebApp" -EnabledPlugins @("web", "python")
```

### View Without Styles
```powershell
# Show structure without colors and icons
Show-ProjectStructure -Path "C:\Projects\MyWebApp" -NoStyle
```

### Working with Plugins
```powershell
# View available plugins
Get-AvailablePlugins

# Open module directory to install new plugins
Open-ProjectModuleFolder
```

## Usage Tips

1. **Optimal Depth**: For large projects, it's recommended to use the `-Depth` parameter to limit output and improve readability.

2. **Plugins**: Use only necessary plugins for specific projects. This will improve performance and make output more relevant.

3. **Customization**: Create your own plugins for specific file types or projects.

4. **Ignoring Folders**: Use the `Ignore = $true` parameter in folder configuration to hide service directories.

## Troubleshooting

### Issue: Icons Not Displaying
- Ensure your terminal supports Unicode
- Check terminal font settings

### Issue: Plugin Settings Not Applied
- Verify plugin file location in plugins directory
- Ensure plugin name is listed in EnabledPlugins
- Check plugin configuration file syntax

### Issue: Incorrect Colors
- Ensure PowerShell supported colors are used
- Check terminal color scheme settings

## Extending Functionality

### Creating Custom Plugin
1. Create new `.psd1` file in plugins directory
2. Define settings for files, folders, and icons
3. Add plugin name to EnabledPlugins in main config or function call

### Customizing Existing Plugins
1. Open module directory: `Open-ProjectModuleFolder`
2. Find desired plugin in plugins folder
3. Edit settings to your needs

[Plugin Documentation](plugin-documentation.md)

## Configuration Examples for Different Project Types

### Web Project
```powershell
Show-ProjectStructure -Path "C:\WebProject" -EnabledPlugins @("web", "documents")
```

### Python Project
```powershell
Show-ProjectStructure -Path "C:\PythonProject" -EnabledPlugins @("python", "documents")
```

### .NET Project
```powershell
Show-ProjectStructure -Path "C:\DotNetProject" -EnabledPlugins @("dotnet", "documents")
```

## Best Practices

1. **Project Organization**:
   - Use standard directory names (src, docs, tests)
   - Group files by type and purpose

2. **Configuration**:
   - Keep settings organized by category
   - Use meaningful colors for different file types
   - Choose intuitive icons

3. **Performance**:
   - Limit traversal depth for large projects
   - Ignore unnecessary directories
   - Enable only required plugins

## Updates and Support

For latest updates and information about new features:
1. Regularly check project repository
2. Monitor documentation changes
3. Check for new plugins

## Contributing

If you want to contribute to project development:
1. Fork the repository
2. Create a branch for your changes
3. Make changes and create pull request
4. Describe your changes and their purpose
