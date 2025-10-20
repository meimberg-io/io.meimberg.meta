# 🧭 Cursor Rules Template Repository

Dieses Repository dient als **zentrale Sammlung und Dokumentation aller Cursor-Regeln (.mcp)**,  
die in unterschiedlichen Projekten (Next.js, Strapi, n8n, Infrastruktur usw.) wiederverwendet werden.  

Das Ziel ist es, einheitliche, nachvollziehbare und sichere Regeln für den Cursor-AI-Editor bereitzustellen,  
damit KI-gestützte Codeänderungen, Dokumentationen und Befehle in allen Projekten konsistent funktionieren.

---

## 📂 Struktur

```
.cursor/
│
├── rules/
│   ├── chatstyle.mcp    # Chat-Stil und Antwortverhalten
│   ├── oli.mcp          # Regeln, die in allen Projekten gelten
│   ├── nextjs.mcp       # Frontend: Next.js / React-Projekte
│   ├── strapi.mcp       # Backend: Strapi / Node.js APIs
│   ├── java.mcp         # Java: Spring Boot, Jakarta EE
│   ├── devops.mcp       # DevOps, Docker, CI/CD, Deployment
│   ├── n8n.mcp          # Automationen und Flows
│   ├── automation.mcp   # AI-/Workflow-Automatisierungen
│   └── experimental.mcp # Sandbox-Regeln für Tests und Experimente
│
└── rules.yaml           # Optionaler globaler Header oder Fallback-Regeln
```

Alle `.mcp`-Dateien werden von **Cursor automatisch erkannt, geladen und zusammengeführt**.  
Die alphabetische Reihenfolge im Verzeichnis bestimmt die Priorität — spätere Dateien überschreiben frühere.

---

## 🧩 Regelprinzipien

Jede `.mcp`-Datei enthält ein Array von **Rules**, z. B.:

```yaml
rules:
  - type: edit
    pattern: "frontend/src/**/*.{ts,tsx}"
    allow: true
    message: "Frontend edits allowed inside src/ only"
```

### Verfügbare Regeltypen

| Typ | Beschreibung |
|------|---------------|
| `edit` | Legt fest, welche Dateien die KI ändern darf |
| `context` | Definiert, welche Dateien Cursor lesen oder „sehen“ darf |
| `style` | Beschreibt Code-Stilvorgaben (Indentation, Quotes, Guide etc.) |
| `security` | Schützt sensible Dateien oder Schlüssel vor Zugriff |
| `command` | Kontrolliert erlaubte und verbotene Terminalbefehle |
| `doc` | Legt Dokumentationsstil fest (z. B. JSDoc oder Markdown) |
| `custom` | Freiform-Regeln oder konzeptionelle Hinweise |
| *(optional)* `experimental` | Temporäre Sandbox-Regeln für Tests |

Alle Regeldateien werden beim Start von Cursor **gemerged**, es ist keine zusätzliche Konfiguration nötig.

---

## 🧱 Organisation nach App-Typ

Die Regeln sind **nicht nach Regelart**, sondern **nach Projekttyp** organisiert:  
Das erleichtert Wiederverwendung und zentrale Verwaltung.

| Datei | Zweck |
|--------|--------|
| `chatstyle.mcp` | Chat-Antwort-Stil und Verhalten |
| `oli.mcp` | Basisregeln für alle Projekte (Stil, Sicherheit, Git-Schutz) |
| `nextjs.mcp` | Frontend-spezifische Regeln für Next.js 15 / React |
| `strapi.mcp` | Backendregeln für Strapi 5.x APIs |
| `java.mcp` | Java-Projekte (Spring Boot, Jakarta EE) |
| `devops.mcp` | DevOps, Docker, CI/CD, GitHub Actions, Deployment |
| `n8n.mcp` | Workflow-Regeln für n8n-Automationen |
| `automation.mcp` | Verhalten für KI-Workflows, Automatisierungen, Validierung |
| `experimental.mcp` | Temporäre Sandbox-Regeln zum Testen neuer Features |

---

## ⚙️ Verwendung in Projekten

Du kannst dieses Regelset auf verschiedene Weisen einbinden:

### 🔗 1. Symlink (lokal, empfohlen)
Wenn du mehrere lokale Projekte nutzt:
```bash
ln -s ~/io.meimberg.template/.cursor/rules /path/to/your-project/.cursor/rules
```
Cursor liest automatisch alle Regeln aus dem verlinkten Ordner.

---

### 📦 2. Git Submodule (versioniert)
Wenn du die Regeln versionieren und updaten möchtest:
```bash
git submodule add git@github.com:deinuser/cursor-rules-template.git .cursor
```

---

### 📋 3. Kopie (einmalige Nutzung)
Für Projekte, die unabhängig bleiben sollen:
```bash
cp -r ~/io.meimberg.template/.cursor ./your-project/
```

---

## 🧠 Hinweise für Cursor (Selbsterklärung)

Wenn Cursor in diesem Repository arbeitet oder auf es zugreift, gilt:

- Dieses Repository enthält **Meta-Regeln**, keine Projektdateien.  
- Neue `.mcp`-Dateien sollen **eine klar abgegrenzte Domäne** beschreiben.  
- Jede Datei sollte einen kurzen Kommentarblock mit Zweck und Autor enthalten.  
- Cursor darf bestehende Regeln **erweitern oder aktualisieren**, aber nicht löschen.  
- Änderungen an Sicherheits- oder Edit-Regeln müssen dokumentiert werden.  

---

## 🪶 Beispiel: Kopf einer `.mcp`-Datei

```yaml
# nextjs.mcp
# Rules for all frontend projects using Next.js or React.
# Author: Oli Meimberg
# Version: 1.0

rules:
  - type: edit
    pattern: "frontend/src/**/*.{ts,tsx}"
    allow: true
  - type: custom
    note: >
      Next.js conventions:
      - Prefer functional components with hooks
      - Use server components by default
      - Keep UI and logic layers separate
```

---

## 🧩 Beispiel: oli.mcp (Kurzversion)

```yaml
# oli.mcp — Base rules for all projects
rules:
  - type: style
    language: typescript
    guide: "airbnb"
    indent: 2
    quotes: "single"
    semi: false

  - type: security
    denyPatterns:
      - "*.env"
      - "*.pem"
      - "API_KEY"
      - "SECRET"
    redact: true

  - type: custom
    note: >
      General conventions:
      - Use async/await
      - Keep code modular and self-explanatory
      - Avoid placeholder text or marketing tone
```

---

## 🧭 Ziel

- **Zentrale Verwaltung** aller Cursor-Regeln  
- **Einfache Wiederverwendung** zwischen Projekten  
- **Automatische Dokumentation** für Mensch & KI  
- **Konsistenz, Sicherheit und Stil** über dein gesamtes Entwickler-Ökosystem  

---

✳️ *Dieses Repository darf von Cursor gelesen, erweitert und kommentiert werden,  
aber jede Regeländerung muss bestehende Strukturen respektieren und dokumentiert bleiben.*
