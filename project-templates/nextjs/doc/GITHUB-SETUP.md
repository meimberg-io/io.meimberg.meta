# GitHub Setup

Initial configuration required for automatic deployment.

## GitHub Variables

**Settings → Secrets and variables → Actions → Variables**

| Name | Value | Description |
|------|-------|-------------|
| `APP_DOMAIN` | `myapp.meimberg.io` | Application domain (UPDATE THIS) |
| `SERVER_HOST` | `hc-02.meimberg.io` | Server hostname |
| `SERVER_USER` | `deploy` | SSH user (optional, defaults to `deploy`) |

## GitHub Secrets

**Settings → Secrets and variables → Actions → Secrets**

| Name | Value | Description |
|------|-------|-------------|
| `SSH_PRIVATE_KEY` | `<private key contents>` | Deploy user private key |

**Get SSH private key:**
```bash
# Linux/Mac
cat ~/.ssh/id_rsa
# Or your deploy key: cat ~/.ssh/deploy_key

# Windows PowerShell
Get-Content C:\Users\YourName\.ssh\id_rsa
```

Copy entire output including `-----BEGIN` and `-----END` lines.

---

## DNS Configuration

**Add CNAME record:**
```
myapp.meimberg.io  →  CNAME  →  hc-02.meimberg.io
```

Replace `myapp` with your actual app name.

---

## Server Infrastructure

**Prerequisites (one-time setup):**

The server must have infrastructure in place before first deployment:

✅ **Already done for meimberg.io servers:**
- Docker + Docker Compose
- Traefik reverse proxy (automatic SSL)
- `deploy` user (for deployments)
- Firewall rules (SSH, HTTP, HTTPS)
- Automated backups

**If setting up a new server**, run Ansible first:

```bash
cd ../io.meimberg.ansible

# Install Ansible collections
ansible-galaxy collection install -r requirements.yml

# Run infrastructure setup
ansible-playbook -i inventory/hosts.ini playbooks/site.yml --vault-password-file vault_pass
```

---

## First Deployment

### Checklist

Before first deployment:

- [ ] GitHub Variables added: `APP_DOMAIN`, `SERVER_HOST`
- [ ] GitHub Secret `SSH_PRIVATE_KEY` added
- [ ] DNS CNAME record configured
- [ ] Server infrastructure ready (Ansible deployed)
- [ ] Can SSH to server: `ssh deploy@hc-02.meimberg.io`

### Deploy

```bash
git add .
git commit -m "Setup deployment"
git push origin main
```

**Monitor:** `https://github.com/YOUR_USERNAME/YOUR_REPO/actions`

**Deployment takes ~3-4 minutes:**
1. ✅ Tests run (lint, build, jest)
2. ✅ Docker image builds
3. ✅ Pushes to GitHub Container Registry
4. ✅ SSHs to server
5. ✅ Deploys container with Traefik labels
6. ✅ App live at `https://myapp.meimberg.io`

**Estimated setup time:** 15-20 minutes

---

## Troubleshooting

### GitHub Actions fails at deploy step

```bash
# Test SSH manually
ssh -i ~/.ssh/deploy_key deploy@hc-02.meimberg.io

# Check deploy user exists
ssh root@hc-02.meimberg.io "id deploy"
```

### Container not starting

```bash
ssh deploy@hc-02.meimberg.io "docker logs myapp"
```

### SSL certificate issues

```bash
# Check Traefik logs
ssh root@hc-02.meimberg.io "docker logs traefik | grep myapp"

# Verify DNS propagated
dig myapp.meimberg.io +short
```

### Image pull failed

- Automatically handled via `GITHUB_TOKEN`
- If still failing, verify package permissions in GitHub
- Make package public: Settings → Packages → Package settings → Change visibility

---

## Changing Domain

1. Update DNS CNAME record
2. Update GitHub Variable `APP_DOMAIN`
3. Push to trigger redeploy

No code changes needed!

---

## Related Documentation

- [DEPLOYMENT.md](DEPLOYMENT.md) - Deployment operations
- [SETUP-CHECKLIST.md](SETUP-CHECKLIST.md) - Quick setup checklist
- [README.md](../README.md) - Project documentation
- [Ansible Structure](../../doc/ANSIBLE-STRUCTURE.md) - Infrastructure overview
