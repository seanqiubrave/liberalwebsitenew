# Liberal Music & Arts School — Art Bible v1.0
> Extracted from `index.html` (master reference) · April 2026
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
- `Book Free Trial Class`
- `Book Trial Class`
- `Try a Class`
- `Start Learning`

**❌ NEVER: Submit, Click Here, Learn More**

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

- All footer text: **white** (`#fff` or `rgba(255,255,255,0.8)`)
- Nav links: `15px`, white, hover → left-shift + orange
- Location addresses use `assets/address.webp` icon (white filtered)
- Social icons: `assets/Instagram.webp`, `facebook.webp`, `youtube.webp`, `xiaohongshu.webp` (white filtered, no frame borders)
- Bottom bar: `© 2025 Liberal Music & Arts School · Privacy Policy → privacy.html · Terms of Use → terms.html · 中文版本 (disabled grey span)`

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

Panel opens upward with 3 branch links (Tengah, Tampines, Jurong West/JP).

---

## 14. ASSET PATHS

| Asset | Path (from root) | Path (from pages/) |
|---|---|---|
| Logo | `assets/logo.webp` | `../assets/logo.webp` |
| Footer logo | `assets/logofooter.webp` | `../assets/logofooter.webp` |
| Student icons | `assets/studenticon1–9.webp` | `../assets/studenticon1–9.webp` |
| Stats icons | `assets/students.webp`, `15years.webp`, `locations.webp`, `passrate.webp` | `../assets/` prefix |
| Trust icons | `assets/safe.webp`, `certified.webp`, `findus.webp`, `confidence.webp` | `../assets/` prefix |
| Course images | `assets/pianocourse.webp`, `violincourse.webp`, `guitarcourse.webp`, `drumcourse.webp`, `colouryart.webp`, `dancecourse.webp` | `../assets/` prefix |
| Instructor photos | `assets/cecily.webp`, `calvin.webp`, `kate.webp`, `jiang.webp`, `cheng.webp`, `leonard.webp`, `loy.webp` | `../assets/` prefix |
| Social icons | `assets/Instagram.webp`, `facebook.webp`, `youtube.webp`, `xiaohongshu.webp` | `../assets/` prefix |
| Address icon | `assets/address.webp` | `../assets/` prefix |

**❌ NEVER use inline base64 for images — always reference asset files**

---

## 15. LOCATIONS & CONTACT

| Branch | Address | WhatsApp |
|---|---|---|
| Tengah | 127A Plantation Crescent, #01-381, S691127 | +65 8922 2848 |
| Tampines | Blk 139 Tampines Street 11, #01-60, S521139 | +65 8892 1198 |
| Jurong West | Blk 492 Jurong West Street 41, #01-10, S640492 | +65 9627 7582 |
| Le Quest Mall | 4 Bukit Batok Street 41, #01-83, S657991 | +65 9627 7582 |
| Coloury Art By Liberal | #03-07C Level 3, Jurong Point, S648886 · [colouryart.com](https://colouryart.com/) | +65 8922 2848 |

WhatsApp link format: `https://wa.me/65XXXXXXXX`

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

---

*Last updated: April 2026 · Source of truth: `index.html`*
