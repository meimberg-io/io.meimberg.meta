# Setup Checklist for New Project

Quick reference checklist when creating a new project from this template.

## 1. Copy Template

```bash
cp -r project-templates/nextjs ../io.meimberg.YOURPROJECT
cd ../io.meimberg.YOURPROJECT
```

## 2. Search & Replace

**Find and replace in ALL files:**

| Search for | Replace with | Description |
|------------|--------------|-------------|
| `myapp` | `yourappname` | App name (lowercase) |
| `MYAPP` | `YOURAPPNAME` | App name (uppercase) |
| `My App` | `Your App Name` | Display name |
| `5678` | `3001` | Port number (choose unique) |

**Files that need updates:**
- [ ] `.github/workflows/deploy.yml` (multiple places)
- [ ] `package.json` (name field)
- [ ] `Dockerfile` (EXPOSE and ENV PORT)
- [ ] `README.md` (title, descriptions)
- [ ] `doc/GITHUB-SETUP.md` (domain references)
- [ ] `doc/DEPLOYMENT.md` (commands, paths)
- [ ] `src/app/layout.tsx` (metadata)
- [ ] `src/app/page.tsx` (content)

## 3. Environment Setup

```bash
cp env.example .env
# Edit .env with your values
```

## 4. Install & Test

```bash
npm install
npm run dev         # Test locally
npm run test:ci     # Run tests
```

## 5. Git Init

```bash
git init
git add .
git commit -m "Initial commit from template"
```

## 6. GitHub Repository

1. Create repo on GitHub: `io.meimberg.YOURPROJECT`
2. Make repo public or configure package access
3. Push code:
   ```bash
   git remote add origin git@github.com:USERNAME/io.meimberg.YOURPROJECT.git
   git branch -M main
   git push -u origin main
   ```

## 7. GitHub Variables

**Settings → Secrets and variables → Actions → Variables**

- [ ] `APP_DOMAIN` = `yourapp.meimberg.io`
- [ ] `SERVER_HOST` = `hc-02.meimberg.io`
- [ ] `SERVER_USER` = `deploy` (optional)

## 8. GitHub Secrets

**Settings → Secrets and variables → Actions → Secrets**

- [ ] `SSH_PRIVATE_KEY` = (deploy user key - already exists)
- [ ] Add any app-specific secrets

## 9. DNS Configuration

- [ ] Create CNAME: `yourapp.meimberg.io` → `hc-02.meimberg.io`
- [ ] Wait for propagation (test with `dig yourapp.meimberg.io`)

## 10. Deploy

```bash
git push origin main
```

- [ ] Watch GitHub Actions
- [ ] Verify deployment successful
- [ ] Test app at `https://yourapp.meimberg.io`

---

## Common Gotchas

❌ **Forgot to update app name in workflow** → Wrong container name on server  
❌ **Port conflicts** → Another app using same port → Change port number  
❌ **DNS not configured** → SSL fails → Add CNAME record  
❌ **Package private** → Image pull fails → Make package public or configure access  
❌ **Wrong SSH key** → Deploy fails → Check SSH_PRIVATE_KEY secret  

---

## Optional: Customize

### Add dependencies
```bash
npm install your-package
git add package*.json
git commit -m "Add your-package"
git push
```

### Add environment variables
1. Add to `env.example`
2. Add to `.env` (local)
3. Add to workflow (production)
4. Update in `Dockerfile` if needed at build time

### Add database
See `awesomeapps.frontend` for PostgreSQL/MySQL examples.

---

## Estimated Time

- **Template setup**: 10-15 minutes
- **First deployment**: 3-4 minutes
- **Total**: ~20 minutes

---

## Need Help?

- [README.md](../README.md) - Full documentation
- [GITHUB-SETUP.md](GITHUB-SETUP.md) - Detailed setup guide
- [DEPLOYMENT.md](DEPLOYMENT.md) - Operations guide
- [Ansible Structure](../../doc/ANSIBLE-STRUCTURE.md) - Infrastructure overview
