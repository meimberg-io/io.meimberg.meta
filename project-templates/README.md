# Project Templates

Ready-to-use boilerplate templates for new projects in the meimberg.io infrastructure.

## Available Templates

### 📦 Next.js Template (`nextjs/`)

Complete, production-ready Next.js boilerplate with:
- ✅ Next.js 15 + React 19 + TypeScript
- ✅ Tailwind CSS 4
- ✅ Docker multi-stage build
- ✅ GitHub Actions CI/CD
- ✅ Traefik integration (auto SSL)
- ✅ Jest testing
- ✅ Comprehensive documentation

**See:** [`nextjs/README.md`](nextjs/README.md) for full documentation.

**Quick start:**
```bash
cp -r nextjs ../io.meimberg.YOURPROJECT
cd ../io.meimberg.YOURPROJECT
# Follow SETUP-CHECKLIST.md
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
│   └── DEPLOYMENT.md          # Operations guide
├── _TEMPLATE_INFO.md          # Template documentation
├── README.md                  # Project README (customize for each project)
├── Dockerfile                 # Production build
├── .github/workflows/         # CI/CD pipeline
├── env.example                # Environment template
├── .gitignore                 # Git ignore
└── src/                       # Source code
```

### Requirements

Every template should include:

1. **Complete working code** - Must build and run out of the box
2. **Docker setup** - Multi-stage Dockerfile
3. **CI/CD pipeline** - GitHub Actions workflow
4. **Documentation** - All .md files
5. **Environment config** - env.example with all variables
6. **Traefik labels** - In docker-compose section
7. **Tests** - Basic testing setup
8. **Placeholders** - Use `myapp`, `MYAPP`, `5678` for easy search/replace

### Template Checklist

- [ ] Works locally (`npm install && npm run dev`)
- [ ] Docker builds successfully
- [ ] Tests pass
- [ ] All placeholder names are consistent
- [ ] Documentation is comprehensive
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

❌ **Not minimal** - Includes testing, docs, CI/CD  
❌ **Not abstract** - Concrete working examples  
❌ **Not generic** - Tailored for meimberg.io infrastructure  

---

## Related Documentation

- [Ansible Structure](../doc/ANSIBLE-STRUCTURE.md) - Infrastructure overview
- Individual template READMEs - Specific template docs

---

**Last Updated:** October 2025

