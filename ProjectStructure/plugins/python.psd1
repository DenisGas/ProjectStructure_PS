@{
    Files   = @{
        # Python файлы
        ".py"               = @{
            Color = "Blue"
        }
        ".pyw"              = @{
            Color = "Blue"
        }
        ".pyx"              = @{
            Color = "DarkBlue"
        }
        ".pxd"              = @{
            Color = "DarkBlue"
        }
        ".pxi"              = @{
            Color = "DarkBlue"
        }
        ".pyc"              = @{
            Color = "DarkGray"
        }
        ".pyo"              = @{
            Color = "DarkGray"
        }
        ".pyd"              = @{
            Color = "DarkGray"
        }
        
        # Конфигурационные файлы Python
        ".pip"              = @{
            Color = "Yellow"
        }
        ".toml"             = @{
            Color = "Cyan"
        }
        ".cfg"              = @{
            Color = "DarkYellow"
        }
        ".ini"              = @{
            Color = "DarkYellow"
        }
        ".requirements.txt" = @{
            Color = "Green"
        }
        "requirements.txt"  = @{
            Color = "Green"
        }
        "Pipfile"           = @{
            Color = "Magenta"
        }
        "setup.py"          = @{
            Color = "Yellow"
        }
    }

    Icons   = @{
        Files = @{
            # Python файлы
            ".py"               = "🐍"
            ".pyw"              = "🐍"
            ".pyx"              = "🔧"
            ".pxd"              = "🔧"
            ".pxi"              = "🔧"
            ".pyc"              = "📦"
            ".pyo"              = "📦"
            ".pyd"              = "📦"
            
            # Конфигурационные файлы
            ".pip"              = "📋"
            ".toml"             = "⚙️"
            ".cfg"              = "⚙️"
            ".ini"              = "⚙️"
            ".requirements.txt" = "📝"
            "requirements.txt"  = "📝"
            "Pipfile"           = "📦"
            "setup.py"          = "🛠️"
        }
    }

    # Специальные папки для Python проектов
    Folders = @{
        "venv"        = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        ".venv"       = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "env"         = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "__pycache__" = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "tests"       = @{
            Color = "Magenta"
        }
        "test"        = @{
            Color = "Magenta"
        }
        "docs"        = @{
            Color = "Yellow"
        }
        "examples"    = @{
            Color = "Green"
        }
        "src"         = @{
            Color = "Blue"
        }
        "scripts"     = @{
            Color = "Cyan"
        }
        "migrations"  = @{
            Color = "DarkYellow"
        }
        "static"      = @{
            Color = "Green"
        }
        "templates"   = @{
            Color = "DarkCyan"
        }
    }
}