#!/bin/bash
# Setup script to symlink cursor rules into a project
# Usage: ./setup.sh /path/to/your-project

set -e

if [ -z "$1" ]; then
    echo "Usage: ./setup.sh /path/to/your-project"
    echo ""
    echo "This will create individual symlinks for each rule file"
    echo "from this repository's .cursor/rules into your project's .cursor/rules directory."
    echo "You can remove individual rule files later if not needed."
    exit 1
fi

PROJECT_PATH="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RULES_SOURCE="$SCRIPT_DIR/.cursor/rules"

if [ ! -d "$PROJECT_PATH" ]; then
    echo "❌ Error: Project directory does not exist: $PROJECT_PATH"
    exit 1
fi

# Convert to absolute path
PROJECT_PATH="$(cd "$PROJECT_PATH" && pwd)"
RULES_TARGET="$PROJECT_PATH/.cursor/rules"

echo "📂 Source: $RULES_SOURCE"
echo "📂 Target: $RULES_TARGET"
echo ""

# Create .cursor directory if it doesn't exist
if [ ! -d "$PROJECT_PATH/.cursor" ]; then
    echo "📁 Creating .cursor directory..."
    mkdir -p "$PROJECT_PATH/.cursor"
fi

# Handle existing rules directory
if [ -L "$RULES_TARGET" ]; then
    echo "⚠️  Removing existing rules directory symlink: $RULES_TARGET"
    rm "$RULES_TARGET"
fi

# Create rules directory if it doesn't exist
if [ ! -d "$RULES_TARGET" ]; then
    echo "📁 Creating rules directory..."
    mkdir -p "$RULES_TARGET"
fi

# Link each .mcp file individually
echo "🔗 Creating symlinks for individual rule files..."
LINKED_COUNT=0
for rule_file in "$RULES_SOURCE"/*.mcp; do
    if [ -f "$rule_file" ]; then
        filename="$(basename "$rule_file")"
        target_file="$RULES_TARGET/$filename"
        
        # Calculate relative path from target file to source file
        RELATIVE_PATH="$(realpath --relative-to="$RULES_TARGET" "$rule_file")"
        
        # Create symlink (force flag overwrites existing)
        ln -sf "$RELATIVE_PATH" "$target_file"
        echo "  ✓ $filename"
        LINKED_COUNT=$((LINKED_COUNT + 1))
    fi
done

echo ""
echo "✅ Successfully linked $LINKED_COUNT cursor rule files (using relative paths)!"
echo ""
echo "💡 Tip: You can remove individual rule symlinks if not needed for this project:"
echo "   rm $RULES_TARGET/<rule-file>.mcp"

