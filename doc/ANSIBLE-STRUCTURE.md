# Ansible Deployment Cookbook

Quick guide for setting up new projects with the meimberg.io deployment infrastructure.

## Quick Start: New Project

### 1. Local Development

```bash
# Standard Next.js setup
npm install
npm run dev  # Runs on http://localhost:3000

# Test Docker build locally
docker build -t myapp .
docker run -p 3000:3000 myapp
```

### 2. Project Files

**Create these 3 files:**

**`Dockerfile`** (multi-stage build):
```dockerfile
FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci

FROM node:20-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
EXPOSE 3000
CMD ["node", "server.js"]
```

**`next.config.ts`** (add standalone output):
```typescript
export default {
  output: 'standalone',
  // ... your other config
}
```

**`.github/workflows/deploy.yml`** (copy from `io.meimberg.www` or `io.meimberg.monstermemory`):
- Update app name throughout
- Update domain and port in docker-compose section

### 3. GitHub Configuration

**Settings → Secrets and variables → Actions:**

**Variables:**
- `APP_DOMAIN`: `your-app.meimberg.io`
- `SERVER_HOST`: `hc-02.meimberg.io`
- `SERVER_USER`: `deploy` (default)

**Secrets:**
- `SSH_PRIVATE_KEY`: Deploy user SSH key (already exists)
- Add any app-specific secrets (DB passwords, API keys, etc.)

### 4. DNS Setup

Create CNAME record:
```
your-app.meimberg.io → hc-02.meimberg.io
```

### 5. Deploy

```bash
git push origin main
```

Watch GitHub Actions run. Done! Your app is live with automatic SSL.

## Local Development Tips

### Run with Docker Compose Locally

Create `docker-compose.local.yml`:
```yaml
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    # Add any env vars needed
```

Run: `docker compose -f docker-compose.local.yml up`

### Test with Local Traefik (Optional)

```bash
# Start Traefik locally
docker network create traefik
docker run -d \
  --name traefik \
  --network traefik \
  -p 80:80 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  traefik:v2.10 \
  --providers.docker=true \
  --entrypoints.web.address=:80

# Run your app with labels
docker run -d \
  --name myapp \
  --network traefik \
  --label "traefik.enable=true" \
  --label "traefik.http.routers.myapp.rule=Host(\`myapp.localhost\`)" \
  --label "traefik.http.services.myapp.loadbalancer.server.port=3000" \
  myapp

# Access at http://myapp.localhost
```

## Architecture (2-Layer System)

1. **Ansible** (root): Infrastructure setup (Docker, Traefik, users, backups) - Done once
2. **GitHub Actions** (deploy user): App deployments - Every git push

## Traefik Labels Template

```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.{app}.rule=Host(`{domain}`)"
  - "traefik.http.routers.{app}.entrypoints=websecure"
  - "traefik.http.routers.{app}.tls.certresolver=le"
  - "traefik.http.services.{app}.loadbalancer.server.port={port}"
```

Replace `{app}`, `{domain}`, and `{port}` with your values.

## Operations

```bash
# View logs
ssh deploy@hc-02.meimberg.io "docker logs {app} -f"

# Restart app
ssh deploy@hc-02.meimberg.io "cd /srv/projects/{app} && docker compose restart"

# Manual redeploy
ssh deploy@hc-02.meimberg.io "cd /srv/projects/{app} && docker compose pull && docker compose up -d"

# SSH into container
ssh deploy@hc-02.meimberg.io "docker exec -it {app} sh"
```

## Examples

Copy workflow from these projects:
- `io.meimberg.www`
- `io.meimberg.monstermemory`

## File Structure

```
io.meimberg.{project}/
├── .github/workflows/deploy.yml  # CI/CD
├── Dockerfile                    # Production build
├── docker-compose.local.yml      # Local testing (optional)
├── next.config.ts                # output: 'standalone'
└── src/                          # Your app code
```

## Common Issues

**Build fails:** Check `output: 'standalone'` in next.config.ts  
**Container starts but 502:** Wrong port in Traefik labels  
**SSL not working:** Wait 2 minutes for Let's Encrypt, check DNS  
**Can't connect to DB:** Add DB service to docker-compose.yml in workflow

## Full Project Layout (Reference)

```
io.meimberg.ansible/         # Infrastructure (Ansible)
├── playbooks/site.yml       # Main playbook
├── inventory/hosts.ini      # Server list
└── group_vars/              # Config + secrets

/srv/projects/               # On server
├── app1/docker-compose.yml  # Created by GitHub Actions
├── app2/docker-compose.yml
└── ...
```

