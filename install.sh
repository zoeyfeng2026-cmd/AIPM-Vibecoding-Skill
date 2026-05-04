#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"

echo "AIPM-Vibecoding-Skill installer"
echo ""

# Check if skills directory exists
if [ ! -d "$SKILLS_DIR" ]; then
  echo "Error: skills/ directory not found"
  exit 1
fi

# Create target directories
mkdir -p "$HOME/.agents/skills"
mkdir -p "$HOME/.claude/skills"

# Install each skill
for skill_path in "$SKILLS_DIR"/*/; do
  skill_name=$(basename "$skill_path")
  agents_target="$HOME/.agents/skills/$skill_name"
  claude_target="$HOME/.claude/skills/$skill_name"

  echo "Installing $skill_name..."

  # Remove old version
  if [ -e "$agents_target" ]; then
    echo "  Removing existing $agents_target"
    rm -rf "$agents_target"
  fi

  # Copy files
  echo "  → $agents_target"
  cp -r "$skill_path" "$agents_target"

  # Create symlink
  if [ -e "$claude_target" ]; then
    rm -f "$claude_target"
  fi
  ln -sf "../../.agents/skills/$skill_name" "$claude_target"
  echo "  → $claude_target (symlink)"
done

echo ""
echo "Done! Installed skills:"
for skill_path in "$SKILLS_DIR"/*/; do
  skill_name=$(basename "$skill_path")
  echo "  - $skill_name (trigger: /$skill_name)"
done
echo ""
echo "Open Claude Code and type /<skill-name> to use."
