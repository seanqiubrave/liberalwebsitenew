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
| Coloury Art | +65 8995 1163 *(dedicated number from April 28 2026)* | `https://wa.me/6589951163` |

> **Changed April 2026:** Jurong West got its own dedicated number (`9627 7588`). Previously it was grouped with Le Quest / Jurong Point under `9627 7582`. Le Quest still uses `7582`. The FAB popup on every page now shows **5 separate rows**.
>
> **Changed April 28 2026:** Coloury Art (Jurong Point) now has its own dedicated number `8995 1163` (`wa.me/6589951163`). Previously it shared Tengah's `8922 2848`. Tengah's number is unchanged. The change was applied site-wide across all 25 pages in one batch — see "April 28 2026 session" notes below.

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
