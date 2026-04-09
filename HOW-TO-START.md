# Liberal Music & Arts School — How To Start
> Stack: Pure HTML · Bilingual EN/ZH · No framework · Branch: `master`
> OS: **Windows** · Shell: **PowerShell** · Repo: `C:\Users\immor\Downloads\liberalwebsitenew`

---

## ⚡ EVERY NEW CHAT — DO THIS FIRST

### 1. Pull latest from GitHub (PowerShell)
```powershell
cd C:\Users\immor\Downloads\liberalwebsitenew
git pull origin master
```

### 2. Upload files to this chat
Upload **all** pages you want edited in **one go** at the start.  
**Never upload a file mid-session** — it overwrites Claude's edits with the old version.

### 3. Tell Claude everything to fix in one message
List all changes needed. Claude will edit all files in one pass.

### 4. Download all outputs → replace local files
```powershell
copy "C:\Users\immor\Downloads\filename.html" "C:\Users\immor\Downloads\liberalwebsitenew\pages\filename.html"
# For root files:
copy "C:\Users\immor\Downloads\index.html" "C:\Users\immor\Downloads\liberalwebsitenew\index.html"
# For assets:
copy "C:\Users\immor\Downloads\image.webp" "C:\Users\immor\Downloads\liberalwebsitenew\assets\"
```

### 5. Push once at the end
```powershell
cd C:\Users\immor\Downloads\liberalwebsitenew
git add .
git commit -m "describe changes"
git push origin master
# If rejected (non-fast-forward):
git pull origin master --rebase
git push origin master
# If still rejected:
git push origin master --force
```

### 6. Re-upload changed files to Claude Project Knowledge
Keep project knowledge in sync so next chat Claude always reads the latest version.

---

## 📁 FILE STRUCTURE

```
liberalwebsitenew/
├── index.html              ← English homepage
├── index-zh.html           ← Chinese homepage
├── assets/
│   ├── logo.webp           ← Navbar logo (NEVER inline base64)
│   ├── logofooter.webp     ← Footer logo
│   ├── address.webp        ← Location pin icon
│   ├── whatsapp.webp       ← WhatsApp FAB icon
│   ├── Instagram.webp
│   ├── facebook.webp
│   ├── youtube.webp
│   ├── xiaohongshu.webp
│   └── blog-*.webp         ← Blog images (card + hero, one pair per article)
├── pages/
│   ├── about.html
│   ├── blog.html           ← Blog grid page (cards only)
│   ├── career.html
│   ├── contact.html
│   ├── courses.html
│   ├── instructors.html
│   ├── testimonial.html
│   ├── trial.html
│   ├── articles/           ← One .html per blog article
│   │   └── liberal-blog-*.html
│   ├── cecily.html         ← Instructor profile (CANONICAL TEMPLATE)
│   ├── calvin.html
│   ├── kate.html
│   ├── jiang.html
│   ├── cheng.html
│   ├── leonard.html
│   └── loy.html
├── pages-zh/               ← Chinese pages (mirrors pages/)
│   └── articles/
└── tools/                  ← Internal tools, never linked from site
    ├── Liberal_blog-generator.html   ← Blog generator (open in Chrome)
    ├── publish-blog-*.ps1            ← Auto-generated publish scripts
    ├── card-*.html                   ← Auto-generated card HTML
    └── article-*.html                ← Auto-generated article HTML
```

**Path rules (CRITICAL):**
| File location | Logo src | Asset prefix |
|---|---|---|
| Root (`index.html`) | `assets/logo.webp` | `assets/` |
| `pages/*.html` | `../assets/logo.webp` | `../assets/` |
| `pages/articles/*.html` | `../../assets/logo.webp` | `../../assets/` |

**Local test server:**
```powershell
cd C:\Users\immor\Downloads\liberalwebsitenew
python -m http.server 8888
```
Then open `http://localhost:8888` in Chrome.

---

## 📝 BLOG WORKFLOW (adding a new article)

### Full auto-publish (recommended)

1. Open `tools\Liberal_blog-generator.html` in Chrome
2. Fill in: Title, Excerpt, Date, Category, Emoji, Article Body
3. Optionally add image filenames (card image + hero image)
4. Click **🚀 Publish to Website** — downloads 3 files:
   - `publish-blog-[slug].ps1`
   - `card-[slug].html`
   - `article-[slug].html`
5. Move all 3 files into `tools\`
6. Also copy any blog images into `assets\`
7. Open PowerShell and run:

```powershell
cd C:\Users\immor\Downloads\liberalwebsitenew
Get-ChildItem "C:\Users\immor\Downloads\liberalwebsitenew\tools\*.ps1" | Unblock-File; Get-ChildItem "C:\Users\immor\Downloads\liberalwebsitenew\tools\publish-blog-*.ps1" | Select-Object -Last 1 | ForEach-Object { & $_.FullName }
```

The script automatically: pulls latest → inserts card into blog.html → saves article page → git add → commit → push.

### First time setup (one-time only)
```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```
Press **Y** when prompted. Never needed again.

### If push is rejected after running the script
```powershell
cd C:\Users\immor\Downloads\liberalwebsitenew
git pull origin master --rebase
git push origin master
# If still failing:
git push origin master --force
```

### Blog image sizes
| Image | Size | Filename pattern | Location |
|---|---|---|---|
| Card thumbnail | 800 × 500 px | `blogname_card.webp` | `assets/` |
| Article hero | 1200 × 600 px | `blogname.webp` | `assets/` |
| Target file size | Card < 150KB, Hero < 300KB | Use [squoosh.app](https://squoosh.app) to compress |

### blog.html marker (must be present)
The publish script looks for this exact comment inside `.blog-grid`:
```html
<!-- PASTE NEW CARD HERE (top of grid = newest first) -->
```
If missing, the script will warn you. Add it manually above the first card.

---

## 🎨 DESIGN SYSTEM

Source of truth: **`HEADER-FOOTER-GUIDE.md`** — copy all CSS/HTML blocks verbatim from there.

### CSS Variables (`:root`)
```css
:root {
  --or:#FF6600; --or-dk:#E55900; --or-lt:#FFF4ED; --or-pale:#FFF7F2;
  --or-glow:rgba(255,102,0,.16); --or-sh:0 12px 32px rgba(255,102,0,.22);
  --or-shh:0 16px 40px rgba(255,102,0,.34);
  --w:#FFFFFF; --s1:#FFFAF5; --s2:#F8FBFF;
  --ink:#1F2A44; --body:#5A6B85; --muted:#8FA2BC;
  --teal:#B8F2E6; --sky:#D4EDFF; --blush:#FFD6E0; --lem:#FFF3B0; --lav:#E8E4FF;
  --r:16px; --r-l:20px; --r-xl:28px;
  --sh:0 8px 28px rgba(31,42,68,.09); --sh-l:0 20px 56px rgba(31,42,68,.11); --sh-s:0 2px 10px rgba(31,42,68,.06);
  --sp:cubic-bezier(.22,1,.36,1); --ea:cubic-bezier(.4,0,.2,1); --t:.22s;
}
```

### Fonts (paste in `<head>`)
```html
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
<link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,400;0,600;0,700;0,800;0,900;1,800&family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet"/>
```

### Key layout rules
- Max width: `1240px` · class `.W`
- Section padding: `100px 0`
- `<main>` padding-top: `108px` (36px ann-bar + 72px nav)
- Fonts: headings = `Nunito`, body = `Quicksand`

---

## 🧭 NAV LINK ORDER (never change)
```
Home | About | Courses | Instructors | Review | Blog | Contact
```
Right side: `[中文]` → `[Book Trial Class]` (orange pill button)

---

## 👩‍🏫 INSTRUCTOR PROFILE PAGES

All follow the same template — **`cecily.html` is the canonical base**.

| File | Instructor | Speciality |
|---|---|---|
| `cecily.html` | Ms Cecily | Erhu · Chinese Instruments |
| `calvin.html` | Mr Calvin | Drums · Guitar · Ukulele |
| `kate.html` | Ms Kate | Piano · ABRSM |
| `jiang.html` | Ms Jiang | Erhu · Chinese Instruments |
| `cheng.html` | Ms Cheng | Violin · Piano |
| `leonard.html` | Mr Leonard | Drums · Guitar · Ukulele |
| `loy.html` | Mr Loy | Guitar · Ukulele |

**Key rules for instructor pages:**
- Book card button: `Book Trial Class` (no "Free")
- Nav active link: always **Instructors**
- "Other Instructors" strip: always shows the other 6, never the current instructor
- Add new page to `instructors.html` grid as `<a class="icard">` wrapper

---

## 📍 WHATSAPP NUMBERS (never change)
| Branch | Number | Link |
|---|---|---|
| Tengah | +65 8922 2848 | `https://wa.me/6589222848` |
| Tampines | +65 8892 1198 | `https://wa.me/6588921198` |
| Jurong West / Le Quest / Jurong Point | +65 9627 7582 | `https://wa.me/6596277582` |

---

## ✅ QUICK CHECKLIST (every page)

**Head**
- [ ] Nunito + Quicksand fonts imported
- [ ] `:root` CSS variables present and unmodified

**Header**
- [ ] Announcement bar: `#f56c22`, correct trial link
- [ ] Nav `top:36px`, `<main>` `padding-top:108px`
- [ ] Logo: correct asset path for file depth, height `42px` (never base64)
- [ ] Nav link order correct, active page has `class="active"`
- [ ] Book Trial button: `class="btn btn-cta"` + `style="padding:10px 22px;font-size:14px;"`
- [ ] Mobile drawer present

**Footer**
- [ ] Background `#1F2A44`, logo `logofooter.webp` height `56px`
- [ ] Brand text: `color:#fff`, `font-size:15px`
- [ ] Social icons: `.webp` assets with `filter:brightness(0) invert(1)`, no borders/boxes
- [ ] All 5 locations with full names
- [ ] Location pins: `address.webp` white filter (Jurong Point uses `✦`)
- [ ] Nav links: `color:#fff`, `font-size:15px`
- [ ] Bottom bar has `v1.0.1` version tag
- [ ] Kill-bottom-gap rules present

**Floating**
- [ ] WhatsApp FAB uses `whatsapp.webp` icon (all 3 numbers correct)
- [ ] Mobile sticky CTA bar with trial link

**Article pages only (`pages/articles/*.html`)**
- [ ] Asset paths use `../../assets/` (two levels up)
- [ ] Nav links use `../../pages/` prefix
- [ ] Hero image present (1200×600px, `../../assets/blogname.webp`)
- [ ] Back to Blog link points to `../../pages/blog.html`
- [ ] CTA band at bottom links to `../../pages/trial.html`

**Instructor profile pages only**
- [ ] Breadcrumb: Home → Our Instructors → Instructor Name
- [ ] Active nav link set to **Instructors**
- [ ] Book card button says `Book Trial Class` (not "Free")
- [ ] "Other Instructors" strip excludes the current page's instructor

---

## 🗂 PROJECT KNOWLEDGE FILES

Keep these files uploaded and current in Claude Project Knowledge:

| File | Purpose |
|---|---|
| `HOW-TO-START.md` | This file — workflow + design system summary |
| `HEADER-FOOTER-GUIDE.md` | Full CSS/HTML source of truth for header & footer |
| `LIBERAL_ART_BIBLE.md` | Design philosophy & art direction |
| `index.html` | English homepage (reference) |
| `pages/about.html` | Re-upload after each edit |
| `pages/courses.html` | Re-upload after each edit |
| `pages/instructors.html` | Re-upload after each edit |
| `pages/testimonial.html` | Re-upload after each edit |
| `pages/blog.html` | Re-upload after each edit |
| `pages/contact.html` | Re-upload after each edit |
| `pages/trial.html` | Re-upload after each edit |
| `pages/cecily.html` | Canonical instructor template — re-upload after any edit |
| `pages/calvin.html` | Re-upload after each edit |
| `pages/kate.html` | Re-upload after each edit |
| `pages/jiang.html` | Re-upload after each edit |
| `pages/cheng.html` | Re-upload after each edit |
| `pages/leonard.html` | Re-upload after each edit |
| `pages/loy.html` | Re-upload after each edit |
