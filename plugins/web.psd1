@{
    Files   = @{
        # Web development

        ".html"   = @{
            Color = "DarkYellow"
        }
        ".htm"    = @{
            Color = "DarkYellow"
        }
        ".css"    = @{
            Color = "Blue"
        }
        ".scss"   = @{
            Color = "Magenta"
        }
        ".sass"   = @{
            Color = "Magenta"
        }
        ".less"   = @{
            Color = "Magenta"
        }
        ".js"     = @{
            Color = "Yellow"
        }
        ".jsx"    = @{
            Color = "Cyan"
        }
        ".ts"     = @{
            Color = "Blue"
        }
        ".tsx"    = @{
            Color = "Cyan"
        }
        ".vue"    = @{
            Color = "Green"
        }
        ".svelte" = @{
            Color = "Red"
        }

        # Configuration files

        ".json"   = @{
            Color = "Yellow"
        }
        ".crx"    = @{
            Color = "DarkCyan"
        }
        ".xpi"    = @{
            Color = "DarkCyan"
        }
        ".pem"    = @{
            Color = "DarkRed"
        }
        ".env"    = @{
            Color = "DarkGreen"
        }
        ".config" = @{
            Color = "DarkGray"
        }
        ".lock"   = @{
            Color = "DarkGray"
        }
    }

    Icons   = @{
        Files = @{
            # Web files

            ".html"   = "🌐"
            ".htm"    = "🌐"
            ".css"    = "🎨"
            ".scss"   = "🎨"
            ".sass"   = "🎨"
            ".less"   = "🎨"
            ".js"     = "📜"
            ".jsx"    = "⚛️"
            ".ts"     = "📘"
            ".tsx"    = "⚛️"
            ".vue"    = "🟢"
            ".svelte" = "🔥"
            
            # Configuration files

            ".json"   = "📋"
            ".crx"    = "🧩"
            ".xpi"    = "🧩"
            ".pem"    = "🔑"
            ".env"    = "⚙️"
            ".config" = "⚙️"
            ".lock"   = "🔒"
        }
    }

    # Special folders for web projects

    Folders = @{
        "node_modules" = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "dist"         = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "build"        = @{
            Color  = "DarkGray"
            Ignore = $false
        }
        "public"       = @{
            Color = "Green"
        }
        "src"          = @{
            Color = "Blue"
        }
        "assets"       = @{
            Color = "Magenta"
        }
        "components"   = @{
            Color = "Cyan"
        }
        "pages"        = @{
            Color = "Yellow"
        }
        "layouts"      = @{
            Color = "DarkYellow"
        }
        "styles"       = @{
            Color = "Blue"
        }
        "scripts"      = @{
            Color = "Yellow"
        }
        ".git"         = @{
            Color  = "DarkGray"
            Ignore = $true
        }
    }
}