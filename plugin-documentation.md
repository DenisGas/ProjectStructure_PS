# ProjectStructure PowerShell Module Plugin Development

## Overview
The ProjectStructure PowerShell module supports a plugin system that allows you to extend the default file and folder visualization configuration. This documentation explains how to create, install, and use plugins.

## Plugin Structure
Plugins are PowerShell Data Files (`.psd1`) that contain configuration settings for specific file types, folders, and icons. They should be placed in the `plugins` directory of the module.

### Basic Plugin Structure
```powershell
@{
    # Default colors for files and folders (optional)
    Defaults = @{
        FolderColor = "Yellow"
        FileColor = "Gray"
    }

    # File configurations
    Files = @{
        ".extension" = @{
            Color = "Blue"  # PowerShell console colors
        }
    }

    # Folder configurations
    Folders = @{
        "foldername" = @{
            Color = "Green"
            Ignore = $false  # Optional: Set to $true to ignore this folder
        }
    }

    # Icon configurations
    Icons = @{
        Files = @{
            ".extension" = "🔵"  # Unicode character or emoji
        }
    }
}
```

## Installation
1. Locate your module directory by running `Get-ProjectModulePath` in PowerShell
2. Place your plugin file in the `plugins` subdirectory
3. Name your plugin file with a `.psd1` extension (e.g., `images.psd1`)

## Usage
```powershell
# Show structure using specific plugins
Show-ProjectStructure -Path "C:\MyProject" -EnabledPlugins @("images", "documents")

# Show structure without styling
Show-ProjectStructure -Path "C:\MyProject" -NoStyle

# Show structure with all available plugins
Show-ProjectStructure -Path "C:\MyProject"
```

## Available Colors
PowerShell console colors that can be used in plugins:
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

## Best Practices
1. Use descriptive plugin names that reflect their purpose
2. Group related file types in a single plugin
3. Use appropriate colors for better visibility
4. Choose unicode icons that are well-supported across different terminals
5. Document any special configurations or requirements

## Example Plugin
Here's a simple example plugin for image files:
```powershell
@{
    Files = @{
        ".jpg" = @{
            Color = "Magenta"
        }
        ".png" = @{
            Color = "Magenta"
        }
    }
    Icons = @{
        Files = @{
            ".jpg" = "🖼️"
            ".png" = "🖼️"
        }
    }
}
```
