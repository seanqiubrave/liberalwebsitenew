# Liberal Music & Arts School — Art Bible v1.2
> Extracted from `index.html` (master reference) · April 2026 · Revised April 27, 2026 (footer copy + social links wiring + working hours unified + WhatsApp panel 5-row across articles)
> Use this document to standardize ALL pages across the website.

---

## 1. DESIGN IDENTITY

| Property | Value |
|---|---|
| **Brand Tone** | Playful + Professional · Warm · Trustworthy · Child-friendly |
| **Target Audience** | Parents of children aged 2.5–16 (write for parents, not kids) |
| **Core Keywords** | Confidence · Creativity · Growth · Enjoyment · ABRSM |
| **Aesthetic** | Soft rounded, warm orange energy, friendly but premium |

---

## 2. COLOUR SYSTEM

### CSS Variables (copy verbatim into every page `<style>`)

```css
:root {
  /* ── Brand Orange — ACTION ONLY (CTAs, highlights, accents) ── */
  --or:       #FF6600;
  --or-dk:    #E55900;          /* hover state */
  --or-lt:    #FFF4ED;          /* light tint backgrounds */
  --or-pale:  #FFF7F2;          /* very light page backgrounds */
  --or-glow:  rgba(255,102,0,.16);
  --or-sh:    0 12px 32px rgba(255,102,0,.22);   /* button shadow */
  --or-shh:   0 16px 40px rgba(255,102,0,.34);   /* button hover shadow */

  /* ── Surface Colours ── */
  --w:    #FFFFFF;
  --s1:   #FFFAF5;    /* warm off-white sections */
  --s2:   #F8FBFF;    /* cool off-white sections */

  /* ── Text Colours ── */
  --ink:   #1F2A44;   /* headings, primary text */
  --body:  #5A6B85;   /* body paragraphs */
  --muted: #8FA2BC;   /* captions, sub-labels */

  /* ── Accent Palette (decorative use only) ── */
  --teal:  #B8F2E6;
  --sky:   #D4EDFF;
  --blush: #FFD6E0;
  --lem:   #FFF3B0;
  --lav:   #E8E4FF;

  /* ── Footer ── */
  --dark-footer: #1F2A44;    /* footer/stats-strip background */

  /* ── System ── */
  --r:    16px;   /* default border-radius */
  --r-l:  20px;   /* large cards */
  --r-xl: 28px;   /* hero frame, modals */
  --sh:   0 8px 28px rgba(31,42,68,.09);    /* card shadow */
  --sh-l: 0 20px 56px rgba(31,42,68,.11);   /* elevated shadow */
  --sh-s: 0 2px 10px rgba(31,42,68,.06);    /* subtle shadow */
}
```

### Colour Usage Rules

| Use | Colour |
|---|---|
| CTA buttons (only!) | `--or` #FF6600 |
| Page sections (alternating warm) | `--s1` #FFFAF5 |
| Page sections (alternating cool) | `--s2` #F8FBFF |
| White card backgrounds | `--w` #FFFFFF |
| Headings | `--ink` #1F2A44 |
| Body text | `--body` #5A6B85 |
| Footer / stats strip | `#1F2A44` |
| Announcement bar | `#f56c22` |

**❌ NEVER use orange for decorative elements — only for action/CTA**
**❌ NEVER use dark section backgrounds except footer**

---

## 3. TYPOGRAPHY

### Font Families

```html
<!-- Required in <head> of EVERY page -->
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
<link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,400;0,600;0,700;0,800;0,900;1,800&family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet"/>
```

| Role | Font | Weight |
|---|---|---|
| **Display / Headings** | Nunito | 700, 800, 900 |
| **Body / Paragraphs** | Quicksand | 400, 500, 600, 700 |
| **Buttons / Pills** | Nunito | 700–800 |

### Font Size Scale

| Element | Size | Weight | Font |
|---|---|---|---|
| H1 (hero) | 75px | 900 | Nunito |
| H2 (section) | clamp(2rem, 3.8vw, 3rem) | 900 | Nunito |
| H3 (cards) | 20px | 900 | Nunito |
| Lead paragraph | 20px | 400 | Quicksand |
| Body paragraph | 18px | 400 | Quicksand |
| Nav links | 18px | 600 | Quicksand |
| Buttons (lg) | 18px | 800 | Nunito |
| Buttons (sm) | 15px | 800 | Nunito |
| Pills / tags | 21.5px uppercase | 800 | Nunito |
| Footer text | 15px | 400–500 | Quicksand |
| Course body text | 16px | 400 | Quicksand |
| Review quote | 16px italic | 400 | Quicksand |

### Hero H1 Keyword Underline
```css
.kw { color: var(--or); position: relative; display: inline-block; }
.kw::after {
  content: '';
  position: absolute; bottom: 4px; left: 0; width: 100%; height: 9px;
  background: #8ddbd1;  /* teal underline — NOT orange */
  border-radius: 5px; z-index: -1;
  transform: scaleX(0); transform-origin: left;
  animation: kw 0.6s var(--sp) 0.95s forwards;
}
@keyframes kw { to { transform: scaleX(1) } }
```

---

## 4. LAYOUT SYSTEM

```css
.W    { max-width: 1240px; margin: 0 auto; padding: 0 32px; }
section { padding: 100px 0; }
```

### Section Background Alternation
Sections alternate between warm and cool off-whites:

| Section | Background |
|---|---|
| Hero | `#FFFFFF` |
| Why Parents Choose (Trust) | `--s1` #FFFAF5 |
| Stats Strip | `#1F2A44` dark navy |
| Courses | `--s2` #F8FBFF |
| Teachers | `--s1` #FFFAF5 |
| Stats Strip 2 | `#1F2A44` dark navy |
| Parent Reviews | `--or-lt` #FFF4ED |
| FAQ | `--s2` #F8FBFF |
| CTA Banner | gradient `#FFF7F2 → #FFF7EE → #FFEEDD` |
| Footer | `#1F2A44` dark navy |

---

## 5. NAVBAR

```
Height: 72px · Fixed top · z-index: 1000
Background: rgba(255,255,255,.92) with backdrop blur
On scroll: rgba(255,255,255,.98) + shadow

Announcement bar: 36px tall, #f56c22, fixed above navbar (z-index: 1001)
→ nav top shifts to 36px when announcement bar is present
```

### Nav Link Order (STRICT — never change)
```
Home | About | Courses | Instructors | Review | Blog | Contact
```

All nav `href` values use **clean URLs** (no `.html` extension — Vercel `cleanUrls:true`):
- `href="/"` (Home from root) or `href="../index"` (Home from `pages/`) — actually use `/` for root reference
- `href="pages/about"` or `href="about"` from inside `pages/`
- Never `href="pages/about.html"` — all `.html` extensions were stripped in April 2026 migration

### Right Side
```
[中文]  →  DISABLED (grey span, opacity 0.35) — bilingual site paused
[Book Trial Class]  →  orange pill button, 18px
```

---

## 6. PILL TAG SYSTEM

All section labels use `.pill-tag` class with colour variants:

```css
.pill-tag {
  font-family: 'Nunito'; font-weight: 800; font-size: 21.5px;
  text-transform: uppercase; letter-spacing: 1.4px;
  padding: 7px 16px; border-radius: 999px; margin-bottom: 20px;
}
```

| Tag | Class | Background | Text |
|---|---|---|---|
| Our Programmes | `.pt-or` | `--or-lt` #FFF4ED | `--or` #FF6600 |
| Trusted Since 2009 | `.pt-tl` | `--teal` #B8F2E6 | `#1a7058` |
| Our Instructors | `.pt-lv` | `#98a3f8` | `#fff` white |
| Parent Reviews | `.pt-tl` | `--teal` #B8F2E6 | `#1a7058` |
| FAQ | `.pt-lv` | `#98a3f8` | `#fff` white |
| Start Today | `.pt-lv` | `#98a3f8` | `#fff` white |

**❌ No emoji icons in pill tags**

---

## 7. BUTTON SYSTEM

```css
.btn { font-family: 'Nunito'; font-weight: 800; border-radius: 999px; }

/* Primary CTA — orange */
.btn-cta {
  background: var(--or); color: #fff;
  box-shadow: var(--or-sh);
  font-size: 18px; padding: 13px 28px;
}
.btn-cta:hover { background: var(--or-dk); transform: translateY(-2px) scale(1.04); }

/* Large CTA */
.btn-lg { font-size: 18px; padding: 17px 40px; }

/* Small CTA */
.btn-sm { font-size: 15px; padding: 9px 20px; }

/* Outline */
.btn-outline { border: 2px solid #DDE6F2; color: var(--ink); }
.btn-outline:hover { border-color: var(--or); color: var(--or); }
```

### CTA Text — ONLY use:
- `Book Trial Class` (primary — use everywhere the trial is the next step)
- `✦ Book Trial Class` (with leading diamond, used on instructor profile book cards)
- `Try Now →` (homepage course cards)
- `Try a Class`
- `Start Learning`
- `View Courses` (secondary to Book Trial)

**❌ NEVER: Submit, Click Here, Learn More, Book Free Trial Class, Try Free**

> The word "Free" was removed from all CTAs and the announcement bar as of April 2026. Body copy that mentions the trial being free ("the first lesson is free", "book a free trial class with Ms X") is preserved — the removal applies to action-oriented buttons and bars only.

---

## 8. CARD SYSTEM

```css
.card-base {
  background: var(--w);
  border-radius: var(--r-l);   /* 20px */
  padding: 18–28px;
  box-shadow: var(--sh);
  border: 1px solid rgba(221,230,245,.5);
}
.card-base:hover {
  transform: translateY(-6px);
  box-shadow: 0 24px 52px var(--or-glow);
}
```

| Card Type | Special Style |
|---|---|
| Featured card | `border-top: 4px solid var(--or)` |
| Highlight card | `background: --or-lt` |
| Dark card | `background: --ink, color: white` |
| Course card | `overflow: hidden, aspect-ratio: 16/10 thumb` |
| Coming Soon | `background: #FFF3EA, border: 2px dashed rgba(255,102,0,.45)` |

---

## 9. SCROLL REVEAL ANIMATIONS

Apply to elements you want to animate on scroll:

```html
<div class="sr">...</div>   <!-- slide up -->
<div class="sl">...</div>   <!-- slide from left -->
<div class="sfr">...</div>  <!-- slide from right -->

<!-- Delay classes -->
<div class="sr d1">...</div>  <!-- 0.07s delay -->
<div class="sr d2">...</div>  <!-- 0.14s delay -->
<div class="sr d3">...</div>  <!-- 0.21s delay -->
<div class="sr d4">...</div>  <!-- 0.28s delay -->
<div class="sr d5">...</div>  <!-- 0.35s delay -->
```

JS adds `.reveal-ready` to body → elements animate from `opacity:0 + transform` to `opacity:1 + none`.

---

## 10. STATS STRIP

Dark navy section (`#1F2A44`) with orange diagonal slash at top:

```css
.stats-strip { background: #1F2A44; overflow: hidden; }
.stats-strip::after {
  content: ''; position: absolute; top: -48px; left: 0; right: 0; height: 48px;
  background: var(--or);
  clip-path: polygon(0% 100%, 10% 0, 100% 10%, 100% 10%);
}
/* Grid: 4 equal columns */
.stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); }
/* Numbers: white, large; accent '+' or '%' in orange */
.stat-num { color: #fff; font-size: clamp(2.4rem, 4vw, 3.2rem); }
.stat-num .acc { color: var(--or); }
```

**Used twice:** once after Hero, once after Teachers section.

---

## 11. FOOTER

```
Background: #1F2A44 (dark navy)
3-column grid: 1.8fr | 1fr | 1.7fr
Columns: Brand + Social | Navigation | Our Locations
```

- **Brand paragraph (canonical copy, April 27 2026):**
  *"Liberal Music & Arts School nurtures creativity, confidence, and a lifelong love of music and the arts — for ages 2.5 to adult. With expert teachers, holistic learning, and proven results, we are proud to be trusted by over 20,000 families in Singapore since 2009."*
- All footer text: **white** (`#fff` or `rgba(255,255,255,0.8)`)
- Nav links: `15px`, white, hover → left-shift + orange
- Location addresses use `assets/address.webp` icon (white filtered)
- Social icons: `assets/Instagram.webp`, `facebook.webp`, `youtube.webp`, `xiaohongshu.webp` (white filtered, no frame borders). **`href` values are wired live** for Instagram, Facebook, YouTube — see Section 15 / `HOW-TO-START.md` for URLs. Xiaohongshu still `href="#"` until URL supplied.
- Bottom bar: `© 2025 Liberal Music & Arts School · Privacy Policy → privacy · Terms of Use → terms · 中文版本 (disabled grey span)`. **Use clean URLs (no `.html`)** per Vercel cleanUrls convention.

---

## 12. ANNOUNCEMENT BAR

```css
.ann-bar {
  position: fixed; top: 0; z-index: 1001;
  background: #f56c22; height: 36px;
  font-family: 'Nunito'; font-weight: 700; font-size: 13px; color: #fff;
}
/* Navbar shifts to top: 36px when bar is present */
/* Main content padding-top: 108px (36 bar + 72 nav) */
```

---

## 13. WHATSAPP FLOATING BUTTON

```css
position: fixed; bottom: 28px; right: 28px; z-index: 9999;
width: 58px; height: 58px; border-radius: 50%;
background: #25D366; color: #fff;
box-shadow: 0 8px 28px rgba(37,211,102,.42);
```

Panel opens upward with **5 branch links** (canonical order):
🏡 Tengah · 🌅 Tampines · 🌸 Jurong West · 🏬 Le Quest · ✦ Coloury Art

Use `whatsapp.webp` icon (NOT 💬 emoji). See `HEADER-FOOTER-GUIDE.md` Section 8 for the exact HTML and `HOW-TO-START.md` for the WhatsApp number table.

---

## 14. ASSET PATHS

| Asset | Path (from root) | Path (from pages/) |
|---|---|---|
| Logo | `assets/logo.webp` | `../assets/logo.webp` |
| Footer logo | `assets/logofooter.webp` | `../assets/logofooter.webp` |
| Favicon | `assets/liberalfavicon.png` | `../assets/liberalfavicon.png` |
| Student icons | `assets/studenticon1–9.webp` | `../assets/studenticon1–9.webp` |
| Stats icons | `assets/students.webp`, `15years.webp`, `locations.webp`, `passrate.webp` | `../assets/` prefix |
| Trust icons | `assets/safe.webp`, `certified.webp`, `findus.webp`, `confidence.webp` | `../assets/` prefix |
| Course images | `assets/pianocourse.webp`, `violincourse.webp`, `guitarcourse.webp`, `drumcourse.webp`, `colouryart.webp`, `dancecourse.webp` | `../assets/` prefix |
| Instructor photos | `assets/cecily.webp`, `calvin.webp`, `kate.webp`, `jiang.webp`, `cheng.webp`, `leonard.webp`, `loy.webp` | `../assets/` prefix |
| Social icons | `assets/Instagram.webp`, `facebook.webp`, `youtube.webp`, `xiaohongshu.webp` | `../assets/` prefix |
| Address icon | `assets/address.webp` | `../assets/` prefix |

**❌ NEVER use inline base64 for images — always reference asset files**

**Favicon HTML (place in every page `<head>`):**
```html
<link rel="icon" type="image/png" href="assets/liberalfavicon.png"/>
<link rel="apple-touch-icon" href="assets/liberalfavicon.png"/>
```
Adjust path depth: `assets/` from root, `../assets/` from `pages/*`, `../../assets/` from `pages/articles/*`.

---

## 15. LOCATIONS & CONTACT

| Branch | Address | WhatsApp |
|---|---|---|
| Tengah | 127A Plantation Crescent, #01-381, S691127 | +65 8922 2848 |
| Tampines | Blk 139 Tampines Street 11, #01-60, S521139 | +65 8892 1198 |
| Jurong West | Blk 492 Jurong West Street 41, #01-10, S640492 | +65 9627 7588 |
| Le Quest Mall | 4 Bukit Batok Street 41, #01-83, S657991 | +65 9627 7582 |
| Coloury Art By Liberal | #03-07C Level 3, Jurong Point, S648886 · [colouryart.com](https://colouryart.com/) · *(Opening Soon)* | +65 8922 2848 *(shares Tengah's number)* |

WhatsApp link format: `https://wa.me/65XXXXXXXX`

**Branch hours (April 27 2026):** All 4 Liberal branches operate `Daily: 1pm–9pm` — replaced the older `Mon–Fri: 2pm–9pm  ·  Sat–Sun: 9am–6pm` split. Coloury Art card on contact.html shows `Visit colouryart.com` instead of hours.

**Address format:** Postal code closes the address line. Do **NOT** append `· Near X MRT` — this suffix was removed from contact.html on April 27 2026.

### Social media URLs (footer links — wired live April 27 2026)

| Platform | URL |
|---|---|
| Instagram | `https://www.instagram.com/liberalmusic_arts/` |
| Facebook | `https://www.facebook.com/liberalmusicandarts/` |
| YouTube | `https://youtube.com/@liberalmusicartsschoolsingapor?si=0EdJLdRw-WoXKxOR` |
| Xiaohongshu | *pending — `href="#"` site-wide until URL supplied* |

All open in new tabs with `target="_blank" rel="noopener noreferrer"`.

---

## 16. NAVIGATION — EXACT ORDER (never change)

```
Home | About | Courses | Instructors | Review | Blog | Contact
```

Right side: `[中文]` lang button (currently **disabled** — grey span while bilingual site paused) → `[Book Trial Class]` orange button

---

## 17. RESPONSIVE BREAKPOINTS

| Breakpoint | Behaviour |
|---|---|
| `≤ 1100px` | Courses grid: 2 cols; Teacher grid: 2 cols; Trust grid: 2 cols |
| `≤ 900px` | Hero stacks single col; Stats: 2×2; Nav links hidden → hamburger |
| `≤ 700px` | Footer stacks single col |
| `≤ 540px` | Trust: 2 cols; Stats: 2×2; Teachers: 1 col |

---

## 18. PAGE SKELETON TEMPLATE

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
  <title>Page Title | Liberal Music & Arts School</title>
  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
  <link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,400;0,600;0,700;0,800;0,900;1,800&family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet"/>
  <style>
    /* 1. :root CSS variables (Section 2) */
    /* 2. Reset + body (Quicksand, background: #1F2A44 for html) */
    /* 3. Layout (.W, section padding) */
    /* 4. Typography (.h2, .lead, .pill-tag variants) */
    /* 5. Button system */
    /* 6. Announcement bar */
    /* 7. Navbar */
    /* 8. Scroll reveal */
    /* 9. Footer */
    /* 10. WhatsApp */
    /* 11. Page-specific styles */
  </style>
</head>
<body>
  <!-- Announcement bar (Section 12) -->
  <!-- Navbar (Section 5) -->
  <!-- Page hero (padding-top: 108px) -->
  <!-- Page sections -->
  <!-- Footer (Section 11) -->
  <!-- WhatsApp FAB (Section 13) -->
  <script>
    /* Navbar scroll shadow */
    /* Hamburger toggle */
    /* Scroll reveal observer */
  </script>
</body>
</html>
```

---

## 19. QUICK CHECKLIST (every page)

- [ ] Google Fonts `Nunito + Quicksand` in `<head>`
- [ ] `:root` CSS variables match Section 2 exactly
- [ ] Announcement bar: `#f56c22`, links to Liberal
- [ ] Nav height `72px`, shifted `top: 36px` due to bar
- [ ] Nav order: `Home | About | Courses | Instructors | Review | Blog | Contact`
- [ ] `[中文]` + `[Book Trial Class]` on right of nav
- [ ] Section padding `100px 0`
- [ ] Max width `.W` = `1240px`
- [ ] Logo: `../assets/logo.webp` (never base64)
- [ ] Pill tags: no emoji icons, correct colour variants
- [ ] All CTAs use approved text only
- [ ] Footer: 3 cols, all text white, address + social icons from assets
- [ ] Footer background `#1F2A44`, no bottom gap
- [ ] WhatsApp FAB: `position:fixed, bottom:28px, right:28px`
- [ ] `html` background: `#1F2A44` (prevents white gap below footer)
- [ ] Favicon link present (`liberalfavicon.png`)
- [ ] Canonical, title, meta-description all page-specific
- [ ] No Cloudflare `email-decode.min.js` script injection

---

## 20. MOBILE OVERRIDES (@media max-width:540px)

Applied to `index.html` April 2026. Rollout to other pages pending. All rules scoped inside a single `@media(max-width:540px){}` block — desktop + tablet are 100% untouched.

### Principles
- **Preserve desktop design 100%** — all mobile rules live inside the media query
- **Hide decorative elements** that become noise on small screens
- **Shrink oversized typography** that was designed for desktop
- **Remove elements duplicated elsewhere** (e.g. floating stat cards when the stats strip says the same thing)

### Elements HIDDEN on mobile

| Selector | Why |
|---|---|
| `#trust` | Entire "Why is Liberal the Most Trusted..." section — too dense for small screens; messaging carried by stats + reviews |
| `.fc-a`, `.fc-b` | Floating stat cards (20,000+ Success Stories, ABRSM 99%) — info duplicated in stats strip below |
| `.fc-c` | Floating proof card |
| `.hero-notes` | Animated music-note emojis in hero |
| `.hero-ring` | Decorative concentric ring |
| `.vis-a`, `.vis-b` | Peach + teal decorative circles behind video |
| `.glance-sep` | `·` separators between glance items (items wrap to multiple lines) |
| `#heroIframe` | Autoplay iframe replaced by tap-to-play poster (see below) |
| `.tc-arrow` | Teacher carousel arrows (touch-swipe works fine without) |
| `.rev-arrow`, `.faq-arrow` | Review + FAQ carousel arrows |
| `.nav-links`, `.nav-lang`, `.nav-end .btn-cta` | Replaced by hamburger drawer |

### Elements RESIZED on mobile

| Selector | Desktop | Mobile |
|---|---|---|
| `.hero h1` | `font-size:75px` | `font-size:clamp(2.2rem, 10.5vw, 3rem); letter-spacing:-1px` |
| `.hero-kicker` pill | `font-size:16px; padding:9px 22px` | `font-size:13px; padding:7px 14px; white-space:normal; text-align:center` |
| `.glance-card` | inline-flex with `·` separators | `font-size:13px; flex-wrap:wrap; justify-content:center; gap:6px 10px` |
| `.hero-desc` | `font-size:20px` | `font-size:16px; line-height:1.6; padding-right:56px` (clears WhatsApp FAB) |
| `.ann-bar` | `height:36px` nowrap | `height:auto; min-height:36px; padding:6px 12px` |
| `.ann-bar a` | `font-size:13px; white-space:nowrap` | `font-size:12px; white-space:normal; text-align:center; line-height:1.25` |
| `.stat-cell` | `padding:52px 24px 48px` | `padding:32px 12px 28px` |
| `.stat-icon` | 64×64 | 48×48, `margin-bottom:12px` |
| `.stat-num` | `clamp(2.4rem, 4vw, 3.2rem)` | `font-size:2rem` |
| `.stat-label` | `font-size:25px` | `font-size:15px; line-height:1.25; margin-bottom:2px` |
| `.stat-sub` | `font-size:23px` | `font-size:13px; line-height:1.35` |
| `.faq-card-q` | `font-size:17px` | `font-size:16px; margin-bottom:8px` |
| `.faq-card-a` | `font-size:15px` | `font-size:14.5px; line-height:1.6` |

### Layout overrides on mobile

| Selector | Desktop | Mobile |
|---|---|---|
| `.hero` | `min-height:100vh; align-items:center; padding:110px 0 90px` | `min-height:0; align-items:flex-start; padding-bottom:40px` |
| `.hero-grid` | `gap:48px` | `gap:20px` |
| `.hero-vis` | `margin-top:30px` | `margin-top:0; width:100%; max-width:420px` |
| `.hero-frame` | peach gradient | `width:100%; min-width:0; background:#000` |
| `.faq-inner` | `grid-template-columns:repeat(4,1fr)` | `grid-template-columns:1fr` (stack to 1-col) |
| `.faq-card` | `height:280px` | `height:auto; min-height:0; padding:20px` |
| `.stats-grid` | `repeat(4,1fr)` | `1fr 1fr` |
| `.branch-grid` | `repeat(5,1fr)` | `1fr` |
| `.course-grid` | `repeat(3,1fr)` | `1fr` |
| `.tc` (teacher card) | `flex:0 0 calc((100% - 72px)/4)` | `flex:0 0 100%` |

### Hero video — tap-to-play poster pattern (mobile only)

Autoplay YouTube iframes are unreliable on mobile Chrome (Data Saver blocks them, Battery Saver blocks them, various ad-blockers block them). The mobile pattern replaces the iframe with a tap-to-play poster:

**Markup** (inside `.hero-frame`):
```html
<iframe id="heroIframe" src="..." ...></iframe>
<button type="button" class="hero-mobile-play" id="heroMobilePlay" aria-label="Play video">
  <img src="https://img.youtube.com/vi/[VIDEO_ID]/hqdefault.jpg" alt="Video preview" loading="lazy"/>
  <span class="hero-mobile-play-btn" aria-hidden="true">
    <svg viewBox="0 0 24 24" width="36" height="36" fill="#fff"><path d="M8 5v14l11-7z"/></svg>
  </span>
</button>
```

**CSS** (base rules placed next to `.hero-frame` in the CSS, BEFORE any media query — otherwise specificity breaks):
```css
.hero-mobile-play{
  display:none;
  position:absolute;inset:0;width:100%;height:100%;
  padding:0;border:none;cursor:pointer;
  background:#000;
  align-items:center;justify-content:center;
  overflow:hidden; z-index:3;
}
.hero-mobile-play img{
  position:absolute;inset:0;
  width:100%;height:100%;object-fit:cover;
  opacity:.92;
}
.hero-mobile-play-btn{
  width:72px;height:72px;border-radius:50%;
  background:rgba(255,102,0,.96);
  display:flex;align-items:center;justify-content:center;
  box-shadow:0 8px 24px rgba(0,0,0,.35), 0 0 0 6px rgba(255,255,255,.12);
}
@media(max-width:540px){
  #heroIframe{display:none}
  .hero-mobile-play{display:flex}
}
```

**JS** — click handler swaps poster for iframe on user gesture (this bypasses mobile autoplay restrictions):
```javascript
document.getElementById('heroMobilePlay')?.addEventListener('click', () => {
  const newIframe = document.createElement('iframe');
  newIframe.src = 'https://www.youtube.com/embed/[VIDEO_ID]?autoplay=1&mute=0&playsinline=1&rel=0&modestbranding=1';
  newIframe.setAttribute('allow', 'autoplay; encrypted-media; picture-in-picture');
  newIframe.setAttribute('allowfullscreen', '');
  newIframe.style.cssText = 'position:absolute;inset:0;width:100%;height:100%;border:none;display:block;';
  document.getElementById('heroMobilePlay').replaceWith(newIframe);
});
```

> ⚠️ CSS specificity gotcha: base `.hero-mobile-play{display:none}` MUST come BEFORE the `@media(max-width:540px){.hero-mobile-play{display:flex}}` override in source order. Same specificity means source order decides — base AFTER the media query would mean mobile never shows the poster.

---

## 21. SEO & VERCEL CLEAN URLS

### Clean URL convention (active since April 2026)
All internal `<a href>` values omit `.html`. Vercel's `cleanUrls: true` serves `/pages/about` from `pages/about.html` automatically.

- ✅ `href="pages/about"`, `href="pages/courses#piano"`, `href="../../pages/trial"`
- ❌ `href="pages/about.html"`, `href="../trial.html"`

### Required `<head>` tags per page
```html
<!-- SEO trio — every page -->
<title>[Page-specific] | Liberal Music & Arts School</title>
<meta name="description" content="[Under 160 chars]"/>
<link rel="canonical" href="https://liberalmusicschool.com/pages/[slug]"/>

<!-- Favicon -->
<link rel="icon" type="image/png" href="assets/liberalfavicon.png"/>
<link rel="apple-touch-icon" href="assets/liberalfavicon.png"/>
```

### `vercel.json` redirects (SEO-preserving 301s)
- `/about-us` → `/pages/about`
- `/music/:path*` → `/pages/courses`
- `/testimonial` → `/pages/review`
- `/pages/testimonial` → `/pages/review`
- `/日本人の方へ` (percent-encoded) → `/`

### Canonical domain
`https://liberalmusicschool.com` — always with `https`, no `www`, no trailing slash (except root).

### Never inject
- Cloudflare `email-decode.min.js` (site is on Vercel, not Cloudflare)
- `.html` inline in navigation or footer hrefs

---

*Last updated: April 27, 2026 (v1.2 — footer copy + social links wiring + working hours unified + WhatsApp 5-row across articles + cleanUrls for privacy/terms) · Source of truth: `index.html`*
