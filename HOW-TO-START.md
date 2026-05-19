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
│   ├── mrt.webp            ← MRT icon for footer .foot-loc-meta lines (April 28 2026)
│   ├── pianocourse.webp    ← Piano course page hero image
│   ├── dancecourse.webp    ← Ballet course page hero image (also used on courses.html Ballet card)
│   ├── hiphop.webp         ← Hip Hop course page hero image (added May 4 2026)
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
│   ├── courses.html        ← Course-grid landing page; Dance grid links to ballet-course / hiphop-course
│   ├── instructors.html
│   ├── review.html         ← Parent reviews (replaces old testimonial.html)
│   ├── trial.html
│   ├── privacy.html        ← Privacy Policy (PDPA compliant)
│   ├── terms.html          ← Terms of Use
│   ├── piano-course.html   ← Course detail page — CANONICAL TEMPLATE for [subject]-course pages
│   ├── ballet-course.html  ← Course detail page (RAD pathway · added May 4 2026)
│   ├── hiphop-course.html  ← Course detail page (showcase performance · added May 4 2026)
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
├── locations/              ← Branch landing pages (created May 17 2026)
│   ├── tengah.html         ← Flagship HQ
│   ├── bukit-batok.html    ← Le Quest
│   ├── jurong-west.html
│   └── tampines.html
├── locations-zh/           ← Chinese branch pages (created May 18 2026 — 4 of 5 done; Coloury Art pending)
│   ├── tengah.html         ← Flagship HQ (登加旗舰总部)
│   ├── bukit-batok.html    ← Le Quest (武吉巴督)
│   ├── jurong-west.html    ← 裕廊西
│   └── tampines.html       ← 淡滨尼 (Wed closed)
├── pages-zh/               ← Chinese pages (mirrors pages/) — instructor profiles + key root pages done May 18 2026
│   ├── ballet-course.html  ← Ballet Course ZH (RAD pathway) — created May 19 2026 — canonical ZH course-detail template
│   ├── hiphop-course.html  ← Hip Hop Course ZH — created May 19 2026
│   ├── cecily.html         ← Principal · Erhu (canonical ZH instructor template)
│   ├── calvin.html         ← Vice Principal · Drums/Guitar/Uke
│   ├── kate.html           ← Piano · ABRSM
│   ├── jescelyn.html       ← Piano · ABRSM
│   ├── tina.html           ← Piano · Vocal
│   ├── verginia.html       ← Piano · Vocal
│   ├── cheng.html          ← Violin · Piano
│   ├── aliona.html         ← Violin · Strings
│   ├── teresa.html         ← Violin
│   ├── jiang.html          ← Erhu · Chinese Instruments
│   ├── mindy.html          ← Vocal · Music for Kids
│   ├── leonard.html        ← Drums · Guitar · Uke · Piano
│   ├── loy.html            ← Guitar · Drums · Uke
│   ├── privacy.html        ← Chinese Privacy Policy (May 14 2026)
│   ├── terms.html          ← Chinese Terms of Use (May 14 2026)
│   ├── contact.html        ← Chinese contact page (May 14 2026)
│   └── articles/           ← 2 Chinese article pages (May 14 2026)
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
| Root (`index.html`, `index-zh.html`) | `assets/logo.webp` | `assets/` |
| `pages/*.html`, `pages-zh/*.html` | `../assets/logo.webp` | `../assets/` |
| `pages/articles/*.html`, `pages-zh/articles/*.html` | `../../assets/logo.webp` | `../../assets/` |
| `locations/*.html`, `locations-zh/*.html` | `../assets/logo.webp` | `../assets/` |

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
Home | About | Courses | Instructors | Review | Blog | Contact ▾
```
Right side: `[中文]` → `[Book Trial Class]` (orange pill button)

**Contact is now a dropdown** (since May 17 2026 on `index.html` + 4 location pages, NOT YET propagated to other pages):
```
Contact ▾
  ├─ Jurong West
  ├─ Bukit Batok (Le Quest)
  ├─ Tampines
  └─ Tengah (HQ) [NEW]
```
- Trigger label is exactly **`Contact`** (not "Contact & Locations" — was renamed)
- Tengah carries the `(HQ)` suffix + orange `New` badge chip
- No 📍 pin emojis on dropdown items (kept clean)
- Dropdown CSS expects nav-collapse at **1024px** (raised from 900px for Nest Hub — see breakpoint notes below)

> **Review link target is `review.html`** (`testimonial.html` is deprecated).  
> **中文 toggle status (May 19, 2026):** **bidirectionally active** on 28 page pairs:
> - Root `index.html` ↔ `index-zh.html`
> - All 13 EN instructor pages ↔ 13 ZH instructor pages (May 19 2026 sweep activated EN side)
> - 12 EN course-detail pages → ZH course slugs (May 19 sweep activated EN side; **only 2 ZH course pages built so far** — ballet-course, hiphop-course — so 10 of the 12 EN→ZH toggles currently 404 until those ZH course pages ship)
> - 3 EN root pages (privacy, terms, contact) ↔ 3 ZH counterparts (May 14 2026)
> - 2 EN article pages ↔ 2 ZH article pages (May 14 2026)
>
> Still **disabled-grey** on the EN side (correct — no ZH counterpart exists yet):
> - 6 EN main pages: about, courses, instructors, blog, review, trial
> - 4 EN location pages: tengah, bukit-batok, jurong-west, tampines (ZH counterparts EXIST but EN toggle still needs the §14.17 4-spot activation — pending item #10)
>
> On ZH pages, the toggle reverses direction (EN → links to the EN counterpart per-page, not to the EN homepage). See HEADER-FOOTER-GUIDE.md §14.5 + §14.16 + the new §14.17 "Activating the 中文 Toggle on an EN Page" for exact 4-spot markup and bulk activation script.

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
| Coloury Art | +65 8995 1163 *(dedicated number from April 28 2026)* | `https://wa.me/6589951163` |

> **Changed April 2026:** Jurong West got its own dedicated number (`9627 7588`). Previously it was grouped with Le Quest / Jurong Point under `9627 7582`. Le Quest still uses `7582`. The FAB popup on every page now shows **5 separate rows**.
>
> **Changed April 28 2026:** Coloury Art (Jurong Point) now has its own dedicated number `8995 1163` (`wa.me/6589951163`). Previously it shared Tengah's `8922 2848`. Tengah's number is unchanged. The change was applied site-wide across all 25 pages in one batch — see "April 28 2026 session" notes below.

---

## 📍 LOCATION PAGES (`locations/*.html` — added May 17 2026)

Four standalone branch landing pages live at the repo root in the `locations/` folder (NOT inside `pages/`). They're separate from `pages/` because they have their own URL prefix (`/locations/tengah`, `/locations/bukit-batok`, etc.) and a different template focused on local-search AEO.

| File | Branch | Role | URL | Verify marker |
|---|---|---|---|---|
| `locations/tengah.html` | Tengah | **Flagship HQ** (NEW) | `/locations/tengah` | `Tengah location page AEO marker May 17 2026` |
| `locations/bukit-batok.html` | Bukit Batok (Le Quest) | Branch | `/locations/bukit-batok` | `Bukit Batok location page AEO marker May 17 2026` |
| `locations/jurong-west.html` | Jurong West | Established cornerstone (NOT HQ) | `/locations/jurong-west` | `Jurong West location page AEO marker May 17 2026` |
| `locations/tampines.html` | Tampines | Branch | `/locations/tampines` | `Tampines location page AEO marker May 17 2026` |

**Tengah is now the Flagship HQ — never call any other location HQ.** Jurong West was historically referred to as HQ in earlier copy, but the actual headquarters moved to the new Tengah location in 2026. Jurong West is now described as the *"established cornerstone of Liberal Music & Arts School in the West"*.

### Canonical template
`locations/tengah.html` is the **canonical template** — clone from it when adding a 5th location (e.g. a future Coloury Art landing page would be `locations/coloury-art.html`).

### Page section order (top to bottom)
1. **Hero** — breadcrumb · pill tag · `<H1>` headline · sub-headline · Quick Facts (4-up grid) · 2 CTAs · 10 course pills
2. **Location Hub** — address · "Getting Here" paragraph · Studio Hours · Chat-on-WhatsApp action button · Google Maps iframe
3. **Programs** — 10 course cards in 4-col responsive grid (same 10 as `courses.html`)
4. **Stats Strip** — 4 metrics (20K+ Families · 4.7★ Rating · 15+ Years · 10+ Programmes)
5. **FAQ** — 3 Q&As with `<details>` accordion (schema⇄visible synced)
6. **CTA Banner** — Book Trial Class button

### JSON-LD schema
Each page carries **TWO JSON-LD blocks** in `<head>`:
- `@type: "MusicSchool"` — with branch-specific name, address, geo, openingHoursSpecification, sameAs to Google Business Profile
- `@type: "FAQPage"` — mirrors the visible FAQ Q&A text exactly (auditors check this)

### Real Google Business Profile hours (each branch is different — DO NOT use generic "Daily 1pm-9pm")

| Branch | Mon-Fri | Sat | Sun | Wed |
|---|---|---|---|---|
| Tengah | 1pm-9pm | 9am-7:30pm | 9am-7:30pm | open |
| Bukit Batok | 1pm-9pm | **9am-8pm** | **9:30am-7:30pm** | open |
| Jurong West | 1pm-9pm | **9:30am-8:30pm** | **9:30am-8:30pm** | open |
| Tampines | 1pm-9pm (Mon/Tue/Thu/Fri only) | 9am-7pm | 9am-7pm | **CLOSED** |

> **Tampines Wednesday-closed handling:** in the JSON-LD `openingHoursSpecification` array, OMIT Wednesday entirely (schema.org idiom for "closed"). On the visible Studio Hours block, show as `<strong style="color:var(--or)">Wed: Closed</strong>` — orange callout so visitors notice. FAQ Q2 must also call this out: *"...Tuesday, Thursday, and Friday from 1:00 PM to 9:00 PM, and on weekends from 9:00 AM to 7:00 PM. Please note that our Tampines studio is closed on Wednesdays."*

### Address corrections from earlier wrong values
- **Le Quest** is `4 Bukit Batok St 41, #01-83, Singapore 657991` — NOT `#01-K1` (corrected per Google Business Profile, May 17 2026). Site-wide sweep needed: anything still saying `#01-K1` is stale.

### Coloury Art (Opening Soon — 5th location)
- Address: `#03-07C Level 3, Jurong Point, Singapore 648886` (near Boon Lay MRT EW27)
- WhatsApp: `8995 1163` (dedicated since April 28 2026)
- External site: `colouryart.com`
- Currently rendered as **footer card 5/5** (clickable, `.foot-loc.soon` orange-tinted) and as **FAB row 5/5**
- No standalone `locations/coloury-art.html` yet — would be created when Coloury Art officially opens

### When the user uploads a new location-related image
The hero / Studio Preview section was attempted on Bukit Batok with a placeholder image but removed when the user said "remove this part". **Established precedent:** do NOT add a Studio Preview / interior-photo section to a location page without a real image file already in `/assets/`. Suggest at the end of the response instead.

### Site-wide UI sync — what still needs propagating from location pages
Only `index.html` and the 4 `locations/*.html` files currently have:
- New Contact ▾ dropdown
- Nav-collapse breakpoint at 1024px (Nest Hub fix)
- WA FAB with 5 branches HQ-first

All other ~30 pages still have the old simple `Contact` link and the old 4-branch FAB. Site-wide propagation is **pending**.

---

## 📱 SOCIAL MEDIA LINKS

Wire these into the footer `.foot-soc` block on every page. All open in new tabs with `target="_blank" rel="noopener noreferrer"`.

| Platform | URL |
|---|---|
| Instagram | `https://www.instagram.com/liberalmusic_arts/` |
| Facebook | `https://www.facebook.com/liberalmusicandarts/` |
| YouTube | `https://youtube.com/@liberalmusicartsschoolsingapor?si=0EdJLdRw-WoXKxOR` |
| Xiaohongshu | *pending — currently `href="#"` site-wide* |

> All 25 main pages (index + 9 pages + 13 instructor profiles + 2 articles) had their social links wired up on **April 27, 2026** — they were `href="#"` placeholders before that.
> When the Xiaohongshu URL is supplied, run a single regex sweep across every page that has `aria-label="Xiaohongshu"`.

> Note on the YouTube `?si=…` parameter: it's a YouTube share-tracking session ID. Stripping it makes for a cleaner URL but is harmless either way. The version above is what was wired live.

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
- [ ] **Contact ▾ dropdown present in BOTH desktop nav and mobile drawer** with 4 location items in order: Jurong West · Bukit Batok (Le Quest) · Tampines · Tengah (HQ) [NEW]. See HEADER-FOOTER-GUIDE.md §4.5 for HTML+CSS. Breakpoint pair (900/901 vs 1024/1025) must match the page's existing nav-collapse — see HEADER-FOOTER-GUIDE.md §4.5 table.
- [ ] **`.kw` underline animation CSS present** in `<style>` (HEADER-FOOTER-GUIDE.md §4.7). The 3-rule canonical block: `.kw{...isolation:isolate}` + `.kw::after{...#8ddbd1...0.95s forwards}` + `@keyframes kw`. The `isolation:isolate` is mandatory — without it the underline is invisible behind page-hero gradients.
- [ ] **Hero H1 wraps its keyword in `<span class="kw">`** (not `<em>`) — one keyword per headline. Skip on pages without a hero H1 (privacy, terms, blog articles — the CSS is still present as a placeholder for future use).

**Footer**
- [ ] Background `#1F2A44`, logo `logofooter.webp` height `56px`
- [ ] Brand text: `color:#fff`, `font-size:15px`, ends with `trusted by over 20,000 families in Singapore since 2009.`
- [ ] **Footer brand paragraph (canonical copy — use verbatim across all pages):**
      `Liberal Music & Arts School nurtures creativity, confidence, and a lifelong love of music and the arts — for ages 2.5 to adult. With expert teachers, holistic learning, and proven results, we are proud to be trusted by over 20,000 families in Singapore since 2009.`
- [ ] Social icons: `.webp` assets with `filter:brightness(0) invert(1)`, no borders/boxes
- [ ] Social link `href` values point to the live URLs (see SOCIAL MEDIA LINKS table above): Instagram, Facebook, YouTube wired with `target="_blank" rel="noopener noreferrer"`. Xiaohongshu is still `href="#"` until a URL is supplied.
- [ ] All 5 locations with full names
- [ ] 5th location = **Coloury Art By Liberal** (clickable → colouryart.com, pin `✦`)
- [ ] Each location card carries a `.foot-loc-meta` line: 🚇 nearest MRT + 🕐 `Daily 1pm–9pm` (or `✦ Opening Soon` for Coloury Art) — see PAGE-SPECIFIC NOTES April 28 2026 section below for the exact text per branch
- [ ] Coloury Art card subtitle = real address (`#03-07C Level 3, Jurong Point` + `Singapore 648886`), NOT `colouryart.com`
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

## 📝 PAGE-SPECIFIC NOTES (April 27, 2026 session)

Captures changes that don't fit the cross-page checklists above. Treat these as the current state when re-editing these pages.

### `pages/contact.html`
- **Branch hours unified to `Daily: 1pm–9pm`** for all 4 Liberal branches (Tengah, Tampines, Jurong West, Le Quest). Replaced the old `Mon–Fri: 2pm–9pm  ·  Sat–Sun: 9am–6pm` split. Coloury Art card still shows `Visit colouryart.com` — left untouched since it's not a Liberal branch.
- **Address cards no longer carry the `· Near X MRT` suffix.** Postal code now closes the address line directly. Don't reintroduce the MRT suffix.

### `pages/review.html`
- **Removed two sections** in this session:
  1. The "Trust Numbers" strip headed *"The Results Speak for Themselves"* (the four stat tiles: 20,000+ Students Enrolled, 99% ABRSM & Trinity Pass Rate, 5★ Google Rating, 15yr Teaching Experience).
  2. The "Leave a Review" CTA section headed *"Had a Great Experience?"* with the Google Review button.
- The CTA Banner (`Start Today`) now follows directly after the parent reviews grid.
- Dead CSS rules `.trust-strip`, `.trust-grid`, `.trust-item`, `.trust-num`, `.trust-lbl`, `.review-cta`, `.google-btn` are still in the `<style>` block — harmless but pruneable.

### `pages/instructors.html`
- **"5 Convenient Locations" perk** in the recruitment section now reads:
  *"Teach at a branch close to home — across Tengah, Tampines, Jurong West and Le Quest, plus Coloury Art By Liberal at Jurong Point **(Opening Soon)**"* with `(Opening Soon)` styled in brand orange (`#FF6600`, `<strong>`).
- **`View Open Positions` button is disabled.** Rendered as a `<span class="btn btn-cta" aria-disabled="true">` with grey background `#CBD5E1`, `cursor:not-allowed`, `pointer-events:none`, `box-shadow:none`. Same approach as the disabled 中文 nav button.

### `pages/articles/*.html`
- The 2 existing article pages (`liberal-blog-the-magic-of-shared-melodies-a-piano-concert-at-tengah.html`, `from-first-note-to-full-confidence-a-6-month-journey.html`) were upgraded from the older 3-row WhatsApp panel (`Tengah / Tampines / Jurong West / JP`) to the canonical 5-row layout. New articles must use the 5-row format.

---

## 📝 PAGE-SPECIFIC NOTES (April 28–29, 2026 session — AEO + Footer + Coloury number)

Big multi-page AEO push and a number swap. Treat these as the current state.

### `index.html` — AEO/SEO rewrite
- **Duplicate `FAQPage` JSON-LD removed.** The page previously had two `@type: "FAQPage"` blocks, triggering "Duplicate field 'FAQPage'" in Google Search Console. The voice-search/AI block (formerly above the fonts import) was deleted; the canonical block now sits directly above the visible `#faq` carousel and its 8 questions match the visible cards verbatim. **Never reintroduce a second FAQPage block.** A second JSON-LD `@type: "MusicSchool"` block at the top is fine — different `@type` doesn't trigger the duplicate error.
- **FAQ carousel rewritten** with ABRSM-keyword questions for AEO (Perplexity, SearchGPT, Gemini). Now 8 questions across 2 slides × 4 cards each. Schema and visible card text must match exactly — if you edit one, edit both.
- **FAQ card sizing changed:** `.faq-card` uses `min-height:280px` (was fixed `height:280px`) and `.faq-card-a` no longer has `overflow:hidden`. This lets longer answers grow without being clipped while keeping the visual rhythm. Mobile override `min-height:0` already in place.
- **FAQ arrows moved inside the carousel:** `.faq-prev{left:12px}` / `.faq-next{right:12px}` (were `-22px` / `-22px` outside). Modern carousel pattern (Apple/NYT/BBC) — arrows hover over content edges, never clip on horizontal-overflow rules.
- **Hero copy rewritten:** H1 was *"Proven. Trusted. ABRSM Success!"* → now *"Singapore's Top-Rated Music School for ABRSM Success"* with `<span class="kw">Top-Rated</span>` as the orange-keyword span. Subtitle was *"Empowering 20,000+ students through 17 years of expert coaching..."* → now *"Empowering 20,000+ students since 2009. We specialize in fast-track ABRSM preparation with a proven 99% pass rate, helping students master Piano, Violin, Drums, and Vocals across 5 convenient Singapore locations."* The new subtitle repeats the AEO terms baked into the FAQ schema (`fast-track ABRSM preparation`, `99% pass rate`, `5 Singapore locations`).
- **Heads-up for future passes:** the `MusicSchool` JSON-LD at the top of `index.html` still uses old `seanqiubrave.github.io/liberalwebsitenew/` URLs in `@id`, `url`, `logo`, `image`, and employee `@id` fields. Once DNS cuts over to `liberalmusicschool.com`, sweep all of those. The `<meta name="description">` tag at line ~8 also still has the older "Singapore's trusted music school..." copy and could be aligned with the new hero positioning.

### Footer locations — applied site-wide to ALL 25 pages
Every page (root + 9 main pages + 13 instructor profiles + 2 articles) now carries an extra `.foot-loc-meta` line on each of the 5 location cards: 🚇 nearest MRT + 🕐 `Daily 1pm–9pm` (or `✦ Opening Soon` for Coloury Art). This is for AEO/local-search — Perplexity / SearchGPT / Gemini scrape the footer for "music school near {MRT}" queries.

| Branch | Meta line |
|---|---|
| Tengah | 🚇 Near future Jurong Region Line (opening 2028) · 🕐 Daily 1pm–9pm |
| Tampines | 🚇 Near Tampines West MRT · 🕐 Daily 1pm–9pm |
| Jurong West | 🚇 Near Lakeside MRT · 🕐 Daily 1pm–9pm |
| Le Quest | 🚇 Near Bukit Batok MRT · 🕐 Daily 1pm–9pm |
| Coloury Art | 🚇 Near Boon Lay MRT · ✦ Opening Soon |

The Coloury Art card also got its real address — `#03-07C Level 3, Jurong Point · Singapore 648886` (was previously just `colouryart.com` as the subtitle).

The MRT icon uses `assets/mrt.webp` — purple/blue source rendered white via `filter:brightness(0) invert(1); opacity:0.8`. Asset path varies by file depth: `assets/mrt.webp` from root, `../assets/mrt.webp` from `pages/`, `../../assets/mrt.webp` from `pages/articles/`. **Vercel is case-sensitive — filename must be lowercase `mrt.webp`.**

CSS rules added (inside the existing `<style>` block on every page, after `.foot-loc.soon .foot-loc-text span`):
```css
.foot-loc-meta{display:block;margin-top:6px;font-size:11.5px;color:rgba(255,255,255,.55);line-height:1.5;letter-spacing:.1px}
.foot-loc-meta .sep{margin:0 6px;color:rgba(255,255,255,.3)}
.foot-loc.soon .foot-loc-meta{color:rgba(255,170,90,.7)}
.foot-loc.soon .foot-loc-meta .sep{color:rgba(255,170,90,.4)}
```

> **Source-of-truth for the new footer cards is `HEADER-FOOTER-GUIDE.md` § 6** — copy from there when adding new pages.

### Coloury Art WhatsApp number swap — site-wide
- **Old number:** `8922 2848` (shared with Tengah) → **New number:** `8995 1163`
- New `wa.me` link: `https://wa.me/6589951163`
- Applied to all 10 main HTML files + 13 instructor pages + 2 articles = **25 pages**
- Tengah's `8922 2848` is unchanged everywhere (regression-checked via grep before each push)
- `contact.html` had two Coloury references: the FAB panel `wa-row` AND the branch-card `wa-btn` ("WhatsApp · 8995 1163") — both updated
- `trial.html` has a green-button grid where the Coloury button is `grid-column:span 2` and shows only "Coloury Art By Liberal" with no visible number — link updated, no visible-number to change there
- **`pages/privacy.html` + `pages/terms.html`** were rebuilt from a stale 3-row WhatsApp panel (Tengah / Tampines / Jurong West / JP) into the canonical 5-row layout — these were the last two files lagging behind

### Verify-before-push markers used in this session
For the verify pattern in HOW-TO-START.md step 4, distinctive marker strings to use:
- Footer locations update: `Near future Jurong Region Line (opening 2028)`
- Coloury number swap: `6589951163` (the new wa.me link, not in any pre-April-28 file)
- AEO FAQ rewrite (index only): `AEO ABRSM rewrite Apr 28 2026`
- Hero rewrite (index only): `Top-Rated Music School`

---

## 📝 PAGE-SPECIFIC NOTES (May 4, 2026 session — Course detail pages + GSC schema fix)

Big session covering a Google Search Console schema error fix + introduction of standalone course detail pages following a new canonical template (`piano-course.html`).

### `index.html` — JSON-LD multi-type fix for GSC "Invalid object type" error
Google Search Console reported **"Invalid object type for field '<parent_node>'"** in the Review snippets report, affecting `https://liberalmusicschool.com/`. The cause: the `aggregateRating` block (5.0/5.0, 200 ratings) was attached to a parent of `@type: "MusicSchool"`, but Google's review-snippet validator only accepts ratings attached to a specific allowlist of types (`LocalBusiness`, `Product`, `Course`, `Event`, `Organization`, etc.). `MusicSchool` alone is not on the list — even though it's a subtype of `Organization` via inheritance, Google's parser doesn't traverse that.

**Fix applied:** changed `@type` from a single string to a multi-type array on the root entity AND on all 5 nested branch entities inside `location[]`:

```json
"@type": ["MusicSchool", "LocalBusiness"]
```

This keeps the music-school semantics AND lands the entity on Google's review-snippet allowlist via `LocalBusiness`. Bonus: the 5 branches are now also eligible for local-business rich results in Google Maps and "music school near me" queries.

After pushing, click **VALIDATE FIX** in GSC → Review snippets report. Google recrawls and clears the issue (typically a few days).

**Heads-up for a future cleanup pass:** the `aggregateRating` block currently shows `ratingValue: "5.0"` with `ratingCount: "200"` AND `reviewCount: "200"` (identical values). A perfect 5.0/5.0 with both counts identical at exactly 200 looks fabricated to Google's spam systems. Two suggestions:
1. Use real numbers from each of your 5 Google Business Profile listings.
2. Don't set `ratingCount` and `reviewCount` to the same value — `reviewCount` is written reviews; `ratingCount` is broader star-only ratings. They're rarely equal.

Verify-before-push marker: `Fix May 4 2026: @type set to multi-type`

### Course detail pages — new pattern (`[subject]-course.html`)
Introduced standalone course detail pages following `piano-course.html` as the canonical template. URL slug convention is **`[subject]-course`** (e.g., `piano-course`, `ballet-course`, `hiphop-course`, `violin-course`) — matches what the "Other Courses" strip on `piano-course.html` already references (`violin-course`, `guitar-course`, `drum-course`, `vocal-course`, `ukulele-course`, etc.).

**Canonical structure (8 sections):**
1. **Hero** (`.page-hero`) — gradient bg, breadcrumb (Home → Courses → [Subject]), kicker pill `🎹 [Subject] Course · [Programme]`, headline with orange `.kw` underline animation on the word "Course", lead, 2 CTAs (Book Trial Class + About the Course), 4 hero-stats
2. **About the Course** (`#about` anchor target, `.about-grid`) — 2-column: copy on left + image on right with floating `.about-badge` overlay (icon + 2-line text)
3. **What You'll Learn** (`.curr-grid`) — 4 cards with icon, h3, p, animated orange top border on hover
4. **Who This Course Is For** (`.levels-grid`) — 4 simple level cards
5. **Stats Strip** (`.stats-strip`) — dark navy band with 4 large brand stats (20,000+ Students · 15+ Years · 5 Locations · 5★ Google Rating)
6. **Why Liberal for [Subject]** (`.why-grid`) — 4 cards with icon, h3, p
7. **Explore Other Courses** (`.other-strip`) — horizontal scroller of 9–10 sister course cards (excludes self, ends with orange "View All Courses" card)
8. **CTA Banner** (`.cta-band`) — gradient bg, "Ready to Begin Your [Subject] Journey?" headline, Book Trial Class + WhatsApp button (`.btn-cta-dk` dark navy)

**New course pages added this session:**
| File | Subject | Hero image | Pill emoji | Programme tag |
|---|---|---|---|---|
| `pages/ballet-course.html` | Ballet (RAD pathway) | `dancecourse.webp` | 🩰 | RAD Programme |
| `pages/hiphop-course.html` | Hip Hop (Showcase) | `hiphop.webp` | 💫 | Dance Programme |

**Stats-strip swap for non-music subjects:** when adapting `piano-course.html` for dance/art/non-ABRSM subjects, swap the `99% ABRSM & Trinity Pass Rate` stat → `5★ Google Rating`. Other 3 stats (20,000+ Students, 15+ Years, 5 Locations) stay — they're brand-wide. RAD/dance/art students don't take ABRSM, so leaving the music-exam pass-rate stat in would be misleading.

**Other Courses strip rule:** each course page's strip must EXCLUDE itself and INCLUDE all other courses. When adding a new course-detail page, also update the "Other Courses" strip on every existing course-detail page to include the new one.

### `pages/courses.html` — Dance grid expanded
The Dance section (`<!-- ── DANCE COURSES ── -->`) was previously a 1-card grid (Ballet only, linking to `trial`). It now has **2 cards** in the 3-column `.dance-grid`, both linking to dedicated course detail pages:

| Card | Image | Gradient (fallback) | href |
|---|---|---|---|
| Ballet (Ages 4+) | `../assets/dancecourse.webp` | `linear-gradient(135deg,#8B6B8B,#5C3D5C)` plum | `ballet-course` |
| Hip Hop (Ages 5+) | `../assets/hiphop.webp` | `linear-gradient(135deg,#FF6B9D,#7B2CBF)` pink/violet | `hiphop-course` |

Both `<img>` tags carry `onerror="this.style.display='none'"` so the gradient parent shows through gracefully if the asset is ever missing or 404s on Vercel due to case-mismatch.

### Asset additions
- `assets/hiphop.webp` — Hip Hop hero image. Used on `pages/courses.html` Hip Hop card AND `pages/hiphop-course.html` About-section image. **Filename must be lowercase** (Vercel case-sensitive). Recommended size: ~1200×900px, compressed to <150KB.

### Deprecated files (to delete)
Earlier in this session, two interim standalone pages were created with bespoke layouts before settling on the `piano-course.html` template:
- `pages/ballet.html` — superseded by `pages/ballet-course.html`
- `pages/hiphop.html` — superseded by `pages/hiphop-course.html`

These are now orphaned (nothing links to them). Delete from the repo:
```powershell
git rm pages/ballet.html pages/hiphop.html
```

Their interim URLs (`/pages/ballet`, `/pages/hiphop`) were never linked from production and are unlikely to be indexed, so no 301 redirect is needed. If they DO appear in GSC later, add to `vercel.json` redirects → `/pages/ballet-course` and `/pages/hiphop-course`.

### GSC issues reviewed but NOT fixed (informational only)
Two other GSC reports were reviewed this session and intentionally left untouched:

1. **"URL is not on Google" — `https://piano.liberalmusicschool.com/`** (Excluded by 'noindex' tag).
   - This is a SEPARATE subdomain, NOT in this repo. It's hosted somewhere else (possibly an old Wix/WordPress landing page or a different Vercel project — DNS lookup at GoDaddy will reveal the destination).
   - Last GSC crawl: 12 Aug 2024 (very stale).
   - **Decide before fixing:** is this subdomain still in use, or legacy? Cleanest options: (a) 301 redirect `piano.liberalmusicschool.com` → `liberalmusicschool.com/pages/piano-course` (consolidates SEO authority), or (b) delete the DNS record entirely. Removing the noindex on a stale subdomain is the worst option — it creates a duplicate that competes with `/pages/piano-course`.

2. **"Video isn't on a watch page"** — affects `https://liberalmusicschool.com/` and `/pages/about`.
   - **Not an error.** Google correctly identified the YouTube embeds as supplementary content (not the page's main subject). Both pages are indexed normally as web results — just not as standalone video results in the Search → Video tab.
   - For a music-school marketing site, this is correct behaviour. Customers Google "piano lessons Tampines", not "Liberal music school video". No action needed; this report can be safely ignored.

### Verify-before-push markers used in this session
| File | Marker |
|---|---|
| `index.html` (JSON-LD fix) | `Fix May 4 2026: @type set to multi-type` |
| `pages/courses.html` (Hip Hop card add) | `Hip Hop dance card added May 4 2026` |
| `pages/courses.html` (link rewire) | `linked to course page May 4 2026` |
| `pages/ballet-course.html` | `ballet-course page added May 4 2026` |
| `pages/hiphop-course.html` | `hiphop-course page added May 4 2026` |

---

## 📝 PAGE-SPECIFIC NOTES (May 14, 2026 session — mobile drawer, families bump, bilingual legal/blog pages, nav fixes)

Large multi-part session. Five distinct workstreams — treat all of the below as current state.

### A. Instructor "families" count bumped 500 → 20,000+
The CTA paragraph (`<p class="sr d2">`) in the bottom "Start Today" section of every instructor page read *"Join over **500** families..."*. `500` was bumped to `20,000+` to match the brand-wide figure (footer paragraph, homepage hero, course pages all say 20,000).
- Applied to all 13 instructor pages: `cecily, calvin, kate, jescelyn, tina, verginia, cheng, aliona, teresa, jiang, mindy, leonard, loy`
- Only the `Join over 500 families` string was touched — `font-weight:500` CSS and the Quicksand `500` font-import weight were left alone.
- Note: the 6 English instructor pages were later observed already cleaned to `Join 20,000+ families` (without the redundant "over"). Either phrasing is acceptable; not worth a re-sweep.

### B. Mobile nav drawer shrunk site-wide (the "see all buttons" fix)
The `.nav-drawer` mobile menu had oversized links (`font-size:25.5px`, some pages `23px`) — on phones the menu items overflowed past the screen so you couldn't see all of them. Shrunk to a compact size across **every page**:
- `.nav-drawer a` — `font-size` → `16.5px`, `padding` → `9px 14px`
- `.nav-drawer` container — `gap` → `2px`, `padding` → `12px 28px 20px`
- `.nav-drawer .btn-cta` → `margin-top:8px;font-size:15px;padding:11px 22px`
- Applied to: 2 homepages + 9 main pages + 13 instructor pages + 13 course/legal/career-adjacent pages + 2 blog article pages. **`career.html` was skipped** — it uses an older `.mob-nav` template that was already compact (`font-size:15px`), no overflow problem.
- Marker: `mobile drawer compact May 14 2026`

### C. New Chinese pages created (`pages-zh/`)
Chinese versions built for 5 pages, header/footer matched to existing `pages-zh/` pages (used `courses.html` zh as the reference). Each adds the `Noto Sans SC` font import + `--zh` CSS variable, wires `var(--zh)` into the body/heading/nav/footer font stacks, and flips the language toggle to **EN** (linking back to the English page).
- `pages-zh/privacy.html` — marker `pages-zh/privacy`
- `pages-zh/terms.html` — marker `pages-zh/terms`
- `pages-zh/contact.html` — Chinese contact page (FormSubmit also updated, see E)
- `pages-zh/articles/from-first-note-to-full-confidence-a-6-month-journey.html`
- `pages-zh/articles/liberal-blog-the-magic-of-shared-melodies-a-piano-concert-at-tengah.html`
- **Article-page path rule reminder:** Chinese article pages live in `pages-zh/articles/` — internal links use `../../pages-zh/` and `../../index-zh` (two levels up). The two Chinese article pages also received the mobile-drawer shrink (C) since the article template still had the old 25.5px drawer.

### D. Bilingual linking + Nest Hub nav fix on legal + blog pages
On the English `pages/privacy.html`, `pages/terms.html`, and both English blog articles:
- **The `中文` button is now a LIVE LINK** (was a disabled grey `<span>`). Navbar pill, footer `中文版本` link, and a new mobile-drawer `中文 · Chinese Version` row all point to the matching `pages-zh/` page. **This is a deliberate exception to the site-wide "中文 disabled while bilingual site paused" rule** — these 4 pages now have working Chinese counterparts, so their toggles are live. The other English pages' `中文` buttons stay disabled until their Chinese versions exist.
- **Nest Hub display fix:** the nav-collapse breakpoint was `@media(max-width:900px)`, but Nest Hub renders at 1024px — so 901–1024px showed a broken/overflowing desktop nav (the "Book Trial Class" button was clipped). Raised the breakpoint to `@media(max-width:1024px)` so the hamburger kicks in at Nest Hub width and below. Applied to privacy, terms, and both English articles. Marker: `nav collapse raised to 1024px for Nest Hub May 14 2026`.
- **Still outstanding:** the other ~20 English pages still have the `900px` breakpoint and the same Nest Hub overflow. Sweep them in a future batch if needed.

### E. Contact form receive-email changed
`contact.html` (both EN and ZH) FormSubmit `action` changed from `https://formsubmit.co/colouryartsg@gmail.com` → `https://formsubmit.co/liberal_music@yahoo.com.sg`.
- **FormSubmit needs a one-time activation** for the new address — the first form submission after deploy sends a confirmation email to `liberal_music@yahoo.com.sg`; someone must click the activation link or submissions won't arrive.
- Marker: `formsubmit.co/liberal_music@yahoo.com.sg`

### Verify-before-push markers used in this session
| Change | Marker |
|---|---|
| Instructor families bump | `Join over 20,000+ families` (or `Join 20,000+ families`) |
| Mobile drawer shrink (all pages) | `mobile drawer compact May 14 2026` |
| Chinese privacy / terms | `pages-zh/privacy` / `pages-zh/terms` |
| Nest Hub nav breakpoint | `nav collapse raised to 1024px for Nest Hub May 14 2026` |
| Contact form email swap | `formsubmit.co/liberal_music@yahoo.com.sg` |

> **Heads-up — same-filename collision risk:** the Chinese `privacy.html`, `terms.html`, `contact.html`, and the 2 article files share filenames with their English counterparts. When copying outputs into the repo, the English ones go in `pages/` (+ `pages/articles/`) and the Chinese ones go in `pages-zh/` (+ `pages-zh/articles/`). The Chinese files are identifiable by `lang="zh-CN"` and a `pages-zh/...` canonical tag.

---

## 📝 PAGE-SPECIFIC NOTES (May 17, 2026 session — Location pages, dropdown nav, Nest Hub fix, AEO sweep)

This was a multi-part session that built out the **`locations/` folder** from scratch, added a **Contact ▾ dropdown** to the nav, fixed the **Nest Hub nav-collapse breakpoint**, and applied AEO upgrades to **8 course pages**. The work was applied to `index.html` + 4 location pages; **propagation to the other ~30 pages is still pending**.

### A. Built 4 location pages from scratch (`locations/*.html`)
- `tengah.html` — Flagship HQ (NEW), Plantation Plaza landmark, near McDonald's Tengah, future Tengah Plantation MRT (JRL 2028)
- `bukit-batok.html` — Le Quest mall, FairPrice Finest + McDonald's landmark, near Bukit Batok MRT (NS2)
- `jurong-west.html` — *"established cornerstone"*, Blk 492 landmark, near Lakeside MRT (EW26)
- `tampines.html` — Blk 139 landmark, near Tampines West MRT (DT31), **closed Wednesdays**

All 4 follow the canonical page-section order from the LOCATION PAGES section above. See verify-markers table.

### B. Tengah positioning upgrade (17 edits across `locations/tengah.html`)
Originally written as a regular branch page; promoted to **Flagship HQ** mid-session per user clarification.
- Title: `Top Music School in Tengah | Flagship HQ | Liberal Music School`
- Schema `name`: `"... (Tengah Flagship HQ)"`
- Hero pill: `📍 Flagship HQ · Liberal Tengah` (one-off emoji-in-pill exception — Art Bible §6 normally bans this)
- Sub-headline prefix: `"The flagship headquarters of Liberal Music & Arts School."`
- Quick Facts pill: `"Flagship Headquarters"`
- Location Hub H2: `"Visit Our Flagship Headquarters in Tengah"`
- FAQ Q1: mentions `"opened its brand new flagship headquarters"`
- FAQ Q2/Q3 (schema + visible): `"Tengah HQ"` / `"Tengah headquarters"`
- **6 leftover `"Branch/branch"` references on Tengah** still need cleanup: breadcrumb, iframe title, FAQ section H2, FAQ Q2 question name, CTA banner. Identified, not yet changed without explicit ask.

### C. Jurong West de-HQ correction (17 edits)
Initially built JW with "Flagship HQ" positioning by mistake. Corrected mid-session per user: **Tengah is the real HQ**. JW reverted to:
- Hero pill: `Liberal Jurong West Branch`
- Sub-headline: `"the established cornerstone of Liberal Music & Arts School in the West"`
- All HQ / flagship / headquarters references removed

### D. Bukit Batok address correction
Was `#01-K1` (stale, pre-Google-Business-Profile value); corrected to `#01-83` per GBP. Applied to:
- `locations/bukit-batok.html` (multiple spots)
- Footer card on all 4 location pages
- `index.html` footer (already correct)
- Site-wide sweep for any other `#01-K1` reference is **pending**

### E. Real per-branch Google Business Profile hours
All 4 pages had generic "Daily 1pm-9pm" replaced with real per-branch hours (see LOCATION PAGES section table above). Hours are split per dayOfWeek in JSON-LD where Sat differs from Sun.

### F. Contact ▾ nav dropdown — created
New dropdown nav component (`~116 lines of CSS + HTML markup`) added to:
- `index.html` (desktop + mobile drawer)
- All 4 `locations/*.html`

Dropdown structure:
```
Contact ▾
  Jurong West       → /locations/jurong-west
  Bukit Batok (Le Quest) → /locations/bukit-batok
  Tampines          → /locations/tampines
  Tengah (HQ) [NEW] → /locations/tengah
```

Mobile drawer renders dropdown items as flat list (no toggle, always expanded). Desktop uses hover-open with downward arrow rotation.

### G. Nest Hub nav-collapse fix — 900px → 1024px
The May 14 2026 session raised the breakpoint to 1024px on `pages/privacy.html`, `pages/terms.html`, and the 2 English articles. This session extended that fix to all 4 `locations/*.html` files. **Still pending** on `index.html` and ~24 other pages.

Specifically, in CSS, 7 rules per file were updated:
- Main nav-collapse: `@media(max-width:900px)` → `@media(max-width:1024px)` (hides `.nav-links`, `.nav-lang`, `.nav-end .btn-cta`; shows `.nav-ham`)
- `.mob-bar` trigger: `@media(max-width:900px){.mob-bar{display:block}}` → `1024px`
- Dropdown desktop CSS: `@media (min-width: 901px)` → `1025px`
- Dropdown mobile CSS: `@media (max-width: 900px)` → `1024px`
- 3 inline comments updated

> Footer `.foot-grid` breakpoint at 900px is intentionally **kept** — the 3-column footer fits fine at 1024px width, only nav was overflowing.

### H. WhatsApp FAB — replaced and reordered (5 branches HQ-first)
Old: class-based `.wa-fab` / `.wa-panel` with external CSS, 4 branches, Jurong West marked `(HQ)`.
New: inline-styled `#waWrap` component (no external CSS deps), 5 branches in this order:

| Row | Label | Number |
|---|---|---|
| 1 | 🏡 Tengah | 8922 2848 |
| 2 | 🌅 Tampines | 8892 1198 |
| 3 | 🌸 Jurong West | 9627 7588 |
| 4 | 🏬 Le Quest | 9627 7582 |
| 5 | ✦ Coloury Art | 8995 1163 |

- Tengah is row 1 (HQ-first)
- Jurong West **lost its `(HQ)` suffix** in this order (HQ now belongs to Tengah)
- Coloury Art added as row 5
- Toggle behavior: button onclick toggles `#waPanel` display between `none` and `block`. Removed the old outside-click-to-close JS — kept simple.

### I. Footer — Coloury Art card kept as 5th slot
Order in `locations/*.html` footers: Jurong West → Le Quest → Tampines → Tengah → Coloury Art.
- Coloury Art card uses `<a>` (clickable, external `colouryart.com` target) with `.foot-loc.soon` modifier for orange-tinted treatment
- Pin character is `✦` (star) — not the `.address.webp` icon used on regular cards
- Meta line: `Near Boon Lay MRT · ✦ Opening Soon`

> **Inconsistency noted (not yet fixed):** the WA FAB order (Tengah-first) differs from the footer order (JW-first) on location pages. The nav dropdown has yet another order. Three different UI surfaces, three different orderings — flagged for unification when user picks the canonical order.

### J. AEO upgrade across 8 course pages (`pages/[subject]-course.html`)
Applied JSON-LD `Course` + `FAQPage` schema, AEO Quick Facts blocks, and 3-question FAQ accordions to:
- `violin-course.html` — marker `ABRSM violin AEO upgrade May 17 2026`
- `guitar-course.html` — marker `Guitar AEO upgrade May 17 2026`
- `ukulele-course.html` — marker `Ukulele AEO upgrade May 17 2026`
- `vocal-course.html` — marker `Vocal AEO upgrade May 17 2026`
- `music-for-kids.html` — marker `Music for Kids AEO upgrade May 17 2026`
- `chinese-instruments.html` — marker `Chinese Instruments AEO upgrade May 17 2026`
- `music-theory.html` — marker `Music Theory AEO upgrade May 17 2026`
- `aural-training.html` — marker `Aural Training AEO upgrade May 17 2026`

> Pattern follows `piano-course.html` as the canonical template (already had AEO from earlier session).

### K. WhatsApp → Contact button swap (10 course pages)
On all 10 standalone course pages (the 8 above + `piano-course.html` + `drum-course.html`), the bottom-of-page CTA button changed from:
```html
<a class="btn-cta-dk">WhatsApp Us</a>
```
to:
```html
<a href="contact" class="btn btn-outline btn-lg">Contact Us</a>
```
This funnels prospects through the contact form rather than to WhatsApp, capturing emails. Marker: `class="btn btn-outline btn-lg">Contact Us`.

### L. Vercel `locations/` folder 404 troubleshooting
After first push attempt, `liberalmusicschool.com/locations/tengah` returned 404. Root cause: `locations/` folder didn't exist in local repo, so PowerShell `copy "src\file.html" "locations\file.html"` silently failed (target dir not created first). Fix: explicit `if (!Test-Path locations) { New-Item -ItemType Directory -Path locations }` before the copy loop. Once folder existed, files copied + commit + push resolved the 404.

### M. Verify-before-push markers used in this session

| Change | Marker |
|---|---|
| Tengah location page | `Tengah location page AEO marker May 17 2026` |
| Bukit Batok location page | `Bukit Batok location page AEO marker May 17 2026` |
| Jurong West location page | `Jurong West location page AEO marker May 17 2026` |
| Tampines location page | `Tampines location page AEO marker May 17 2026` |
| 8 course AEO upgrades | `[Subject] AEO upgrade May 17 2026` (per course) |
| Contact button swap (10 course pages) | `class="btn btn-outline btn-lg">Contact Us` |
| Nest Hub nav fix (location pages) | `@media(max-width:1024px){\n      .nav-links,.nav-lang` |

### N. Open / pending items at end of session

| # | Item | Priority |
|---|---|---|
| 1 | Apply Nest Hub breakpoint fix (900→1024) to `index.html` + ~24 other pages | High (visible bug on Nest Hub) |
| 2 | Sync Contact ▾ dropdown to all EN `pages/*.html`, instructor profiles, articles. **ZH side done as of May 18 2026** — all ZH pages have canonical dropdown markup + Section 4.5 CSS, and after the May 18 dropdown-URL bulk fix all `/locations/<slug>` references in ZH files now route to `/locations-zh/<slug>` correctly. | High |
| 3 | Sync WA FAB to 5-branch HQ-first order on `index.html` + all `pages/*.html` | High |
| 4 | Clean up 6 leftover "Branch/branch" refs on `tengah.html` (breadcrumb, iframe title, FAQ H2, FAQ Q2 question name, CTA banner) | Medium |
| 5 | Site-wide footer hours per branch (currently generic "Daily 1pm-9pm" on all card meta lines) | Medium |
| 6 | Per-location Google rating accuracy (Bukit Batok 4.8★/30, JW 4.5★/32 — currently brand-wide 4.7★) | Medium |
| 7 | Build `locations-zh/` Chinese versions of 4 branch pages. **DONE for the 4 main branches (jurong-west, bukit-batok, tampines, tengah)** May 18 2026. Coloury Art ZH page remains pending until the EN side is ready (it's currently `Opening Soon`). | Low (Coloury Art remaining) |
| 8 | Sweep for any remaining `#01-K1` references (Le Quest was corrected to `#01-83`) | Low |
| 9 | Consider unifying the 3 different ordering systems (footer / FAB / dropdown) | Low (cosmetic) |
| 10 | Activate EN-side 中文 toggle on **4 EN location pages** (`pages/locations/tengah.html`, `bukit-batok`, `jurong-west`, `tampines`) — same 4-spot pattern as HEADER-FOOTER-GUIDE §14.17. **DONE for 13 EN instructor pages + 12 EN course-detail pages (May 19 2026 sweep).** The 4 EN location pages still have disabled-grey 中文 buttons even though their ZH counterparts exist — same fix, just swap `pages/` → `locations/` and `pages-zh/` → `locations-zh/` in the 4-spot Python script. | Medium |
| 11 | Build out the rest of `pages-zh/` (about, courses, instructors, blog, review, trial, **remaining 10 course pages**, all course-zh articles) — current count: 13 instructors + 4 locations + 3 legal/contact + 2 articles + **2 course pages (ballet-course, hiphop-course)** = **24 ZH pages live**; ~13 main ZH pages still to build. Each new ZH page MUST be paired with §14.17 EN-side toggle activation in the same commit. | Low (Chinese site rollout phased) |
| 12 | **10 EN→ZH course toggles currently 404** (piano-course, violin-course, guitar-course, drum-course, vocal-course, ukulele-course, music-for-kids, chinese-instruments, music-theory, aural-training). Per May 19 2026 decision, the EN course pages' 中文 toggles were pre-activated to the future ZH slugs to preserve bidirectional-pairing convention and snap into working order as ZH pages ship. **Resolution path:** build the 10 remaining ZH course pages from the ballet-course/hiphop-course ZH templates. | Low (transient — resolves with #11) |
| 13 | **Translation-string canon decision** (May 19 2026): the 2 new ZH course pages (ballet-course, hiphop-course) use the user-supplied translations `预约试听课` (Book Trial Class) and `即刻开始` (Start Today), while the 17 ZH pages built May 18 (13 instructors + 4 locations) use `预约试课` and `即刻启程`. Decide: A) accept inconsistency, B) bulk-replace ballet/hiphop ZH back to old canon, or C) bulk-replace the 17 May-18 ZH pages forward to new canon. PowerShell one-liner ready for option C if chosen. | Low (cosmetic — both translations are valid SG-Chinese) |
| 14 | **Update sitemap.xml** to reflect the 2 new ZH course pages. Currently the sitemap has `pages/ballet-course` and `pages/hiphop-course` listed as EN-only (no zh-CN hreflang alternate). Should be promoted to 4-entry bilingual pairs matching the 13 instructor pair pattern: add `xhtml:link rel="alternate" hreflang="en/zh-CN"` to both existing EN entries + add new `<url>` entries for `pages-zh/ballet-course` and `pages-zh/hiphop-course`. | Medium (active SEO impact — Google Search Console will start seeing zh-CN alternates) |

---

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
| `pages/contact.html` | FormSubmit wired to liberal_music@yahoo.com.sg (changed May 14 2026) |
| `pages/trial.html` | Re-upload after each edit |
| `pages/privacy.html` | Privacy Policy (PDPA) |
| `pages/terms.html` | Terms of Use |
| `pages/piano-course.html` | Course detail page — **CANONICAL TEMPLATE** for all `[subject]-course` pages |
| `pages/ballet-course.html` | Course detail page (RAD pathway) — added May 4 2026 |
| `pages/hiphop-course.html` | Course detail page (showcase performance) — added May 4 2026 |
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
| `pages/articles/liberal-blog-the-magic-of-shared-melodies-a-piano-concert-at-tengah.html` | Article page — re-upload after each edit |
| `pages/articles/from-first-note-to-full-confidence-a-6-month-journey.html` | Article page — re-upload after each edit |
| `pages-zh/privacy.html` | Chinese Privacy Policy — created May 14 2026 |
| `pages-zh/terms.html` | Chinese Terms of Use — created May 14 2026 |
| `pages-zh/contact.html` | Chinese contact page — created May 14 2026 |
| `pages-zh/articles/from-first-note-to-full-confidence-a-6-month-journey.html` | Chinese article page — created May 14 2026 |
| `pages-zh/articles/liberal-blog-the-magic-of-shared-melodies-a-piano-concert-at-tengah.html` | Chinese article page — created May 14 2026 |
| `pages-zh/cecily.html` | Chinese instructor profile (Principal · Erhu) — canonical ZH instructor template — created May 18 2026 |
| `pages-zh/calvin.html` | Chinese instructor profile (Vice Principal · Drums/Guitar/Uke) — created May 18 2026 |
| `pages-zh/kate.html` | Chinese instructor profile (Piano · ABRSM) — created May 18 2026 |
| `pages-zh/jescelyn.html` | Chinese instructor profile (Piano · ABRSM) — created May 18 2026 |
| `pages-zh/tina.html` | Chinese instructor profile (Piano · Vocal) — created May 18 2026 |
| `pages-zh/verginia.html` | Chinese instructor profile (Piano · Vocal) — created May 18 2026 |
| `pages-zh/cheng.html` | Chinese instructor profile (Violin · Piano) — created May 18 2026 |
| `pages-zh/aliona.html` | Chinese instructor profile (Violin · Strings) — created May 18 2026 |
| `pages-zh/teresa.html` | Chinese instructor profile (Violin) — created May 18 2026 |
| `pages-zh/jiang.html` | Chinese instructor profile (Erhu · Chinese Instruments) — created May 18 2026 |
| `pages-zh/mindy.html` | Chinese instructor profile (Vocal · Music for Kids) — created May 18 2026 |
| `pages-zh/leonard.html` | Chinese instructor profile (Drums · Guitar · Uke · Piano) — created May 18 2026 |
| `pages-zh/loy.html` | Chinese instructor profile (Guitar · Drums · Uke) — created May 18 2026 |
| `locations/tengah.html` | **Flagship HQ landing page — CANONICAL TEMPLATE for `locations/*.html`** — created May 17 2026 |
| `locations/bukit-batok.html` | Branch landing page (Le Quest) — created May 17 2026 |
| `locations/jurong-west.html` | Branch landing page (Jurong West) — created May 17 2026 |
| `locations/tampines.html` | Branch landing page (Tampines, Wed closed) — created May 17 2026 |
| `locations-zh/tengah.html` | **Chinese Flagship HQ landing page — CANONICAL TEMPLATE for `locations-zh/*.html`** — created May 18 2026 |
| `locations-zh/bukit-batok.html` | Chinese branch landing page (Le Quest · 武吉巴督) — created May 18 2026 |
| `locations-zh/jurong-west.html` | Chinese branch landing page (裕廊西) — created May 18 2026 |
| `locations-zh/tampines.html` | Chinese branch landing page (淡滨尼, Wed closed) — created May 18 2026 |
| `pages-zh/ballet-course.html` | **Chinese Ballet Course page (RAD pathway) — CANONICAL TEMPLATE for `pages-zh/<course>.html`** — created May 19 2026 |
| `pages-zh/hiphop-course.html` | Chinese Hip Hop Course page — created May 19 2026 |

---

## 📝 PAGE-SPECIFIC NOTES (May 18, 2026 session — site-wide dropdown propagation + `.kw` underline isolation fix + docs r7)

This session propagated the May 17 dropdown nav to **38 more pages** across the site, discovered and fixed a long-standing CSS stacking-context bug in the orange keyword underline animation, and brought `HEADER-FOOTER-GUIDE.md` to **r7**. By end of session, 41 of 42 site pages have both the canonical Contact ▾ dropdown and the canonical `.kw` underline CSS. Only `index-zh.html` remains.

### A. The `.kw` underline `isolation:isolate` fix (CRITICAL CSS bug)

**Symptom:** on 8 of 9 `pages/*.html` files, the orange keyword in the hero H1 (e.g., "Music & Arts for Every **Child**") had **no visible teal underline** — or briefly flashed and disappeared. The animation CSS was technically present and correct; the underline was simply invisible.

**Root cause:** `.kw::after { z-index: -1 }` escaped its `.kw` parent (which had `position:relative; display:inline-block` but no stacking context) and got placed BEHIND the `.page-hero`'s opaque `linear-gradient(...)` background. The "flash" the user saw was the animation running briefly before the page-hero's paint, then being covered.

Only `about.html` worked because it had `.hero-inner { position:relative; z-index:1 }` — an explicit `z-index` that created a stacking context and trapped the `::after` inside it.

**Fix:** add `isolation: isolate` to `.kw`. This is the modern way to create a stacking context without layout side effects. The `::after` now stays sealed inside `.kw` regardless of ancestor styling.

**Canonical CSS block — paste into every page** (see HEADER-FOOTER-GUIDE.md §4.7 for full explanation):
```css
.kw{position:relative;display:inline-block;color:var(--or);isolation:isolate}
.kw::after{content:'';position:absolute;bottom:4px;left:0;width:100%;height:9px;background:#8ddbd1;border-radius:5px;z-index:-1;transform:scaleX(0);transform-origin:left;animation:kw 0.6s var(--sp) 0.95s forwards}
@keyframes kw{to{transform:scaleX(1)}}
```

Color (`#8ddbd1` teal) and timing (`0.95s` delay) are now uniform across the whole site. Previously `about.html` used `<em>` + `var(--lem)` yellow with `0.8s` delay; that page was migrated to `<span class="kw">` + teal during this session.

### B. Contact ▾ dropdown propagation (38 pages)

The May 17 dropdown nav was only on `index.html` + 4 `locations/*.html`. This session added it to:

| Page family | Files | Breakpoint |
|---|---|---|
| `pages/` main pages | 9 (about, blog, contact, courses, instructors, privacy, review, terms, trial) | 1024/1025px |
| `pages/<instructor>.html` | 13 (cecily, calvin, kate, jescelyn, tina, verginia, cheng, aliona, teresa, jiang, mindy, leonard, loy) | 900/901px |
| `pages/<course>.html` | 12 (piano-, violin-, vocal-, guitar-, drum-, ukulele-course, chinese-instruments, music-for-kids, music-theory, aural-training, ballet-, hiphop-course) | 900/901px |
| `pages/articles/*.html` | 2 blog articles | 1024/1025px |
| **Total** | **36** | |

All use canonical `<ul class="dropdown-menu"><li>` markup matching `index.html`. Breakpoint pair depends on each page's existing nav-collapse — see HEADER-FOOTER-GUIDE.md §4.5 table for the full mapping. The 4 `locations/*.html` pages turned out to ALREADY be on canonical markup (the HEADER-FOOTER-GUIDE legacy-variant warning was outdated and has been cleared).

### C. Blog article pages — scoped replacement to protect footer

`pages/articles/*.html` are 2 levels deep (`../../` path prefix) AND have a Contact link in both the nav AND the footer. The patch script used scoped regex matching against the contents of `<ul class="nav-links">...</ul>` and `<nav class="nav-drawer">...</nav>` only — the footer's `<li><a href="../../pages/contact">Contact</a></li>` was deliberately left untouched.

### D. HEADER-FOOTER-GUIDE.md updates (r6 → r7)

| Section | Change |
|---|---|
| Top | Date bumped r6 → r7 |
| §4.5 | Replaced "1024px exception" guidance with a **two-breakpoint table** mapping page family → correct breakpoint pair (900/901 vs 1024/1025). |
| **§4.7 (NEW)** | Full canonical `.kw` underline animation spec — class usage, CSS block, the bug explanation, application matrix, multi-style risk warning, sanity-check grep commands. |
| §11.5 | Removed the now-obsolete "legacy variant" warning on `locations/*.html` — they're all canonical. |
| §12 | Added 2 new checklist entries — `.kw` canonical CSS present + use `<span class="kw">` not `<em>`. |

### E. Helper patch scripts that survived this session (in `/home/claude/`)

For future re-runs or new-page additions:

| Script | Purpose |
|---|---|
| `patch_pages.py` | Adds §4.6.1 mobile/landscape fix only |
| `patch_dropdown.py` | Adds Contact ▾ dropdown (1024/1025 variant) |
| `patch_kw_underline.py` | Adds `.kw` canonical CSS (with isolation:isolate) — handles `<em>`→`<span>` migration, strips prefixed legacy variants |
| `patch_inst_combined.py` | Combined dropdown + `.kw` for 900/901-breakpoint pages |
| `patch_articles.py` | Combined dropdown + `.kw` for `pages/articles/*` (2-level path, scoped regex to protect footer) |

All scripts are idempotent (check for sentinel strings — `NAVBAR DROPDOWN EXTENSION`, `Orange keyword underline (canonical`).

### F. Site progress matrix (end of May 18, 2026 session)

| Type | Count | Contact ▾ dropdown | `.kw` canonical CSS |
|---|---|---|---|
| Root (`index.html`, `index-zh.html`) | 2 | 1/2 (index-zh pending) | 1/2 (index-zh pending) |
| `pages/` main (about, blog, contact, courses, instructors, privacy, review, terms, trial) | 9 | ✅ all | ✅ all |
| `pages/<instructor>.html` | 13 | ✅ all | ✅ all (placeholder — no `.kw` usage yet) |
| `pages/<course>.html` | 12 | ✅ all | ✅ all (every page uses `<span class="kw">`) |
| `pages/articles/*.html` | 2 | ✅ all | ✅ all (placeholder) |
| `locations/*.html` | 4 | ✅ all | ✅ all |
| **Total** | **42** | **41/42** | **41/42** |

**Only `index-zh.html` remains.** Future work: localize the dropdown labels per HEADER-FOOTER-GUIDE.md §14.4.1 (联系我们 ▾ + 裕廊西 / 武吉巴督 (Le Quest) / 淡滨尼 / 登加 (旗舰总部)).
## 📝 PAGE-SPECIFIC NOTES (May 18, 2026 session — `pages-zh/` instructor completion + `locations-zh/` 4 main branches + ZH dropdown bulk-routing fix + docs r8)

This session completed the bulk of the Chinese site rollout: 13 instructor profile pages in `pages-zh/`, all 4 main Chinese branch pages in `locations-zh/`, and a site-wide dropdown URL fix to keep ZH users inside the ZH navigation. `HEADER-FOOTER-GUIDE.md` is brought to **r8**; `LIBERAL_ART_BIBLE.md` to **v1.5**.

### A. `pages-zh/` instructor pages — 13/13 done

All 13 instructor profiles cloned from the EN canonical (`pages/<name>.html`) into `pages-zh/<name>.html`, preserving English file slugs (URLs are GBP-registered + indexed — never localize slugs). Each page got:

- `<html lang="zh-CN">` swap + Noto Sans SC font import in `<head>`
- `--zh` CSS variable injected at the top of `:root` (`'Noto Sans SC', 'PingFang SC', 'Microsoft YaHei', '微软雅黑', sans-serif`)
- Font stacks updated: `body{font-family:'Quicksand',var(--zh),system-ui,sans-serif}` + `h1,h2,h3,h4{font-family:'Nunito',var(--zh),sans-serif}` — Latin glyphs render Quicksand/Nunito, CJK glyphs fall through to Noto Sans SC seamlessly
- Title / meta / canonical → Chinese, with `<link rel="alternate" hreflang>` linking EN ↔ ZH (both sides bi-directional)
- Hero, bio, education, achievements, philosophy, book card, "Other Instructors" strip → fully translated
- Internal hrefs swapped to ZH counterparts (`../pages-zh/<other>` for instructor links, `../pages-zh/trial`, `../index-zh.html`, etc.) — only `/locations/<branch>` slugs remained absolute (since slugs are GBP-registered)
- Contact dropdown localized to `联系我们 ▾ + 裕廊西 / 武吉巴督 (Le Quest) / 淡滨尼 / 登加 (旗舰总部) [New]` in BOTH desktop nav AND mobile drawer (Section 4.5 CSS copied verbatim — purely structural)
- Footer brand paragraph, location cards (5 branches with `（Chinese）分校` heading style), bottom bar, WA FAB popup, mobile sticky bar — fully translated using §14 conventions
- EN toggle reversed: `<a class="nav-lang" href="../pages/<name>" style="text-decoration:none;color:var(--ink);font-weight:700;">EN</a>` — per-page counterpart, NOT a homepage hop

#### Photo badge colors (preserved from EN — only the 中文 label text changes)
| Instructor(s) | Badge label | Badge bg | Badge text color |
|---|---|---|---|
| Cecily (Principal) | `校长` | `var(--or)` orange | white |
| Calvin (Vice Principal) | `副校长` | `var(--or)` orange | white |
| Kate (lead instructor) | `导师` | `var(--lav)` lavender | `#5550c8` |
| Jescelyn, Tina, Verginia | `[Name] 老师` | `#5550c8` solid | white |
| Cheng (multi-instrument) | `[Name] 老师` | `#c75b8a` pink | white |
| Others (default) | `[Name] 老师` | per page (varies) | per page |

> **Honorific convention:** Cecily / Calvin use formal title (`校长` / `副校长`). All other instructors use `[姓] 老师` everywhere as the address form ("Teacher [Name]") — never "Ms/Mr". Hero pill kicker, "Other Instructors" strip cards, book card heading all follow this.

#### Established ZH boilerplate strings (reused across all 13 instructor pages)

| English | 中文 |
|---|---|
| `Our Instructors` (breadcrumb) | `我们的导师` |
| `Back to Instructors` | `返回导师团队` |
| `Education` (section heading) | `教育背景` |
| `Achievements & Experience` OR `Career Highlights` | `成就与经验` / `成就与职业亮点` |
| `Meet our other instructors` | `认识我们的其他导师` |
| `Every Liberal instructor brings exceptional skill, passion, and dedication to our students.` | `博雅的每一位导师都为学生带来了卓越的技艺、热情与奉献精神。` |
| `Start Today` (pill kicker) | `即刻启程` (NOT 即刻开始) |
| `Book Trial Class` | `预约试课` (NOT 预约试听课 — house style, shorter) |
| `Join 20,000+ families who trust Liberal Music & Arts School. Book a free trial class with [Name] or any of our expert instructors today.` | `加入 20,000+ 个信赖博雅音乐艺术学校的家庭。立即预约 [Name] 老师或我们其他专业导师的免费试课。` |

### B. `locations-zh/` 4 main Chinese branch pages — done

All 4 EN branch pages (`locations/<slug>.html`) cloned to `locations-zh/<slug>.html`, with EN slug preserved per the GBP rule. Each page got the full structural translation (same 6-section page-section order as EN canonical) plus a few branch-specific decisions:

#### Both JSON-LD schemas translated (CRITICAL for Chinese SEO)

This is the key delta from previous ZH work — previous ZH pages kept JSON-LD untranslated. **For locations-zh, both schemas were partially translated:**

- **`@type: "MusicSchool"`** — bilingual `name` field: `"博雅音乐艺术学校 (登加旗舰总部) · Liberal Music & Arts School (Tengah Flagship HQ)"`. `@id` + `url` updated to `/locations-zh/<slug>`. `address` block stays English (postal addresses must be Google-Maps-parseable). `openingHoursSpecification` is purely structural data, unchanged.
- **`@type: "FAQPage"`** — Question `name` + Answer `text` fully translated to Chinese, so they're indexable by Chinese-language Google for rich-result snippets.

#### `hreflang` alternate links — bidirectional EN ↔ ZH

Added on both sides:

```html
<!-- On locations-zh/tengah.html -->
<link rel="canonical" href="https://liberalmusicschool.com/locations-zh/tengah"/>
<link rel="alternate" hreflang="en" href="https://liberalmusicschool.com/locations/tengah"/>
<link rel="alternate" hreflang="zh-CN" href="https://liberalmusicschool.com/locations-zh/tengah"/>
```

(EN side also needs the same hreflang alternate links — pending on the 4 EN location pages, noted in item #10 of the pending list.)

#### Path conventions inside `locations-zh/*.html`

| Item | Path | Reason |
|---|---|---|
| Asset (logo, icon, image) | `../assets/<file>` | locations-zh/ one level deep, same as locations/ |
| ZH instructor / course page | `../pages-zh/<name>` | go up one, into pages-zh |
| Index | `../index-zh.html` | go up one |
| Dropdown items (other ZH branches) | `/locations-zh/<branch>` | absolute paths (work from any URL depth) |
| **EN toggle button** | `../locations/<slug>` | per-page counterpart, NOT homepage |
| Footer English link | `../locations/<slug>` | matches EN toggle target |
| Privacy/Terms in footer | `../pages-zh/privacy`, `../pages-zh/terms` | one up, into pages-zh |

#### Tengah CTA exception — `登加总校` is CORRECT, not a typo

The other 3 branch pages had a leftover template-copy bug: their bottom CTA banner said *"Book a trial class at our Tengah branch"* on every branch (an obvious copy-paste error from when Tengah was the original template). In jurong-west / bukit-batok / tampines ZH pages, this was fixed to a generic `预约我们校区的试课` ("Book a trial at our branch"). **On the Tengah page itself, `登加总校` ("Tengah HQ") is the correct text** — we are literally on the Tengah branch — and the CTA reads `预约我们登加总校的试课——无需任何绑定承诺。`

#### Tampines Wednesday-closed handling

Visible Studio Hours block renders the Wed row in orange (`<strong style="color:var(--or)">周三：休息</strong>`) so visitors can't miss it. In JSON-LD `openingHoursSpecification`, Wednesday is omitted from the `dayOfWeek` array (schema.org idiom for "closed that day"). FAQ Q2's `acceptedAnswer.text` explicitly mentions `请注意，我们的淡滨尼工作室周三休息。` — schema + visible match exactly, as auditors check this.

#### Tengah Flagship HQ — `📍` emoji exception preserved

Tengah's pill kicker reads `📍 旗舰总校 · 博雅登加校区` — preserving the explicit Art Bible §6 emoji-in-pill exception from EN canonical. Hero h1 stays `登加音乐学校` (matches "Tengah Music School"). Sub-headline mentions `森林市镇` (HDB/URA's official ZH name for Tengah) and `BTO 预购组屋` (first-occurrence parenthesis convention — BTO is widely understood as a SG-specific real-estate acronym).

### C. Established SG Chinese place-name translations

These are now the canonical translations across all ZH location/instructor pages — never re-decide each time:

| English (slug stays English) | Chinese | Notes |
|---|---|---|
| Tengah | 登加 | New HDB town, official ZH name |
| Tampines | 淡滨尼 | Long-established SG-Chinese name |
| Jurong West | 裕廊西 | Official ZH name |
| Bukit Batok | 武吉巴督 | Official ZH name |
| Bukit Batok MRT (NS2) | 武吉巴督地铁站 | + English in parentheses on first mention |
| Bukit Gombak MRT (NS3) | 武吉甘柏地铁站 | "甘柏" is SG-Chinese for Gombak |
| Tampines West MRT (DT31) | 淡滨尼西地铁站 | |
| Lakeside MRT (EW26) | kept English | "邻近 Lakeside 地铁站" reads more natural than 湖畔 |
| Tengah Plantation MRT (future, JRL) | 登加种植园地铁站 | Plantation themed naming for the whole Tengah retail strip |
| Jurong Region Line | 裕廊区域线 | LTA official ZH name |
| Tampines Round Market | 淡滨尼圆巴刹 | "巴刹" is SG-Chinese for market/wet-market (from Malay pasar) — NOT 市场 |
| HDB | 建屋局 + HDB | First occurrence both Chinese + acronym |
| BTO | BTO 预购组屋 | First occurrence both acronym + Chinese gloss |
| Forest town | 森林市镇 | Official HDB/URA marketing term for Tengah |
| Plantation Plaza / Village | kept English | Project names, GBP-registered |
| McDonald's Tengah | 登加麦当劳 | Standard pattern |
| FairPrice Finest | kept English | Brand name |
| Le Quest (mall) | kept English | Brand name |
| Coloury Art By Liberal | kept English; sometimes `（裕廊坊）` after | Brand name + Chinese gloss for Jurong Point location |
| Boon Lay MRT | 文礼地铁站 | Official ZH name |

### D. Site-wide ZH dropdown URL bulk fix — `/locations/` → `/locations-zh/`

After all 17 ZH pages (13 instructors + 4 locations) were built, a user-reported bug surfaced: clicking any item in the Contact ▾ dropdown from a ZH page sent the user back to the **English** branch page (broken language continuity). Root cause: earlier ZH pages were created when `/locations-zh/` branch pages didn't yet exist, so their dropdowns pointed to `/locations/<en-slug>` as a fallback. Now that all 4 main ZH branches are live, those dropdown URLs need updating.

**Fix applied via PowerShell bulk update** (run on Windows side, end of session):

```powershell
cd C:\Users\immor\Downloads\liberalwebsitenew
$zhFiles = @()
if (Test-Path "index-zh.html") { $zhFiles += Get-Item "index-zh.html" }
$zhFiles += Get-ChildItem -Path "pages-zh","locations-zh" -Filter "*.html" -Recurse -ErrorAction SilentlyContinue
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
foreach ($f in $zhFiles) {
    $content = [System.IO.File]::ReadAllText($f.FullName, $utf8NoBom)
    $new = $content `
        -replace '"/locations/jurong-west"',  '"/locations-zh/jurong-west"' `
        -replace '"/locations/bukit-batok"',  '"/locations-zh/bukit-batok"' `
        -replace '"/locations/tampines"',     '"/locations-zh/tampines"' `
        -replace '"/locations/tengah"',       '"/locations-zh/tengah"'
    if ($content -ne $new) {
        [System.IO.File]::WriteAllText($f.FullName, $new, $utf8NoBom)
    }
}
```

**Pattern safety:** the replacement targets `"/locations/<slug>"` (absolute path, prefixed by a quote) but does NOT match `"../locations/<slug>"` (relative path) — the relative paths used for EN toggle and footer English links are protected. The `..` precedes the `"/locations/`, so the quote-prefixed pattern doesn't match.

**Encoding:** PowerShell's default `Set-Content -Encoding UTF8` adds a BOM, which breaks HTML rendering. The script uses `[System.IO.File]::WriteAllText` with `UTF8Encoding::new($false)` to write UTF-8 WITHOUT BOM, matching the original file format.

Git Bash alternative (uses GNU sed, no `-i ''` quirk):
```bash
cd /c/Users/immor/Downloads/liberalwebsitenew
ZH_FILES=$(find index-zh.html pages-zh locations-zh -name '*.html' 2>/dev/null)
for f in $ZH_FILES; do
  sed -i \
    -e 's|"/locations/jurong-west"|"/locations-zh/jurong-west"|g' \
    -e 's|"/locations/bukit-batok"|"/locations-zh/bukit-batok"|g' \
    -e 's|"/locations/tampines"|"/locations-zh/tampines"|g' \
    -e 's|"/locations/tengah"|"/locations-zh/tengah"|g' \
    "$f"
done
```

### E. Verify-before-push markers used in this session

| Change | Marker |
|---|---|
| pages-zh instructor pages (all 13) | `加入 20,000+ 个信赖博雅音乐艺术学校的家庭` (in book card subtitle — unique to ZH instructor pages) |
| locations-zh/jurong-west.html | `博雅裕廊西校区` (hero pill text — unique to this page) |
| locations-zh/bukit-batok.html | `紧邻 FairPrice Finest 超市和麦当劳` (Quick Facts — unique to this page) |
| locations-zh/tampines.html | `淡滨尼圆巴刹` (landmark — unique to this page) |
| locations-zh/tengah.html | `📍 旗舰总校 · 博雅登加校区` (hero pill — unique to this page) |
| Site-wide ZH dropdown URL fix | `href="/locations-zh/jurong-west"` (any one of the 4 ZH dropdown paths — only exists after the fix) |

### F. Site ZH progress matrix (end of May 18, 2026 session)

| Type | Count | ZH built? | Notes |
|---|---|---|---|
| Root `index-zh.html` | 1 | ✅ | Pre-existed; dropdown URLs updated by bulk fix |
| `pages-zh/` legal + contact | 3 | ✅ | privacy, terms, contact (built May 14) |
| `pages-zh/articles/*.html` | 2 | ✅ | built May 14 |
| `pages-zh/<instructor>.html` | 13 | ✅ | **all 13 built this session** |
| `pages-zh/` main (about, courses, instructors, blog, review, trial) | 6 | ❌ | pending |
| `pages-zh/<course>.html` (12 EN counterparts) | 12 | ❌ | pending |
| `locations-zh/<branch>.html` | 4 | ✅ | **4 main branches built this session**; Coloury Art pending |
| **ZH pages built / EN counterparts** | **22 / ~37** | **~59%** | |

---

## 📝 PAGE-SPECIFIC NOTES (May 19, 2026 session — ZH course pages canonical template + EN-side 中文 toggle batch activation + docs r9)

This session opened the **course-detail ZH** front (the largest remaining ZH-rollout area) by building 2 canonical templates, then resolved the long-standing pending #10 by sweeping EN-side 中文 toggle activation across 25 EN pages. Documentation bumped: HEADER-FOOTER-GUIDE.md to **r9**, HOW-TO-START.md to **r9**.

### A. New ZH course pages — ballet-course + hiphop-course

**`pages-zh/ballet-course.html`** is the canonical ZH course-detail template — when the remaining 10 ZH course pages (piano, violin, guitar, drum, vocal, ukulele, music-for-kids, chinese-instruments, music-theory, aural-training) are built, clone this file and swap content. Pattern follows the established conventions:

- 8 standard course-page sections: Hero / About / What You'll Learn / Who It's For / Stats Strip / Why Liberal / Other Courses (10 sibling cards) / CTA Banner
- No JSON-LD (ballet/hiphop predate May 17 AEO sweep — schema still kept verbatim from EN for any course page that has it)
- CTA banner keeps the **WhatsApp Us / WhatsApp 联系我们** button (ballet + hiphop were the 2 EN courses **NOT** included in the May 17 "WhatsApp Us → Contact Us" swap that hit the other 10 EN course pages)
- "Other Courses" strip uses sibling-relative refs (`piano-course`, etc.) which currently 404 from `pages-zh/` until those ZH course pages ship — accepted per established convention
- Path conventions identical to other pages-zh files: sibling ZH refs for nav, `/locations-zh/<slug>` for dropdown, `../pages/<slug>` for EN counterpart toggle

**`pages-zh/hiphop-course.html`** mirrors ballet-course exactly with hip-hop content; second canonical built to confirm the template generalises across distinctly different course types (formal RAD ballet vs casual energetic hip hop) without structural drift.

### B. Translation-string canon update — `预约试听课` + `即刻开始`

User explicitly provided translation reference documents for ballet-course and hiphop-course using **`预约试听课`** (Book Trial Class — literally "trial listening class", more SG-Chinese-natural) and **`即刻开始`** (Start Today — direct literal translation). These differ from the conventions established for the 13 instructor ZH pages (May 18 r1), which used `预约试课` and `即刻启程`.

**Decision left to user:** accept the inconsistency between course pages (新约定) and instructor pages (旧约定), OR run a PowerShell bulk replace across the 17 May-18 pages-zh files to unify on the new convention. As of end-of-session, both conventions coexist in the live site. See "Open / pending items" #13 below.

### C. EN-side 中文 toggle batch activation (52 spots — 4 spots × 13 instructors + 4 spots × 12 courses ≈ 100 spots actually)

Long-standing pending item #10 — the EN→ZH direction of the 中文 toggle was a **dead end** on nearly every EN page in the repo even after ZH counterparts shipped. Visitor lands on `pages/cecily.html`, sees grey disabled `中文` in the navbar, has no signal that `pages-zh/cecily.html` exists. May 19 sweep resolved this for 25 EN pages via a Python script that applies the same 4-spot pattern per file:

1. `<head>`: insert bidirectional `<link rel="alternate" hreflang="en">` + `hreflang="zh-CN"` lines after canonical
2. Desktop nav: `<span class="nav-lang" disabled>中文</span>` → `<a class="nav-lang" href="../pages-zh/<slug>">中文</a>`
3. Mobile drawer: insert a `<a href="../pages-zh/<slug>">中文 · Chinese Version</a>` row above the trial CTA (mirror of the `EN · English Version` row that ZH pages have)
4. Footer bottom bar: `<span style="cursor:not-allowed">中文版本</span>` → `<a href="../pages-zh/<slug>">中文版本</a>`

**Result by category:**

| Category | Files | EN toggles activated | ZH counterparts? | Click works? |
|---|---|---|---|---|
| Instructors | 13 | ✅ all 13 | ✅ all 13 built May 18 | ✅ 100% functional |
| Course-detail | 12 | ✅ all 12 | ⏳ only 2 built (ballet, hiphop) | ✅ for 2 of 12; ⚠️ **10 of 12 currently 404** until ZH course pages ship |
| Location pages | 4 | ❌ pending | ✅ all 4 built May 18 | ❌ EN side still disabled-grey (pending #10 remainder) |

**About the 10 temporary 404s:** the user accepted this convention to preserve bidirectional-pairing semantics — when each of the 10 remaining ZH course pages is built, no EN-side edit is needed; the existing toggle just "snaps into" working order. Same pattern as the "Other Courses" sibling refs on the ZH pages themselves, which 404 until their corresponding ZH pages ship.

### D. HEADER-FOOTER-GUIDE.md r9 — new §14.17 documenting the EN-side activation pattern

Documenting the 4-spot pattern was overdue — it had been informally executed twice (ballet+hiphop in one turn, then 12 courses, then 13 instructors) without a single source of truth. **§14.17 "Activating the 中文 Toggle on an EN Page"** is now the canonical reference (179 lines) covering:

- Exact find/replace snippets for all 4 spots
- Path conventions for the 4 EN page-location types (`pages/`, `pages/articles/`, `locations/`, root)
- Reusable Python bulk script (idempotent — safe to re-run if partially applied)
- PowerShell verification one-liner
- "When NOT to apply" exceptions (no ZH counterpart yet → leave disabled-grey; legacy redirects → leave alone)
- Historical context of the May 19 sweep

Also updated §14.5 (Language toggle) with a new **Bidirectional pairing rule** + **Current pairing status** snapshot table, and §14.14 (build checklist) with new **step 16** flagging the EN-side toggle sync as a required step when shipping any new ZH page.

### E. vercel.json explicitly NOT updated

After investigation, no vercel.json changes are needed for this session's work:
- New ZH pages (`pages-zh/ballet-course`, `pages-zh/hiphop-course`) work automatically via existing `cleanUrls: true`
- The 10 EN→ZH 404s should NOT be masked with redirects (would prevent the future ZH pages from being served when built; would also break existing redirects for slugs the user later actually builds)
- No new legacy URL patterns to redirect

### F. Verify-before-push markers used in this session

| Change | Marker |
|---|---|
| pages-zh/ballet-course.html | `舞动。律动。<br/>掌控舞台。` (about h2) OR `预约试听课` (7 occurrences) |
| pages-zh/hiphop-course.html | `舞动、律动、掌控舞台` (hero lead, slightly different punctuation than ballet) |
| EN instructor toggle activation | `class="nav-lang" href="../pages-zh/cecily"` (or any of the 13 slugs) |
| EN course toggle activation | `class="nav-lang" href="../pages-zh/ballet-course"` (or any of the 12 slugs) |
| Bulk script idempotency | `'中文 · Chinese Version' not in content` guard expression |

### G. Progress matrix (end of May 19, 2026 session)

| Type | EN | ZH built | EN→ZH toggle active | Notes |
|---|---|---|---|---|
| Root index | 1 | 1 ✅ | ✅ | pre-existing |
| `pages-zh/` legal + contact | 3 | 3 ✅ | ✅ | May 14 |
| `pages-zh/articles/` | 2 | 2 ✅ | ✅ | May 14 |
| `pages-zh/<instructor>` | 13 | 13 ✅ | ✅ (May 19 sweep) | full bidirectional |
| `pages-zh/<course>` | 12 | **2 ✅** (ballet, hiphop) | ✅ all 12 (10 with temp 404) | template established |
| `pages-zh/` main (about/courses/instructors/blog/review/trial) | 6 | ❌ 0 | n/a (no ZH) | |
| `locations-zh/<branch>` | 4 | 4 ✅ | ❌ **EN side still pending** | reduced pending item #10 |
| `locations-zh/coloury-art` | 1 | ❌ 0 | n/a (EN side still "Opening Soon") | |
| **ZH pages built / EN counterparts** | — | **24 / ~37** | **~65%** | up from 22/37 at start of session |
| **EN-side 中文 toggle activated** | — | — | **25 / 35 EN pages** | up from 0/35 at start of session |

---

