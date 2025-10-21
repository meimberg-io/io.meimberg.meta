# Project Templates

Ready-to-use boilerplate templates for new projects in the meimberg.io infrastructure.

## Available Templates

### 📦 Next.js Template (`nextjs/`)

Complete, production-ready Next.js boilerplate with:
- ✅ Next.js 15 + React 19 + TypeScript
- ✅ Tailwind CSS 4
- ✅ Docker multi-stage build
- ✅ Docker Compose (dev & prod)
- ✅ GitHub Actions CI/CD
- ✅ Traefik integration (auto SSL)
- ✅ Jest testing
- ✅ Comprehensive documentation

**See:** [`nextjs/README.md`](nextjs/README.md) for full documentation.

**Quick start:**
```bash
cp -r nextjs ../io.meimberg.YOURPROJECT
cd ../io.meimberg.YOURPROJECT
# Follow doc/SETUP-CHECKLIST.md
```

---

## Creating New Templates

When adding new templates (Vue, React, Strapi, etc.):

### Structure
```
template-name/
├── doc/
│   ├── SETUP-CHECKLIST.md     # Quick setup checklist
│   ├── GITHUB-SETUP.md        # GitHub configuration
│   ├── DEPLOYMENT.md          # Operations guide
│   └── DOCKER-COMPOSE.md      # Docker Compose usage
├── _TEMPLATE_INFO.md          # Template documentation
├── README.md                  # Project README (customize for each project)
├── Dockerfile                 # Production build
├── docker-compose.yml         # Unified compose (dev/prod profiles)
├── docker-compose.prod.yml    # Reference: server deployment config
├── .github/workflows/         # CI/CD pipeline
├── env.example                # Environment template
├── .gitignore                 # Git ignore
└── src/                       # Source code
```

### Requirements

Every template should include:

1. **Complete working code** - Must build and run out of the box
2. **Docker setup** - Multi-stage Dockerfile
3. **Docker Compose** - Dev, prod, and unified versions
4. **CI/CD pipeline** - GitHub Actions workflow
5. **Documentation** - All .md files (see structure above)
6. **Environment config** - env.example with all variables
7. **Traefik labels** - In docker-compose section of workflow
8. **Tests** - Basic testing setup
9. **Placeholders** - Use `myapp`, `MYAPP`, `5678` for easy search/replace

### Template Checklist

- [ ] Works locally (`npm install && npm run dev`)
- [ ] Docker builds successfully (`docker build -t test .`)
- [ ] Docker Compose works (dev & prod modes)
- [ ] Tests pass
- [ ] All placeholder names are consistent
- [ ] Documentation is comprehensive (5+ .md files)
- [ ] SETUP-CHECKLIST.md has step-by-step instructions
- [ ] GitHub Actions workflow is complete
- [ ] Traefik integration is configured
- [ ] Based on working production project

---

## Usage Guide

### For New Projects

1. **Copy template:**
   ```bash
   cp -r project-templates/nextjs ../io.meimberg.yourproject
   ```

2. **Follow setup guide:**
   - Open `doc/SETUP-CHECKLIST.md`
   - Complete each step
   - Deploy!

### For Template Maintenance

1. **Test thoroughly** before committing changes
2. **Update version** in `_TEMPLATE_INFO.md`
3. **Document changes** in template README
4. **Test with fresh copy** to ensure it works

---

## Template Philosophy

✅ **Complete** - Everything needed to deploy  
✅ **Documented** - Comprehensive guides  
✅ **Production-ready** - Based on working projects  
✅ **Simple** - Easy to understand and customize  
✅ **Consistent** - Same structure across templates  
✅ **Docker-first** - Both local and production use containers  

❌ **Not minimal** - Includes testing, docs, CI/CD  
❌ **Not abstract** - Concrete working examples  
❌ **Not generic** - Tailored for meimberg.io infrastructure  

---

## Docker Compose Strategy

Each template includes **two** docker-compose files:

1. **`docker-compose.yml`** - Unified file with profiles
   - Use `docker compose --profile dev up` for development (with volume mounts)
   - Use `docker compose --profile prod up` for production testing (no volumes)
   - Single file to maintain, based on working projects
   
2. **`docker-compose.prod.yml`** - Reference/documentation
   - Shows what GitHub Actions creates on the server
   - Includes Traefik labels for automatic SSL/routing
   - Not used locally, only on production server

**Rationale:** This matches the structure of working projects (monstermemory, awesomeapps.frontend) and keeps things simple while providing both development and production workflows.

---

## Related Documentation

- [Ansible Structure](../doc/ANSIBLE-STRUCTURE.md) - Infrastructure overview
- Individual template READMEs - Specific template docs

---

**Last Updated:** October 2025
