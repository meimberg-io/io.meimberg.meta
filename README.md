# Cursor Rules Meta Repository

Central collection and management of Cursor AI editor rules (`.mcp` files) for consistent, secure, and efficient AI-assisted development across all projects.

## 📋 Quick Start

### 1. Use in Your Project

**Using setup script (easiest):**
```bash
cd ~/io.meimberg.template
./setup.sh /path/to/your-project
```

**Manual symlink:**
```bash
ln -s ~/io.meimberg.template/.cursor/rules /path/to/your-project/.cursor/rules
```

**Copy (independent):**
```bash
cp -r ~/io.meimberg.template/.cursor/rules /path/to/your-project/.cursor/
```

### 2. Cursor Auto-Loads Rules

All `.mcp` files are automatically detected and merged by Cursor. No additional configuration needed.

## 📦 Available Rules

| Rule File | Purpose |
|-----------|---------|
| **chatstyle.mcp** | Chat response style and behavior |
| **oli.mcp** | Base rules: style, security, git protection |
| **nextjs.mcp** | Next.js 15 App Router, React Server Components |
| **strapi.mcp** | Strapi 5.x CMS/API backend |
| **java.mcp** | Java, Spring Boot, Jakarta EE |
| **devops.mcp** | Docker, CI/CD, GitHub Actions, deployment |
| **n8n.mcp** | n8n workflow automation |
| **automation.mcp** | AI workflow guidelines |
| **experimental.mcp** | Testing sandbox |

## 🎯 Features

- ✅ Consistent code style across projects
- 🔒 Security protections for sensitive files
- 🚫 Git commit safeguards
- 📝 Framework-specific best practices
- 🛠️ DevOps and deployment guidelines
- 🔄 Easy updates via symlinks or git submodules

## 📖 Documentation

Full documentation: [`doc/CURSORRULES.md`](doc/CURSORRULES.md)

## 🏗️ Structure

```
.cursor/
└── rules/
    ├── chatstyle.mcp     # Chat response style
    ├── oli.mcp           # Base rules for all projects
    ├── nextjs.mcp        # Next.js frontend
    ├── strapi.mcp        # Strapi backend
    ├── java.mcp          # Java projects
    ├── devops.mcp        # Docker, CI/CD, deployment
    ├── n8n.mcp           # n8n automation
    ├── automation.mcp    # AI workflows
    └── experimental.mcp  # Testing sandbox
```

## 🚀 Tech Stack

- **Frontend:** Next.js 15 (App Router), React, TypeScript, Tailwind + DaisyUI
- **Backend:** Strapi 5.x, Node.js, Java/Spring Boot
- **DevOps:** Docker, GitHub Actions, CI/CD
- **Automation:** n8n workflows
- **Language:** TypeScript (preferred)

## 🔧 Usage in Projects

### Frontend (Next.js)
Symlink and get instant rules for:
- App Router conventions
- Server/client component separation
- Tailwind styling guidelines
- TypeScript best practices

### Backend (Strapi/Java)
Get rules for:
- API structure
- Business logic organization
- Security patterns
- Database access

### DevOps
Rules for:
- Docker best practices
- CI/CD pipeline security
- Deployment safeguards
- Infrastructure as code

## 📝 Contributing

When adding new rules:
1. Create a focused `.mcp` file in `.cursor/rules/`
2. Add header comment with purpose and version
3. Follow existing YAML structure
4. Update documentation
5. Test in real project

## 🔐 Security

Protected patterns include:
- `.env` files
- Private keys (`.pem`, `.key`)
- Secrets and credentials
- Git destructive commands
- Infrastructure credentials

## 📄 License

Private repository for personal/organizational use.

---

**Author:** Oli Meimberg  
**Version:** 1.0

