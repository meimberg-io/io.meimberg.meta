# Next.js Project Boilerplate

Ready-to-use Next.js template with Docker, GitHub Actions, and Traefik integration.

## 🚀 Quick Start (New Project)

### 1. Copy Template

```bash
# Create new project
cp -r project-templates/nextjs ../io.meimberg.YOURPROJECT

cd ../io.meimberg.YOURPROJECT
```

### 2. Update Project Name

**Search and replace in ALL files:**
- `myapp` → your app name (lowercase, no spaces)
- `MYAPP` → your app name (uppercase)
- `My App` → your app display name
- `5678` → your port number (choose unique port 3000-9999)

**Files to update:**
- `.github/workflows/deploy.yml` (multiple places)
- `package.json` (name field)
- `Dockerfile` (EXPOSE and ENV PORT)
- `README.md`
- `GITHUB-SETUP.md`
- `DEPLOYMENT.md`
- `src/app/layout.tsx` (title/description)

### 3. Setup Environment

```bash
# Copy environment file
cp env.example .env

# Edit .env with your values
nano .env
```

### 4. Local Development

```bash
# Install dependencies
npm install

# Run development server
npm run dev
# Visit http://localhost:3000

# Test Docker build
docker build -t myapp .
docker run -p 5678:5678 myapp
```

### 5. Initialize Git

```bash
git init
git add .
git commit -m "Initial commit"

# Create GitHub repo and push
git remote add origin git@github.com:USERNAME/io.meimberg.YOURPROJECT.git
git branch -M main
git push -u origin main
```

### 6. Configure GitHub

Follow instructions in **[GITHUB-SETUP.md](GITHUB-SETUP.md)**:

1. Add GitHub Variables (APP_DOMAIN, SERVER_HOST)
2. Add GitHub Secrets (SSH_PRIVATE_KEY)
3. Configure DNS (CNAME record)

### 7. Deploy

```bash
git push origin main
```

Your app will auto-deploy to production! 🎉

---

## 📦 What's Included

### Core Files
- ✅ **Next.js 15** with App Router and TypeScript
- ✅ **Tailwind CSS** for styling
- ✅ **Docker** multi-stage production build
- ✅ **GitHub Actions** CI/CD pipeline
- ✅ **ESLint** and Jest testing setup
- ✅ **Traefik** integration labels (auto SSL)

### Documentation
- 📝 `GITHUB-SETUP.md` - Complete setup guide
- 📝 `DEPLOYMENT.md` - Operations guide
- 📝 `README.md` - This file (customize for your app)

### Structure
```
.
├── .github/workflows/
│   └── deploy.yml          # CI/CD pipeline
├── doc/                    # Documentation
│   ├── SETUP-CHECKLIST.md  # Setup guide
│   ├── GITHUB-SETUP.md     # GitHub config
│   └── DEPLOYMENT.md       # Operations
├── src/
│   └── app/
│       ├── layout.tsx      # Root layout
│       ├── page.tsx        # Home page
│       └── globals.css     # Global styles
├── public/                 # Static assets
├── Dockerfile              # Production build
├── docker-compose.yml      # Unified compose (dev/prod profiles)
├── docker-compose.prod.yml # Reference: GitHub Actions creates this
├── next.config.ts          # Next.js config
├── tailwind.config.ts      # Tailwind config
├── tsconfig.json           # TypeScript config
├── package.json            # Dependencies
├── env.example             # Environment template
└── .gitignore              # Git ignore rules
```

---

## 🛠 Development

### Commands

```bash
npm run dev          # Development server (port 3000)
npm run build        # Production build
npm run start        # Production server
npm run lint         # Run ESLint
npm run test         # Run tests
npm run test:ci      # Tests with coverage
```

### Docker Development

**Using Docker Compose (Recommended)**

```bash
# Development mode (with volume mounts)
docker compose --profile dev up

# Production mode (test production build locally)
docker compose --profile prod up

# Rebuild and start
docker compose --profile dev up --build

# Stop
docker compose --profile dev down
```

**Using Docker directly**

```bash
# Build image
docker build -t myapp .

# Run container
docker run -p 5678:5678 myapp

# With environment variables
docker run -p 5678:5678 -e NODE_ENV=production myapp
```

---

## 🌐 Deployment

### Prerequisites

**One-time infrastructure setup** (already done for meimberg.io):
- ✅ Ansible infrastructure (Docker, Traefik, deploy user)
- ✅ DNS access
- ✅ GitHub repository

### Deployment Flow

```
git push origin main
    ↓
GitHub Actions runs:
    ↓
1. Tests (lint, build, jest)
    ↓
2. Build Docker image
    ↓
3. Push to GitHub Container Registry
    ↓
4. SSH to server as deploy user
    ↓
5. Create docker-compose.yml with Traefik labels
    ↓
6. docker compose pull && up -d
    ↓
✅ Live at https://your-app.meimberg.io
```

**Time:** ~3-4 minutes per deployment

---

## 📚 Documentation

- **[GITHUB-SETUP.md](doc/GITHUB-SETUP.md)** - Initial setup checklist
- **[DEPLOYMENT.md](doc/DEPLOYMENT.md)** - Operations & troubleshooting
- **[DOCKER-COMPOSE.md](doc/DOCKER-COMPOSE.md)** - Docker Compose usage guide
- **[Ansible Structure](../../doc/ANSIBLE-STRUCTURE.md)** - Infrastructure overview

---

## 🔧 Customization

### Add Dependencies

```bash
npm install your-package
```

### Add Environment Variables

1. Add to `env.example`
2. Add to `.env` (local)
3. Add to Dockerfile (if needed at build time)
4. Add to GitHub Secrets/Variables (production)
5. Update docker-compose section in `.github/workflows/deploy.yml`

### Add Database

See examples in `awesomeapps.frontend` for PostgreSQL/MySQL integration.

---

## 🐛 Troubleshooting

**Build fails:**
- Check `output: 'standalone'` in `next.config.ts`
- Verify all dependencies in `package.json`

**Container starts but 502:**
- Wrong port in Traefik labels
- App not listening on correct port

**SSL not working:**
- Wait 2 minutes for Let's Encrypt
- Check DNS with `dig your-app.meimberg.io +short`
- Check Traefik logs: `ssh root@hc-02.meimberg.io "docker logs traefik | grep myapp"`

---

## 📝 License

MIT License


