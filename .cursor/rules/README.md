# Cursor Rules Collection

This directory contains reusable `.mdc` (Markdown with frontmatter) Cursor Rules files for different project types.

## Available Rules

| File | Purpose |
|------|---------|
| `chatstyle.mdc` | Chat response style and behavior |
| `oli.mdc` | Base rules for all projects (style, security, git protection) |
| `documentation.mdc` | Markdown documentation standards (compact, factual) |
| `nextjs.mdc` | Next.js 15 App Router frontend projects |
| `strapi.mdc` | Strapi 5.x backend/CMS projects |
| `devops.mdc` | Docker, CI/CD, GitHub Actions, deployment |
| `automation.mdc` | AI workflows and automation guidelines |

## Usage

### In Your Projects

Use the `setup.sh` script to create symlinks in your project:

```bash
# From the io.meimberg.meta directory
./setup.sh /path/to/your-project
```

This creates individual symlinks for each `.mdc` file in your project's `.cursor/rules/` directory.

### Customization

You can:
- Remove individual rule symlinks if not needed for a specific project
- Add project-specific rules by creating additional `.mdc` files in your project's `.cursor/rules/` directory

Cursor automatically loads and merges all `.mdc` files.

## Rule Structure

Each `.mdc` file contains YAML frontmatter followed by markdown content:

```markdown
---
title: Rule Title
description: Short description
globs: ["**/*.ts", "app/**"]
autoAttach: true
alwaysApply: true
---

# Section Title

- Rule content in markdown format
- Guidelines, conventions, best practices
```

### Frontmatter Options

- `title`: Display name for the rule
- `description`: Short description
- `globs`: File patterns this rule applies to
- `autoAttach`: Automatically attach when matching files are opened
- `alwaysApply`: Always apply this rule globally

## Contributing

When adding new rules:
- Keep rules focused on a specific domain
- Document with comments at the top
- Follow existing formatting conventions
- Test in a real project before committing

