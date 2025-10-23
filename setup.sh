#!/bin/bash
# Setup script to symlink cursor rules into a project
# Usage: ./setup.sh /path/to/your-project [rule-name]

set -e

if [ -z "$1" ]; then
    echo "Usage: ./setup.sh /path/to/your-project [rule-name]"
    echo ""
    echo "Without rule-name: creates symlinks for all rule files"
    echo "With rule-name: creates symlink for single rule file (without .mdc extension)"
    echo ""
    echo "Examples:"
    echo "  ./setup.sh /path/to/project              # Link all rules"
    echo "  ./setup.sh /path/to/project nextjs       # Link only nextjs.mdc"
    exit 1
fi

PROJECT_PATH="$1"
SINGLE_RULE="$2"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RULES_SOURCE="$SCRIPT_DIR/.cursor/rules"

if [ ! -d "$PROJECT_PATH" ]; then
    echo "❌ Error: Project directory does not exist: $PROJECT_PATH"
    exit 1
fi

# Convert to absolute path
PROJECT_PATH="$(cd "$PROJECT_PATH" && pwd)"
RULES_TARGET="$PROJECT_PATH/.cursor/rules"

# Validate single rule if specified
if [ -n "$SINGLE_RULE" ]; then
    if [ ! -f "$RULES_SOURCE/${SINGLE_RULE}.mdc" ]; then
        echo "❌ Error: Rule file does not exist: ${SINGLE_RULE}.mdc"
        echo ""
        echo "Available rules:"
        ls -1 "$RULES_SOURCE"/*.mdc 2>/dev/null | xargs -n1 basename | sed 's/\.mdc$//' | sed 's/^/  - /'
        exit 1
    fi
fi

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

# Link rule files
if [ -n "$SINGLE_RULE" ]; then
    # Link single rule
    echo "🔗 Creating symlink for ${SINGLE_RULE}.mdc..."
    rule_file="$RULES_SOURCE/${SINGLE_RULE}.mdc"
    filename="$(basename "$rule_file")"
    target_file="$RULES_TARGET/$filename"
    
    # Calculate relative path from target file to source file
    RELATIVE_PATH="$(realpath --relative-to="$RULES_TARGET" "$rule_file")"
    
    # Create symlink (force flag overwrites existing)
    ln -sf "$RELATIVE_PATH" "$target_file"
    echo "  ✓ $filename"
    
    echo ""
    echo "✅ Successfully linked $filename (using relative path)!"
else
    # Link all .mdc files
    echo "🔗 Creating symlinks for individual rule files..."
    LINKED_COUNT=0
    for rule_file in "$RULES_SOURCE"/*.mdc; do
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
    echo "   rm $RULES_TARGET/<rule-file>.mdc"
fi

