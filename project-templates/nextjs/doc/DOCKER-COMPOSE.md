# Docker Compose Usage

Guide for using Docker Compose in local development and testing.

## Available Files

### 1. `docker-compose.yml` (Unified with Profiles)

Single file with both dev and prod configurations using profiles.

**Usage:**
```bash
# Development mode (with volume mounts)
docker compose --profile dev up

# Production mode (test production build)
docker compose --profile prod up

# Rebuild and start
docker compose --profile dev up --build

# In background
docker compose --profile dev up -d

# View logs
docker compose --profile dev logs -f

# Stop
docker compose --profile dev down
```

### 2. `docker-compose.prod.yml` (Reference Only)

This file shows what GitHub Actions automatically creates on the server. It includes Traefik labels for automatic SSL and routing. **This is for reference/documentation only** - you don't use it locally.

**What it contains:**
- Pre-built image from GitHub Container Registry
- Traefik labels for routing and SSL
- External traefik network
- Production environment variables

---

## Quick Commands

### Development Workflow

```bash
# 1. Copy environment file
cp env.example .env

# 2. Start development container
docker compose --profile dev up

# 3. Access app at http://localhost:5678

# 4. Stop
docker compose --profile dev down
```

### Production Testing

```bash
# Test production build locally
docker compose --profile prod up --build

# Access at http://localhost:5678
```

### Rebuild

```bash
# Force rebuild
docker compose --profile dev build --no-cache

# Rebuild and start
docker compose --profile dev up --build
```

---

## Features

### Development Mode (`--profile dev`)

✅ **Volume mounts** - Source code mounted for changes  
✅ **Fast iteration** - No rebuild needed for code changes  
✅ **Isolated environment** - Consistent across machines  
✅ **Health checks** - Monitor container health  

**Mounted directories:**
- `./src` → `/app/src`
- `./public` → `/app/public`
- Config files (next.config.ts, tailwind.config.ts, etc.)
- `node_modules` is NOT mounted (uses container's version)

### Production Mode (`--profile prod`)

✅ **No volume mounts** - Fully containerized  
✅ **Production build** - Optimized standalone output  
✅ **Production environment** - NODE_ENV=production  
✅ **Local testing** - Test production build before deploy  

---

## Configuration

### Environment Variables

Loaded from `.env` file in project root:

```bash
# .env
NODE_ENV=development
APP_PORT=5678
```

### Port Mapping

Default: `5678:5678` (host:container)

**Change port:**
```bash
# In .env
APP_PORT=3001

# Or directly
APP_PORT=3001 docker compose -f docker-compose.dev.yml up
```

### Health Checks

Both configurations include health checks:
- **Interval**: 30 seconds
- **Timeout**: 10 seconds
- **Retries**: 3
- **Start period**: 40 seconds

**View health:**
```bash
docker ps
# Look for "healthy" status

# Or detailed
docker inspect myapp-dev | grep -A 20 Health
```

---

## Troubleshooting

### Container won't start

```bash
# View logs
docker compose --profile dev logs

# Check if port is in use
lsof -i :5678  # Mac/Linux
netstat -ano | findstr :5678  # Windows

# Try different port
APP_PORT=3001 docker compose --profile dev up
```

### Changes not reflecting (dev mode)

```bash
# Rebuild container
docker compose --profile dev up --build

# Ensure volume mounts are working
docker compose --profile dev exec app-dev ls -la /app/src
```

### Production build fails

```bash
# Build with detailed output
docker compose --profile prod build --progress=plain

# Or build directly
docker build -t myapp-test .
```

### Container keeps restarting

```bash
# Check logs
docker compose --profile dev logs

# Check health status
docker ps -a

# Common issues:
# - Port already in use
# - Missing environment variables
# - Build failed
```

---

## Differences from Production Deployment

### Local Development (docker-compose.yml with --profile dev)
```yaml
services:
  app-dev:
    build: .
    ports:
      - "5678:5678"
    volumes:
      - ./src:/app/src:ro  # Source mounted
    networks:
      - app-network
```

### Production Server (created by GitHub Actions)
```yaml
services:
  myapp:
    image: ghcr.io/username/repo:latest  # Pre-built image
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.myapp.rule=Host(`myapp.meimberg.io`)"
      - "traefik.http.routers.myapp.entrypoints=websecure"
      - "traefik.http.routers.myapp.tls.certresolver=le"
      - "traefik.http.services.myapp.loadbalancer.server.port=5678"
    networks:
      - traefik  # External network managed by Ansible
```

**Key differences:**
- Production uses **pre-built image** from GitHub Container Registry
- Production has **Traefik labels** for automatic routing and SSL
- Production uses **external traefik network** (not local bridge)
- Production doesn't expose ports directly (Traefik handles routing)

---

## Best Practices

### Development

1. **Use docker-compose.dev.yml** for daily development
2. **Keep .env file updated** with required variables
3. **Don't commit .env** (use env.example)
4. **Rebuild periodically** to get dependency updates

### Testing

1. **Test production build locally** before pushing
2. **Use docker-compose.prod.yml** to test production environment
3. **Verify environment variables** work in production mode
4. **Check health checks** are passing

### Cleanup

```bash
# Stop and remove containers
docker compose --profile dev down

# Remove volumes
docker compose --profile dev down -v

# Remove images
docker images | grep myapp
docker rmi <image-id>

# Full cleanup
docker system prune -a
```

---

## Advanced Usage

### Add Database Service

Edit `docker-compose.yml` to add a database:

```yaml
services:
  app-base:
    # ... existing config ...
    depends_on:
      - postgres
    environment:
      - DATABASE_URL=postgresql://user:password@postgres:5432/myapp

  postgres:
    image: postgres:15-alpine
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=myapp
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    networks:
      - app-network

volumes:
  postgres_data:
```

### Add Redis Cache

```yaml
services:
  redis:
    image: redis:7-alpine
    container_name: myapp-redis
    ports:
      - "6379:6379"
    networks:
      - myapp-network
```

### Custom Network

```yaml
networks:
  myapp-network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16
```

---

## Related Documentation

- [README.md](../README.md) - Main documentation
- [DEPLOYMENT.md](DEPLOYMENT.md) - Production deployment
- [GITHUB-SETUP.md](GITHUB-SETUP.md) - Initial setup


