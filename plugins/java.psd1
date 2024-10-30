@{
    Files   = @{
        # Java Source
        ".java"        = @{
            Color = "Green"
        }
        ".jar"         = @{
            Color = "DarkGreen"
        }
        ".class"       = @{
            Color = "DarkGreen"
        }
        
        # Project Build Files
        ".gradle"      = @{
            Color = "Yellow"
        }
        ".properties"  = @{
            Color = "Yellow"
        }
        "build.gradle" = @{
            Color = "Yellow"
        }
        "pom.xml"      = @{
            Color = "Yellow"
        }
    }

    Icons   = @{
        Files = @{
            # Java Source
            ".java"        = "☕"
            ".jar"         = "📦"
            ".class"       = "📂"
            
            # Project Build Files
            ".gradle"      = "🛠️"
            ".properties"  = "⚙️"
            "build.gradle" = "🛠️"
            "pom.xml"      = "🛠️"
        }
    }

    Folders = @{
        "bin"   = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "build" = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "out"   = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "src"   = @{
            Color = "Blue"
        }
        "test"  = @{
            Color = "Yellow"
        }
        "lib"   = @{
            Color = "DarkMagenta"
        }
    }
}
