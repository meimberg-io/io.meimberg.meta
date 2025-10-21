# Deployment

Automatic deployment on push to `main` branch.

## How It Works

Push to `main` → GitHub Actions:
1. Builds Docker image
2. Pushes to GitHub Container Registry (GHCR)
3. SSHs to server
4. Updates container with Traefik labels
5. Traefik automatically routes traffic with SSL

**Time:** ~3-4 minutes

---

## Initial Setup

**First time?** Complete setup first: [GITHUB-SETUP.md](GITHUB-SETUP.md)

This covers:
- GitHub Variables & Secrets
- DNS configuration
- Server infrastructure
- SSH keys

---

## Deploy

```bash
git push origin main
```

Watch: `https://github.com/YOUR_USERNAME/YOUR_REPO/actions`

---

## Operations

### View logs

```bash
ssh deploy@hc-02.meimberg.io "docker logs myapp -f"
```

### Restart app

```bash
ssh deploy@hc-02.meimberg.io "cd /srv/projects/myapp && docker compose restart"
```

### Manual redeploy

```bash
ssh deploy@hc-02.meimberg.io "cd /srv/projects/myapp && docker compose pull && docker compose up -d"
```

### SSH into container

```bash
ssh deploy@hc-02.meimberg.io "docker exec -it myapp sh"
```

### Check container status

```bash
ssh deploy@hc-02.meimberg.io "docker ps | grep myapp"
```

### View compose file

```bash
ssh deploy@hc-02.meimberg.io "cat /srv/projects/myapp/docker-compose.yml"
```

---

## Troubleshooting

### Container not starting

```bash
# View logs
ssh deploy@hc-02.meimberg.io "docker logs myapp"

# View full compose logs
ssh deploy@hc-02.meimberg.io "cd /srv/projects/myapp && docker compose logs"

# Check if container exists
ssh deploy@hc-02.meimberg.io "docker ps -a | grep myapp"
```

### SSL issues (502/503 errors)

```bash
# Check Traefik logs
ssh root@hc-02.meimberg.io "docker logs traefik | grep myapp"

# Check Traefik dashboard (if enabled)
# Usually at traefik.yourdomain.com

# Verify labels are correct
ssh deploy@hc-02.meimberg.io "docker inspect myapp | grep -A 10 Labels"
```

### DNS check

```bash
# Check DNS resolution
dig myapp.meimberg.io +short

# Should return server IP
# If empty, DNS not configured or not propagated yet (wait up to 24h)
```

### Port conflicts

```bash
# Check if port is already in use
ssh deploy@hc-02.meimberg.io "netstat -tuln | grep 5678"

# Check all running containers
ssh deploy@hc-02.meimberg.io "docker ps"
```

### Image pull issues

```bash
# Check if image exists
ssh deploy@hc-02.meimberg.io "docker images | grep myapp"

# Manually pull image
ssh deploy@hc-02.meimberg.io "docker pull ghcr.io/USERNAME/REPO:latest"

# If authentication fails, check GITHUB_TOKEN in workflow
```

### Deployment verification failed

The workflow checks if container is running after deploy:

```bash
# Manually check
ssh deploy@hc-02.meimberg.io "docker ps | grep myapp"

# If not running, check why
ssh deploy@hc-02.meimberg.io "docker logs myapp"
```

---

## Rollback

### To previous version

```bash
# SSH to server
ssh deploy@hc-02.meimberg.io

# Go to project directory
cd /srv/projects/myapp

# Pull specific version (replace SHA with commit hash)
docker pull ghcr.io/USERNAME/REPO:main-abc123

# Update docker-compose.yml to use specific tag
nano docker-compose.yml
# Change image: line to: ghcr.io/USERNAME/REPO:main-abc123

# Restart
docker compose up -d
```

---

## Performance

### Check resource usage

```bash
# Container stats
ssh deploy@hc-02.meimberg.io "docker stats myapp --no-stream"

# Server resources
ssh deploy@hc-02.meimberg.io "df -h && free -h"
```

### View response times

```bash
# Check Traefik access logs (if enabled)
ssh root@hc-02.meimberg.io "docker logs traefik | grep myapp"
```

---

## Updates

### Update dependencies

```bash
# Locally
npm update
npm run test:ci

# Commit and push
git add package*.json
git commit -m "Update dependencies"
git push origin main
```

### Update Node.js version

Update in `Dockerfile`:
```dockerfile
FROM node:20-alpine AS base  # Change version here
```

---

## Advanced

### Environment variables in production

Add to `.github/workflows/deploy.yml` in the deploy step:

```yaml
environment:
  - NODE_ENV=production
  - PORT=5678
  - YOUR_VAR=${{ secrets.YOUR_SECRET }}
```

### Add database service

Add to docker-compose.yml section in workflow:

```yaml
postgres:
  image: postgres:15-alpine
  environment:
    POSTGRES_PASSWORD: ${{ secrets.DB_PASSWORD }}
  volumes:
    - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

---

## Related Documentation

- [GITHUB-SETUP.md](GITHUB-SETUP.md) - Initial setup
- [SETUP-CHECKLIST.md](SETUP-CHECKLIST.md) - Quick checklist
- [README.md](../README.md) - Project overview
- [Ansible Structure](../../doc/ANSIBLE-STRUCTURE.md) - Infrastructure details
