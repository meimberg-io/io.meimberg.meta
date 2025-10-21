# Next.js Project Template

This is a complete, production-ready Next.js boilerplate template for the meimberg.io infrastructure.

## What's Included

### ✅ Complete Project Structure
```
nextjs/
├── .github/workflows/
│   └── deploy.yml              # CI/CD pipeline (test, build, push, deploy)
├── doc/
│   ├── GITHUB-SETUP.md         # Complete setup guide
│   ├── DEPLOYMENT.md           # Operations & troubleshooting
│   └── SETUP-CHECKLIST.md      # Quick setup reference
├── src/
│   └── app/
│       ├── layout.tsx          # Root layout with metadata
│       ├── page.tsx            # Homepage with Tailwind styling
│       └── globals.css         # Tailwind imports
├── public/                     # Static assets
├── Dockerfile                  # Multi-stage production build
├── package.json                # Dependencies (Next.js 15, React 19, Tailwind 4)
├── next.config.ts              # Next.js config with standalone output
├── tsconfig.json               # TypeScript configuration
├── tailwind.config.ts          # Tailwind CSS configuration
├── postcss.config.mjs          # PostCSS configuration
├── eslint.config.mjs           # ESLint configuration
├── jest.config.js              # Jest testing setup
├── jest.setup.js               # Jest setup file
├── env.example                 # Environment variables template
├── .gitignore                  # Git ignore rules
└── README.md                   # Project documentation
```

### 🚀 Features

- **Next.js 15** with App Router
- **React 19** with Server Components
- **TypeScript** strict mode
- **Tailwind CSS 4** for styling
- **Docker** multi-stage production build
- **GitHub Actions** complete CI/CD pipeline
- **Traefik** integration labels (automatic SSL)
- **Jest** testing framework
- **ESLint** code quality
- **Production-ready** configuration

### 📦 Tech Stack

| Component | Version | Purpose |
|-----------|---------|---------|
| Next.js | 15.5.4 | React framework |
| React | 19.1.0 | UI library |
| TypeScript | 5.x | Type safety |
| Tailwind CSS | 4.x | Styling |
| Node.js | 20 (Alpine) | Runtime |
| Docker | Multi-stage | Container |
| GitHub Actions | Latest | CI/CD |
| Traefik | v2+ | Reverse proxy |

### 🎯 Use Cases

Perfect for:
- ✅ Marketing websites
- ✅ Landing pages
- ✅ Web applications
- ✅ SaaS products
- ✅ Dashboards
- ✅ Blogs
- ✅ E-commerce frontends
- ✅ API-connected apps

### 📝 Documentation

The template includes comprehensive documentation:

1. **README.md** - Main project documentation with quick start guide
2. **doc/SETUP-CHECKLIST.md** - Step-by-step checklist for new projects
3. **doc/GITHUB-SETUP.md** - GitHub configuration and first deployment
4. **doc/DEPLOYMENT.md** - Operations, troubleshooting, and advanced topics

### 🔧 Customization Points

When creating a new project, you'll need to customize:

**Required:**
- App name (search/replace `myapp`, `MYAPP`, `My App`)
- Port number (search/replace `5678`)
- Domain name (in doc/GITHUB-SETUP.md, deploy.yml)
- Metadata (in src/app/layout.tsx)
- Content (in src/app/page.tsx)

**Optional:**
- Dependencies (add to package.json)
- Environment variables (add to env.example, workflow)
- Database services (add to docker-compose in workflow)
- Additional pages/components (in src/app/)
- Styling (customize Tailwind config)

### ⚡ Quick Start

```bash
# 1. Copy template
cp -r project-templates/nextjs ../io.meimberg.yourproject

# 2. Update app name in all files (see doc/SETUP-CHECKLIST.md)

# 3. Install and test
cd ../io.meimberg.yourproject
npm install
npm run dev

# 4. Setup GitHub, DNS, deploy
# Follow doc/GITHUB-SETUP.md

# 5. Deploy
git push origin main
```

### 🎨 What the Default App Looks Like

The template includes a beautiful, modern landing page with:
- Gradient background (blue to indigo)
- Centered hero section
- Call-to-action buttons
- Getting started card
- Responsive design
- Tailwind CSS styling

Ready to customize or replace with your own design!

### 🔒 Security Features

- ✅ Non-root Docker user
- ✅ Minimal Alpine base image
- ✅ No sensitive data in image
- ✅ Environment variable support
- ✅ HTTPS via Traefik (Let's Encrypt)
- ✅ Automated security updates via rebuilds

### 📊 Build & Deploy Stats

- **Docker image size**: ~150-200 MB (standalone output)
- **Build time**: 2-3 minutes (GitHub Actions)
- **Deploy time**: 30-60 seconds (pull + restart)
- **Total time**: ~3-4 minutes per deployment

### 🆘 Support

Need help?
- Check the comprehensive documentation in `README.md` and `doc/` directory
- Review existing projects: `io.meimberg.monstermemory`, `io.meimberg.www`
- Check infrastructure docs: `../../doc/ANSIBLE-STRUCTURE.md`

### 📅 Maintenance

This template is based on working projects (monstermemory, awesomeapps.frontend) and includes:
- Latest stable versions (as of creation)
- Best practices from production deployments
- Proven configuration and workflows

**Note:** When updating the template, test thoroughly and update this document.

---

**Created:** Based on production projects `io.meimberg.monstermemory` and `awesomeapps.frontend`

**Last Updated:** October 2025

**Version:** 1.0.0

