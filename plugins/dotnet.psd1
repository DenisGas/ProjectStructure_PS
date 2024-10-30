@{
    Files   = @{
        # C#
        ".cs"     = @{
            Color = "Green"
        }
        ".csproj" = @{
            Color = "DarkGreen"
        }
        ".sln"    = @{
            Color = "DarkGreen"
        }
        
        # Visual Basic
        ".vb"     = @{
            Color = "Blue"
        }
        ".vbproj" = @{
            Color = "DarkBlue"
        }
        
        # F#
        ".fs"     = @{
            Color = "Magenta"
        }
        ".fsproj" = @{
            Color = "DarkMagenta"
        }
        
        # .NET Config
        ".config" = @{
            Color = "Yellow"
        }
        ".json"   = @{
            Color = "Yellow"
        }
    }

    Icons   = @{
        Files = @{
            # C#
            ".cs"     = "🔷"
            ".csproj" = "📦"
            ".sln"    = "🎯"
            
            # Visual Basic
            ".vb"     = "🔶"
            ".vbproj" = "📦"
            
            # F#
            ".fs"     = "🔸"
            ".fsproj" = "📦"
            
            # .NET Config
            ".config" = "⚙️"
            ".json"   = "⚙️"
        }
    }

    Folders = @{
        "bin"     = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "obj"     = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "Debug"   = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "Release" = @{
            Color  = "DarkGray"
            Ignore = $true
        }
        "src"     = @{
            Color = "Blue"
        }
        "tests"   = @{
            Color = "Yellow"
        }
    }
}