# Liberal Music & Arts School — How To Start
> Stack: Pure HTML · Bilingual EN/ZH · No framework · Hosted on **Vercel** · Clean URLs (no `.html`) · Branch: `master`
> OS: **Windows** · Shell: **PowerShell** · Repo: `C:\Users\immor\Downloads\liberalwebsitenew`
> Production domain (in progress): `https://liberalmusicschool.com`
> Temporary preview URL: `https://liberalwebsitenew.vercel.app` (currently protected — see Vercel settings)

---

## ⚡ EVERY NEW CHAT — DO THIS FIRST

### 1. Pull latest from GitHub (PowerShell)
```powershell
cd C:\Users\immor\Downloads\liberalwebsitenew
git pull origin master
```

### 2. Drop the newest files into the chat
**At the START of every new chat**, Claude should ask me to drag-and-drop the **newest versions** of the pages I want edited.  
- Pull from GitHub first (step 1), then upload **straight from the local repo** (`C:\Users\immor\Downloads\liberalwebsitenew\pages\`), NOT from some older copy in Downloads.
- Upload **all pages needed in one batch** at the start — don't dribble uploads in mid-conversation.
- **Exception:** if the chat gets long and Claude's edits may have drifted, Claude should **ask me to re-upload the newest file** before continuing. The most recent version on disk (after a git pull) is always the source of truth.

### 3. Tell Claude everything to fix in one message
List all changes needed. Claude will edit all files in one pass and present them for download.

### 4. Download outputs → extract if zipped → verify with script
Claude's "Download all" button packages files as `files.zip` (or `files (N).zip`). **Always extract to a clean folder before copying**, otherwise stale loose files in `Downloads\` get copied instead.

```powershell
# Extract the zip to a fresh folder
$zipPath = "C:\Users\immor\Downloads\files.zip"   # adjust (N) as needed
$extractPath = "C:\Users\immor\Downloads\claude-fix"
if (Test-Path $extractPath) { Remove-Item $extractPath -Recurse -Force }
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
```

Then copy + **verify-before-push** in one go. Example for the `pages/` folder:

```powershell
cd C:\Users\immor\Downloads\liberalwebsitenew
$src = "C:\Users\immor\Downloads\claude-fix"
# List the page names Claude edited — adjust per session
$allFiles = @('about','blog','contact','courses','instructors','review','trial','privacy','terms')

# The marker is a distinctive string from THIS session's edit (e.g. a comment Claude added).
# Pick something guaranteed unique to this change so the check is meaningful.
$marker = "prevent horizontal overflow"   # CHANGE THIS per session

$failures = @()
foreach ($p in $allFiles) {
  $srcFile = "$src\$p.html"
  $dstFile = "pages\$p.html"
  if (-not (Test-Path $srcFile)) { Write-Host "MISSING SOURCE: $srcFile" -ForegroundColor Red; $failures += $p; continue }
  copy $srcFile $dstFile -Force
  if (Select-String -Path $dstFile -Pattern $marker -Quiet) {
    Write-Host "OK  $p.html" -ForegroundColor Green
  } else {
    Write-Host "FAIL $p.html - marker missing after copy" -ForegroundColor Red
    $failures += $p
  }
}

Write-Host ""
if ($failures.Count -eq 0) {
  Write-Host "ALL FILES VERIFIED - proceeding to commit" -ForegroundColor Green
  git add .
  git commit -m "describe changes"
  git push origin master
} else {
  Write-Host "DO NOT PUSH - $($failures.Count) files failed:" -ForegroundColor Red
  $failures | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
}
```

> **Why the verify-first pattern?** In the April 24 2026 session, a push "succeeded" (20 files changed, pushed to GitHub) but Vercel was still serving the old CSS — because the files being copied were older versions without the edit. Adding `Select-String -Pattern $marker -Quiet` catches this **before** the commit, not after. Always use a distinctive marker string for each session.

### 5. After the chat is done — update this file in the Claude Project only
I push code changes to GitHub (step 4). But **`HOW-TO-START.md` lives in the Claude Project Knowledge, not the repo** — so after the chat ends I just re-upload the latest version of this file to the Project so the next chat loads it automatically. No git push needed for HOW-TO-START.md itself.

### 6. Re-upload other changed HTML files to Project Knowledge
Keep project knowledge in sync so next chat Claude always reads the latest version. Priority: files I'm likely to edit again soon (the ones in the table at the bottom of this doc).

---

## 🛡️ VERCEL DEPLOYMENT CHECKS (after every push)

Vercel can silently block deployments even though `git push` succeeds. Always verify after pushing.

### Git author email must match a GitHub-registered email
Vercel cross-checks the commit author's email against GitHub. If the email is wrong (even a typo), the deployment is **Blocked** and the site keeps serving the old version.

**Check your global git config** (do this once per machine):
```powershell
git config --global user.email
git config --global user.name
```

Should print `immortalsapp@gmail.com` and `Sean Qiu`. If either is wrong, reset:
```powershell
git config --global user.email "immortalsapp@gmail.com"
git config --global user.name "Sean Qiu"
```

**If a commit was made with the wrong email**, amend it:
```powershell
git commit --amend --author="Sean Qiu <immortalsapp@gmail.com>" --no-edit
git push origin master --force
```

> Note: `immortalsapp@gmail.com` is the GitHub account email. Vercel key is `colouryartsg@gmail.com` but commit emails must match GitHub, not Vercel.

### Verify the fix is actually live (not just pushed)
Always sanity-check the deployed site for a distinctive marker string from the session's edits:

```powershell
Start-Sleep -Seconds 30   # give Vercel time to redeploy
$pages = @('about','blog','contact','courses','instructors','review','trial','privacy','terms')
$marker = "prevent horizontal overflow"   # CHANGE THIS per session

$failed = 0
foreach ($p in $pages) {
  try {
    $resp = Invoke-WebRequest -Uri "https://liberalwebsitenew.vercel.app/pages/$p" -UseBasicParsing -ErrorAction Stop
    if ($resp.Content -match $marker) {
      Write-Host "LIVE  $p" -ForegroundColor Green
    } else {
      Write-Host "STALE $p" -ForegroundColor Yellow
      $failed++
    }
  } catch {
    Write-Host "ERROR $p - $($_.Exception.Message)" -ForegroundColor Red
    $failed++
  }
}

Write-Host ""
if ($failed -eq 0) { Write-Host "ALL PAGES LIVE" -ForegroundColor Green }
else { Write-Host "$failed pages not live yet" -ForegroundColor Yellow }
```

If pages are `STALE`, check the Vercel dashboard for a "Blocked" or "Failed" deployment — most commonly due to the email issue above.

---


## 📁 FILE STRUCTURE

```
liberalwebsitenew/
├── vercel.json             ← Vercel config (cleanUrls + 301 redirects)
├── index.html              ← English homepage
├── index-zh.html           ← Chinese homepage (paused)
├── assets/
│   ├── logo.webp           ← Navbar logo (NEVER inline base64)
│   ├── logofooter.webp     ← Footer logo
│   ├── liberalfavicon.png  ← Favicon (referenced from every page <head>)
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
│   ├── contact.html        ← Wired to FormSubmit → colouryartsg@gmail.com
│   ├── courses.html
│   ├── instructors.html
│   ├── review.html         ← Parent reviews (replaces old testimonial.html)
│   ├── trial.html
│   ├── privacy.html        ← Privacy Policy (PDPA compliant)
│   ├── terms.html          ← Terms of Use
│   ├── articles/           ← One .html per blog article
│   │   └── liberal-blog-*.html
│   ├── cecily.html         ← Instructor profile (CANONICAL TEMPLATE)
│   ├── calvin.html
│   ├── kate.html
│   ├── jescelyn.html
│   ├── tina.html
│   ├── verginia.html
│   ├── cheng.html
│   ├── aliona.html
│   ├── teresa.html
│   ├── jiang.html
│   ├── mindy.html
│   ├── leonard.html
│   └── loy.html
├── pages-zh/               ← Chinese pages (mirrors pages/) — PAUSED
│   └── articles/
└── tools/                  ← Internal tools, never linked from site
    ├── Liberal_blog-generator.html   ← Blog generator (open in Chrome)
    ├── publish-blog-*.ps1            ← Auto-generated publish scripts
    ├── card-*.html                   ← Auto-generated card HTML
    └── article-*.html                ← Auto-generated article HTML
```

> **Note:** `pages/testimonial.html` was deleted in the Vercel migration (April 2026). All links to `/testimonial` and `/pages/testimonial` are now 301-redirected to `/pages/review` via `vercel.json`.

**Path rules (CRITICAL):**
| File location | Logo src | Asset prefix |
|---|---|---|
| Root (`index.html`) | `assets/logo.webp` | `assets/` |
| `pages/*.html` | `../assets/logo.webp` | `../assets/` |
| `pages/articles/*.html` | `../../assets/logo.webp` | `../../assets/` |

> ⚠️ **Asset filename casing is INCONSISTENT — and Vercel is case-sensitive.** Local Windows is case-insensitive so `Jescelyn.webp` and `jescelyn.webp` work the same on disk, but on Vercel (Linux) the wrong case returns 404. This caused 6 broken instructor photos in April 2026.
>
> **Instructor photo filenames as they actually exist in `assets/`:**
> - **Lowercase:** `cecily.webp`, `calvin.webp`, `kate.webp`, `cheng.webp`, `jiang.webp`, `leonard.webp`, `loy.webp`
> - **Capitalized:** `Jescelyn.webp`, `Tina.webp`, `Verginia.webp`, `Aliona.webp`, `Teresa.webp`, `Mindy.webp`
>
> When referencing instructor photos in `<img src="...">`, copy the exact case from the filename. The canonical source-of-truth for these references is `pages/instructors.html` — when in doubt, `grep` it. Future cleanup: rename the 6 capitalized files to lowercase and update all references.

**Local test server:**
```powershell
cd C:\Users\immor\Downloads\liberalwebsitenew
python -m http.server 8888
```
Then open `http://localhost:8888` in Chrome.

> ⚠️ Local server does NOT respect `vercel.json`. Clean URLs (like `/pages/about`) will 404 locally — append `.html` when testing locally. They work correctly on Vercel in production.

---

## 🚀 VERCEL DEPLOYMENT & CLEAN URLS

Since April 2026 the site is hosted on **Vercel** and uses **clean URLs** (no `.html` in addresses).

### `vercel.json` (repo root, never delete)
```json
{
  "cleanUrls": true,
  "trailingSlash": false,
  "redirects": [
    { "source": "/about-us", "destination": "/pages/about", "permanent": true },
    { "source": "/music/:path*", "destination": "/pages/courses", "permanent": true },
    { "source": "/%E6%97%A5%E6%9C%AC%E4%BA%BA%E3%81%AE%E6%96%B9%E3%81%B8", "destination": "/", "permanent": true },
    { "source": "/pages/testimonial", "destination": "/pages/review", "permanent": true },
    { "source": "/testimonial", "destination": "/pages/review", "permanent": true }
  ]
}
```

### Internal link rules (CRITICAL)
- **All internal `<a href>` values MUST omit `.html`**
  - ✅ `href="pages/about"`, `href="pages/courses#piano"`, `href="../pages/trial"`
  - ❌ `href="pages/about.html"`, `href="../trial.html"`
- Anchors preserved: `pages/courses#piano` stays as-is (the `#piano` is fine)
- External URLs untouched: `https://wa.me/...`, Google Fonts CDN, etc.
- **Blog generator (`tools/Liberal_blog-generator.html`) still writes `.html` links — UPDATE THE TEMPLATES before publishing any new article, or strip `.html` from generated output manually.**

### SEO tags required on every new page
```html
<!-- Every page <head> must have these three -->
<title>[Page-specific title] | Liberal Music & Arts School</title>
<meta name="description" content="[Under 160 chars, page-specific]"/>
<link rel="canonical" href="https://liberalmusicschool.com/pages/[slug]"/>

<!-- Favicon (universal) -->
<link rel="icon" type="image/png" href="../assets/liberalfavicon.png"/>
<link rel="apple-touch-icon" href="../assets/liberalfavicon.png"/>
```

Adjust favicon path per file depth: `assets/` from root, `../assets/` from `pages/`, `../../assets/` from `pages/articles/`.

### Article pages — broken path rule (fixed April 2026)
Articles in `pages/articles/*.html` must link to other pages using `../../pages/[name]` (two levels up), **not** `../[name]`. One article (`liberal-blog-the-magic-of-shared-melodies-a-piano-concert-at-tengah`) had 27 broken links using the wrong depth — all fixed.

### Do NOT inject these scripts
- **Cloudflare `email-decode.min.js`** — site is not on Cloudflare; the script 404s. Previously embedded in `index.html` and `about.html` — both removed April 2026. If any page-generator tool adds it back, strip it out.

### Pre-DNS-switch checklist (before pointing liberalmusicschool.com at Vercel)
- [ ] `vercel.json` present at repo root and committed
- [ ] Deployment Protection: set to "Only Preview Deployments" (so production is public)
- [ ] `contact.html` FormSubmit `_next` URL points to `https://liberalmusicschool.com/pages/contact?sent=1` (not the GitHub Pages URL)
- [ ] All canonical tags use `liberalmusicschool.com`
- [ ] Sitemap generated + submitted to Google Search Console
- [ ] Old GitHub Pages URL tested for 301 to new domain

### DNS at GoDaddy (when ready to switch)
1. GoDaddy → Profile → My Products → `liberalmusicschool.com` → three-dot menu → **Manage DNS**
2. Delete the 4 GitHub Pages `A` records (`185.199.108.153`, `.109.153`, `.110.153`, `.111.153`)
3. Delete the `www` CNAME pointing to `seanqiubrave.github.io`
4. Add:
   - `A` record: name `@`, value `76.76.21.21`
   - `CNAME`: name `www`, value `cname.vercel-dns.com`
5. Leave MX/TXT/SPF records alone
6. Wait 15 min — 48h for propagation

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

> **Review link target is `review.html`** (`testimonial.html` is deprecated).  
> **中文 is currently disabled** while the bilingual site is paused — render as a grey `<span>`, not a live `<a href>`. See HEADER-FOOTER-GUIDE.md for exact markup.

---

## 👩‍🏫 INSTRUCTOR PROFILE PAGES

All follow the same template — **`cecily.html` is the canonical base**.

| File | Instructor | Speciality |
|---|---|---|
| `cecily.html` | Ms Cecily | Principal · Erhu · Chinese Instruments |
| `calvin.html` | Mr Calvin | Vice Principal · Drums · Guitar · Ukulele |
| `kate.html` | Ms Kate | Piano · ABRSM |
| `jescelyn.html` | Ms Jescelyn | Piano · ABRSM |
| `tina.html` | Ms Tina | Piano · Vocal |
| `verginia.html` | Ms Verginia | Piano · Vocal |
| `cheng.html` | Ms Cheng | Violin · Piano |
| `aliona.html` | Ms Aliona | Violin · Strings |
| `teresa.html` | Ms Teresa | Violin |
| `jiang.html` | Ms Jiang | Erhu · Chinese Instruments · Violin · Guqin |
| `mindy.html` | Ms Mindy | Vocal · Music for Kids |
| `leonard.html` | Mr Leonard | Drums · Guitar · Ukulele · Piano |
| `loy.html` | Mr Loy | Guitar · Drums · Ukulele |

**Key rules for instructor pages:**
- Book card button: `Book Trial Class` (no "Free")
- Nav active link: always **Instructors**
- "Other Instructors" strip: always shows the others, never the current instructor
- Add new page to `instructors.html` grid as `<a class="icard">` wrapper

---

## 📍 WHATSAPP NUMBERS (never change)
| Branch | Number | wa.me link |
|---|---|---|
| Tengah | +65 8922 2848 | `https://wa.me/6589222848` |
| Tampines | +65 8892 1198 | `https://wa.me/6588921198` |
| Jurong West | +65 9627 7588 | `https://wa.me/6596277588` |
| Le Quest | +65 9627 7582 | `https://wa.me/6596277582` |
| Coloury Art | +65 8922 2848 *(shares Tengah's number)* | `https://wa.me/6589222848` |

> **Changed April 2026:** Jurong West got its own dedicated number (`9627 7588`). Previously it was grouped with Le Quest / Jurong Point under `9627 7582`. Le Quest still uses `7582`. Coloury Art (the 5th location, opening soon) routes to Tengah's number. The FAB popup on every page now shows **5 separate rows**.

---

## ✅ QUICK CHECKLIST (every page)

**Head**
- [ ] Nunito + Quicksand fonts imported
- [ ] `:root` CSS variables present and unmodified
- [ ] `<title>`, `<meta name="description">`, `<link rel="canonical">` all present and page-specific
- [ ] Favicon: `<link rel="icon" type="image/png" href="assets/liberalfavicon.png"/>` + `<link rel="apple-touch-icon" ...>` (adjust path per file depth)
- [ ] NO Cloudflare email-decode script (`cdn-cgi/scripts/.../email-decode.min.js`)

**Header**
- [ ] Announcement bar: `#f56c22`, correct trial link
- [ ] Nav `top:36px`, `<main>` `padding-top:108px`
- [ ] Logo: correct asset path for file depth, height `42px` (never base64)
- [ ] Nav link order correct, active page has `class="active"`
- [ ] Book Trial button: `class="btn btn-cta"` + `style="padding:10px 22px;font-size:14px;"`
- [ ] Mobile drawer present

**Footer**
- [ ] Background `#1F2A44`, logo `logofooter.webp` height `56px`
- [ ] Brand text: `color:#fff`, `font-size:15px`, ends with `— Ages 2.5+ to Adult`
- [ ] Social icons: `.webp` assets with `filter:brightness(0) invert(1)`, no borders/boxes
- [ ] All 5 locations with full names
- [ ] 5th location = **Coloury Art By Liberal** (clickable → colouryart.com, pin `✦`)
- [ ] Nav links: `color:#fff`, `font-size:15px` — Review link → `pages/review` (no `.html`)
- [ ] **Privacy Policy** → `pages/privacy` (or `privacy` from inside `pages/`), **Terms of Use** → `pages/terms` — never `#`, never `.html`
- [ ] **中文版本 is disabled** (grey `<span>`, not a live `<a>`)
- [ ] Bottom bar has `v1.0.1` version tag
- [ ] Kill-bottom-gap rules present

> For exact HTML/CSS of every footer element, see **HEADER-FOOTER-GUIDE.md**.

**Floating**
- [ ] WhatsApp FAB uses `whatsapp.webp` image (32px, no filter — green-on-green blends so the white phone silhouette shows through). NOT the 💬 emoji.
- [ ] WhatsApp popup shows **5 branches** in this exact order: 🏡 Tengah · 🌅 Tampines · 🌸 Jurong West · 🏬 Le Quest · ✦ Coloury Art
- [ ] All 5 numbers correct (see WHATSAPP NUMBERS table above)
- [ ] Mobile sticky CTA bar with trial link

**Article pages only (`pages/articles/*.html`)**
- [ ] Asset paths use `../../assets/` (two levels up)
- [ ] Nav links use `../../pages/` prefix — example `href="../../pages/about"` (no `.html`)
- [ ] Hero image present (1200×600px, `../../assets/blogname.webp`)
- [ ] Back to Blog link points to `../../pages/blog` (no `.html`)
- [ ] CTA band at bottom links to `../../pages/trial` (no `.html`)
- [ ] Canonical tag: `https://liberalmusicschool.com/pages/articles/[slug]`
- [ ] Favicon tag: `<link rel="icon" href="../../assets/liberalfavicon.png"/>`

**Instructor profile pages only**
- [ ] Breadcrumb: Home → Our Instructors → Instructor Name
- [ ] Active nav link set to **Instructors**
- [ ] Book card button says `Book Trial Class` (not "Free")
- [ ] "Other Instructors" strip at bottom shows **all 12 other instructors** (excludes the current page's instructor) — each card uses prefixed names (`Mr Calvin`, `Ms Kate`, etc.)
- [ ] Strip cards in canonical order: Cecily → Calvin → Kate → Jescelyn → Tina → Verginia → Cheng → Aliona → Teresa → Jiang → Mindy → Leonard → Loy *(skip self)*
- [ ] Each card image uses **correct filename casing** — see asset casing note in File Structure section

---

## 📱 MOBILE OVERRIDES — `@media(max-width:540px)`

Applied on `index.html` as of April 2026. The other 24 pages need the same treatment in a future batch. All rules live ONLY inside the `@media(max-width:540px)` block — desktop and tablet layouts are 100% preserved.

### What's hidden on mobile
- `#trust` (entire "Why is Liberal the Most Trusted..." section)
- `.fc-a` and `.fc-b` (floating Success Stories + ABRSM Pass Rate cards)
- `.hero-notes` (animated music-note emojis in hero)
- `.hero-ring` (decorative ring outline)
- `.vis-a` and `.vis-b` (peach + teal decorative circles)
- `.fc-c` (floating proof card)
- `.glance-sep` (`·` separators between glance items)
- `#heroIframe` (iframe hidden — replaced by tap-to-play poster)

### What's resized on mobile
- `.hero h1`: `clamp(2.2rem, 10.5vw, 3rem)` (was 75px)
- `.hero-kicker` pill: `font-size:13px; padding:7px 14px; white-space:normal`
- `.glance-card`: `font-size:13px; flex-wrap:wrap; justify-content:center`
- `.hero-desc`: `font-size:16px; padding-right:56px` (clears WhatsApp FAB)
- `.ann-bar`: `height:auto; min-height:36px; padding:6px 12px`
- `.ann-bar a`: `white-space:normal; font-size:12px`
- `.stat-cell`: `padding:32px 12px 28px`; `.stat-label`: 15px; `.stat-sub`: 13px
- `.stat-icon`: 48px × 48px; `.stat-num`: 2rem

### Layout rules on mobile
- `.hero{min-height:0; align-items:flex-start; padding-bottom:40px}` — no forced 100vh height
- `.hero-grid{gap:20px}` — tight spacing between video and copy
- `.hero-frame{width:100%; min-width:0; background:#000}` — forces frame to render at full width
- `.hero-vis{width:100%; max-width:420px}` — caps video width
- `.hero-mobile-play{display:flex}` — shows tap-to-play YouTube poster
- `.faq-inner{grid-template-columns:1fr}` + `.faq-card{height:auto}` — FAQ stacks to 1 column

### Mobile hero video (new pattern)
On mobile, the autoplay YouTube iframe is replaced by a **tap-to-play poster**:
```html
<div class="hero-frame" id="heroFrame">
  <iframe id="heroIframe" src="..." ...></iframe>
  <button type="button" class="hero-mobile-play" id="heroMobilePlay" aria-label="Play video">
    <img src="https://img.youtube.com/vi/[VIDEO_ID]/hqdefault.jpg" alt="Video preview" loading="lazy"/>
    <span class="hero-mobile-play-btn" aria-hidden="true">
      <svg viewBox="0 0 24 24" width="36" height="36" fill="#fff"><path d="M8 5v14l11-7z"/></svg>
    </span>
  </button>
</div>
```
Plus JS: tap the button, it swaps itself out for a freshly-injected iframe with `autoplay=1` (works because it's in response to a user gesture — bypasses mobile autoplay blockers).

Rationale: mobile Chrome's Data Saver and Battery Saver modes silently block autoplay YouTube embeds. The tap-to-play pattern is reliable, faster-loading, and is what Apple.com / Stripe use.

---

Keep these files uploaded and current in Claude Project Knowledge:

| File | Purpose |
|---|---|
| `HOW-TO-START.md` | This file — workflow + design system summary |
| `HEADER-FOOTER-GUIDE.md` | Full CSS/HTML source of truth for header & footer |
| `LIBERAL_ART_BIBLE.md` | Design philosophy & art direction |
| `vercel.json` | Vercel config — cleanUrls + 301 redirects (NEVER delete) |
| `index.html` | English homepage (reference) |
| `pages/about.html` | Re-upload after each edit |
| `pages/courses.html` | Re-upload after each edit |
| `pages/instructors.html` | Re-upload after each edit |
| `pages/review.html` | Parent reviews page (replaces old testimonial.html — testimonial.html DELETED April 2026) |
| `pages/blog.html` | Re-upload after each edit |
| `pages/contact.html` | FormSubmit wired to colouryartsg@gmail.com |
| `pages/trial.html` | Re-upload after each edit |
| `pages/privacy.html` | Privacy Policy (PDPA) |
| `pages/terms.html` | Terms of Use |
| `pages/cecily.html` | Canonical instructor template — re-upload after any edit |
| `pages/calvin.html` | Re-upload after each edit |
| `pages/kate.html` | Re-upload after each edit |
| `pages/jescelyn.html` | Re-upload after each edit |
| `pages/tina.html` | Re-upload after each edit |
| `pages/verginia.html` | Re-upload after each edit |
| `pages/cheng.html` | Re-upload after each edit |
| `pages/aliona.html` | Re-upload after each edit |
| `pages/teresa.html` | Re-upload after each edit |
| `pages/jiang.html` | Re-upload after each edit |
| `pages/mindy.html` | Re-upload after each edit |
| `pages/leonard.html` | Re-upload after each edit |
| `pages/loy.html` | Re-upload after each edit |
