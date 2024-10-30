@{
    # Plugins that will be enabled by default
    # If the array is empty or missing, all available plugins are used
    EnabledPlugins = @(
        "web",
        "media",
        "documents"
    )

    Defaults       = @{
        FolderColor = "Yellow" # Default folder color
        FileColor   = "Gray" # Default file color
    }
    
    # Настройки папок
    Folders        = @{
        "dist" = @{
            Ignore = $false
            Color  = "DarkGray"
        }
    }
    
    # Настройки файлов
    Files          = @{
        ".md"        = @{
            Color = "Green"
        }
        ".gitignore" = @{
            Color = "DarkGray"
        }
    }
    
    # Иконки
    Icons          = @{
        Folder  = "📁"
        Default = "📄"
        Files   = @{
            ".md"        = "📝"
            ".gitignore" = "⚙️"
            ".json"      = "🔧"
        }
    }
}
