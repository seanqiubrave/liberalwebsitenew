# Liberal Music & Arts School — How To Start
> Stack: Pure HTML · Bilingual EN/ZH · No framework · Branch: `master`

---

## ⚡ EVERY NEW CHAT — DO THIS FIRST

### 1. Pull latest from GitHub (on your Mac)
```bash
cd /Users/qiu/Downloads/liberalwebsiteredo && git pull origin master
```

### 2. Upload files to this chat
Upload **all** pages you want edited in **one go** at the start.  
**Never upload a file mid-session** — it overwrites Claude's edits with the old version.

### 3. Tell Claude everything to fix in one message
List all changes needed. Claude will edit all files in one pass.

### 4. Download all outputs → replace on Mac
```bash
# Pages subfolder
cp ~/Downloads/about.html /Users/qiu/Downloads/liberalwebsiteredo/pages/about.html
cp ~/Downloads/courses.html /Users/qiu/Downloads/liberalwebsiteredo/pages/courses.html
# repeat for each file

# Root files
cp ~/Downloads/index.html /Users/qiu/Downloads/liberalwebsiteredo/index.html
```

### 5. Push once at the end
```bash
cd /Users/qiu/Downloads/liberalwebsiteredo
git add .
git commit -m "describe changes"
git push origin master
# If rejected: git push origin master --force
```

### 6. Re-upload changed files to Claude Project Knowledge
Keep project knowledge in sync so next chat Claude always reads the latest version.

---

## 📁 FILE STRUCTURE

```
liberalwebsiteredo/
├── index.html           ← English homepage
├── index-zh.html        ← Chinese homepage
├── assets/
│   ├── logo.webp        ← Navbar logo (NEVER inline base64)
│   ├── logofooter.webp  ← Footer logo
│   ├── address.webp     ← Location pin icon
│   ├── Instagram.webp
│   ├── facebook.webp
│   ├── youtube.webp
│   └── xiaohongshu.webp
└── pages/
    ├── about.html
    ├── blog.html
    ├── career.html
    ├── contact.html
    ├── courses.html
    ├── instructors.html
    ├── testimonial.html
    └── trial.html
```

**Path rules (CRITICAL):**
| File location | Logo src | Asset prefix |
|---|---|---|
| Root (`index.html`) | `assets/logo.webp` | `assets/` |
| Subfolder (`pages/*.html`) | `../assets/logo.webp` | `../assets/` |

**Local test server:** `python3 -m http.server 8888` ← port 8888, NOT 8080

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
- [ ] Logo: `../assets/logo.webp`, height `42px` (never base64)
- [ ] Nav link order correct, active page has `class="active"`
- [ ] Book Trial button: `class="btn btn-cta"` + `style="padding:10px 22px;font-size:14px;"`
- [ ] Mobile drawer present

**Footer**
- [ ] Background `#1F2A44`, logo `logofooter.webp` height `56px`
- [ ] Brand text: `color:#fff`, `font-size:15px`
- [ ] Social icons: `.webp` assets with `filter:brightness(0) invert(1)`, no borders/boxes
- [ ] All 5 locations with full names (Tengah/Tampines/Jurong West/Le Quest/Jurong Point Music School)
- [ ] Location pins: `address.webp` white filter (Jurong Point uses `✦`)
- [ ] Nav links: `color:#fff`, `font-size:15px`, no extra "Free Trial" item
- [ ] Bottom bar has `v1.0.1` version tag
- [ ] Kill-bottom-gap rules present

**Floating**
- [ ] WhatsApp FAB (all 3 numbers correct)
- [ ] Mobile sticky CTA bar with trial link

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
