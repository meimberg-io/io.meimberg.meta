#!/bin/bash
# Setup script to symlink cursor rules into a project
# Usage: ./setup.sh /path/to/your-project

set -e

if [ -z "$1" ]; then
    echo "Usage: ./setup.sh /path/to/your-project"
    echo ""
    echo "This will create a symlink from this repository's .cursor/rules"
    echo "into your project's .cursor/rules directory."
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

# Calculate relative path from project to rules
RELATIVE_PATH="$(realpath --relative-to="$PROJECT_PATH/.cursor" "$RULES_SOURCE")"

echo "📂 Source: $RULES_SOURCE"
echo "📂 Target: $RULES_TARGET"
echo "🔗 Relative path: $RELATIVE_PATH"
echo ""

# Create .cursor directory if it doesn't exist
if [ ! -d "$PROJECT_PATH/.cursor" ]; then
    echo "📁 Creating .cursor directory..."
    mkdir -p "$PROJECT_PATH/.cursor"
fi

# Remove existing if present (force with unlink if rm fails)
if [ -e "$RULES_TARGET" ] || [ -L "$RULES_TARGET" ]; then
    echo "⚠️  Removing existing: $RULES_TARGET"
    unlink "$RULES_TARGET" 2>/dev/null || rm -rf "$RULES_TARGET"
fi

# Create relative symlink
(cd "$PROJECT_PATH/.cursor" && ln -s "$RELATIVE_PATH" rules)

echo "✅ Successfully linked cursor rules (using relative path)!"
echo ""
echo "Your project now has access to:"
ls -1 "$RULES_SOURCE"/*.mcp | xargs -n1 basename

