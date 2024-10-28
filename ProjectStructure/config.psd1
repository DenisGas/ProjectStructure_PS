@{
    # Плагины, которые будут включены по умолчанию
    # Если пустой массив или отсутствует - используются все доступные плагины
    EnabledPlugins = @(
        "web",
        "python"
    )
    
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