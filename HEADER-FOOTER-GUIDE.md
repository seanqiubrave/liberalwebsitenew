# Liberal Music & Arts — Header & Footer Reference Guide
> Source of truth: `index.html` (master) · Last updated: May 19, 2026 (r9 — added §14.17 "Activating the 中文 toggle on an EN page" documenting the 4-spot pattern; §14.5 expanded with the bidirectional-pairing rule; §14.14 build checklist gets a new step #15 to keep EN-side toggles in sync when a new ZH page ships)  
> Apply this guide to **every** page. No deviations.

---

## ⚠️ PATH RULES (CRITICAL)

| File location | Logo src | Asset prefix | Link prefix |
|---|---|---|---|
| Root (`index.html`, `index-zh.html`) | `assets/logo.webp` | `assets/` | `pages/` (or `pages-zh/` on ZH side) |
| Subfolder (`pages/*.html`) | `../assets/logo.webp` | `../assets/` | *(relative, no prefix)* |
| Subfolder (`pages-zh/*.html`) | `../assets/logo.webp` | `../assets/` | *(relative; ZH-sibling links via `<slug>`, EN counterpart via `../pages/<slug>`)* |
| Subfolder (`locations/*.html`) | `../assets/logo.webp` | `../assets/` | *(relative, no prefix; `pages/` items: `../pages/<file>`)* |
| Subfolder (`locations-zh/*.html`) | `../assets/logo.webp` | `../assets/` | *(relative; ZH-sibling pages via `../pages-zh/<slug>`, EN counterpart via `../locations/<slug>`)* |
| Sub-subfolder (`pages/articles/*.html`, `pages-zh/articles/*.html`) | `../../assets/logo.webp` | `../../assets/` | `../<file>` |

> All examples below use `pages/` subfolder paths (`../assets/`).  
> For root pages, remove the `../` prefix throughout.  
> For `locations/*.html` and `locations-zh/*.html`, asset paths are identical to `pages/*.html` (also one level deep from root) — but page links work a bit differently: dropdown items link to absolute paths (`/locations/<branch>` on EN side, `/locations-zh/<branch>` on ZH side) and footer privacy/terms links use `../pages/privacy` (EN) or `../pages-zh/privacy` (ZH).

---

## 1. REQUIRED `<head>` IMPORTS

Paste this in the `<head>` of **every** page before `<style>`:

```html
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
<link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,400;0,600;0,700;0,800;0,900;1,800&family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet"/>
```

---

## 2. CSS VARIABLES (`:root` block)

Copy verbatim into every page `<style>`:

```css
:root {
  --or:      #FF6600;
  --or-dk:   #E55900;
  --or-lt:   #FFF4ED;
  --or-pale: #FFF7F2;
  --or-glow: rgba(255,102,0,.16);
  --or-sh:   0 12px 32px rgba(255,102,0,.22);
  --or-shh:  0 16px 40px rgba(255,102,0,.34);

  --w:    #FFFFFF;
  --s1:   #FFFAF5;
  --s2:   #F8FBFF;

  --ink:   #1F2A44;
  --body:  #5A6B85;
  --muted: #8FA2BC;

  --teal:  #B8F2E6;
  --sky:   #D4EDFF;
  --blush: #FFD6E0;
  --lem:   #FFF3B0;
  --lav:   #E8E4FF;

  --r:    16px;
  --r-l:  20px;
  --r-xl: 28px;
  --sh:   0 8px 28px rgba(31,42,68,.09);
  --sh-l: 0 20px 56px rgba(31,42,68,.11);
  --sh-s: 0 2px 10px rgba(31,42,68,.06);

  --sp: cubic-bezier(.22,1,.36,1);
  --ea: cubic-bezier(.4,0,.2,1);
  --t:  .22s;
}
```

---

## 3. HEADER CSS

Copy verbatim into every page `<style>`:

```css
/* ── Announcement Bar ── */
.ann-bar{position:fixed;top:0;left:0;right:0;z-index:1001;background:#f56c22;height:36px;display:flex;align-items:center;justify-content:center;gap:8px;padding:0 20px}
.ann-bar a{display:flex;align-items:center;gap:8px;font-family:'Nunito',sans-serif;font-weight:700;font-size:13px;color:#fff;text-decoration:none;white-space:nowrap;transition:opacity .2s}
.ann-bar a:hover{opacity:.85}
.ann-bar svg{flex-shrink:0}

/* ── Navbar ── */
.nav{position:fixed;top:36px;left:0;right:0;z-index:1000;height:72px;background:rgba(255,255,255,.92);backdrop-filter:blur(20px) saturate(1.6);-webkit-backdrop-filter:blur(20px) saturate(1.6);border-bottom:1px solid rgba(221,230,245,.4);transition:box-shadow .3s,background .3s}
.nav.scrolled{background:rgba(255,255,255,.98);box-shadow:0 1px 0 rgba(221,230,245,.8),0 6px 30px rgba(31,42,68,.07)}
.nav-row{display:flex;align-items:center;justify-content:space-between;height:72px;gap:16px}

/* Logo */
.nav-logo{display:flex;align-items:center;flex-shrink:0}
.nav-logo img{height:42px;width:auto}

/* Nav links */
.nav-links{display:flex;align-items:center;gap:2px}
.nav-links a{display:block;padding:8px 14px;border-radius:var(--r);font-weight:600;font-size:18px;color:var(--body);transition:color var(--t),background var(--t)}
.nav-links a:hover{color:var(--or);background:var(--or-lt)}
.nav-links a.active{color:var(--or)}

/* Right side */
.nav-end{display:flex;align-items:center;gap:10px}
.nav-lang{font-size:15.5px;font-weight:700;color:var(--muted);background:var(--s2);border:1.5px solid #DDE6F2;padding:5px 12px;border-radius:999px;cursor:pointer;transition:all var(--t);text-decoration:none}
.nav-lang:hover{border-color:var(--or);color:var(--or)}

/* Hamburger */
.nav-ham{display:none;flex-direction:column;gap:5px;padding:7px;border-radius:var(--r);transition:background var(--t);background:none;border:none;cursor:pointer}
.nav-ham:hover{background:var(--or-lt)}
.nav-ham span{display:block;width:22px;height:2.5px;background:var(--ink);border-radius:2px;transition:transform .32s var(--sp),opacity .24s}
.nav-ham.open span:nth-child(1){transform:translateY(7.5px) rotate(45deg)}
.nav-ham.open span:nth-child(2){opacity:0;transform:scaleX(0)}
.nav-ham.open span:nth-child(3){transform:translateY(-7.5px) rotate(-45deg)}

/* Mobile drawer */
.nav-drawer{display:none;position:fixed;top:108px;left:0;right:0;z-index:999;background:var(--w);border-bottom:1px solid #EEF2F8;padding:16px 28px 28px;flex-direction:column;gap:4px;box-shadow:0 18px 52px rgba(31,42,68,.12)}
.nav-drawer.on{display:flex}
.nav-drawer a{display:block;padding:13px 14px;border-radius:var(--r);font-weight:700;font-size:25.5px;color:var(--ink);transition:background var(--t),color var(--t);text-decoration:none}
.nav-drawer a:hover{background:var(--or-lt);color:var(--or)}
.nav-drawer .btn-cta{width:100%;justify-content:center;margin-top:12px}

/* Responsive — hide links, show hamburger */
@media(max-width:900px){
  .nav-links,.nav-lang,.nav-end .btn-cta{display:none}
  .nav-ham{display:flex}
}
```

---

## 4. HEADER HTML

### Announcement Bar
```html
<!-- ANNOUNCEMENT BAR -->
<div class="ann-bar">
  <a href="trial.html">
    <!-- For pages/ subfolder: href="trial.html" -->
    <!-- For root pages: href="pages/trial.html" -->
    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round">
      <path d="M22 8s-4 3-10 3S2 8 2 8V6a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v2z"/>
      <path d="M2 8v10a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V8"/>
      <line x1="12" y1="12" x2="12" y2="19"/>
    </svg>
    Liberal Music &amp; Arts School — Book your FREE Trial Class today at any of our 5 Singapore locations!
  </a>
</div>
```

### Navbar (pages/ subfolder version)

> **Canonical dropdown markup is `<ul class="dropdown-menu"><li><a>` (matches `index.html`).** This is the version paired with the CSS in Section 4.5 and what every page on the site uses as of May 18 2026 — including `index.html`, `pages/*.html`, `pages/articles/*.html`, and `locations/*.html`. The older `<div class="dropdown-menu"><a class="dropdown-item">` variant no longer exists anywhere.

```html
<!-- NAVBAR -->
<nav class="nav" id="nav">
  <div class="W">
    <div class="nav-row">

      <a href="../index.html" class="nav-logo" aria-label="Liberal Music & Arts Home">
        <img src="../assets/logo.webp" alt="Liberal Music & Arts" onerror="this.style.display='none'"/>
      </a>

      <!-- Nav order: Home | About | Courses | Instructors | Review | Blog | Contact ▾ — NEVER change -->
      <ul class="nav-links">
        <li><a href="../index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="courses.html">Courses</a></li>
        <li><a href="instructors.html">Instructors</a></li>
        <li><a href="review.html">Review</a></li>
        <li><a href="blog.html">Blog</a></li>

        <!-- Contact ▾ dropdown — REQUIRED on every page (added May 17 2026, canonicalised May 18 2026) -->
        <li class="nav-item-dropdown">
          <a href="contact.html" class="dropdown-trigger">Contact <span class="arrow" aria-hidden="true">▾</span></a>
          <ul class="dropdown-menu">
            <li><a href="/locations/jurong-west">Jurong West</a></li>
            <li><a href="/locations/bukit-batok">Bukit Batok (Le Quest)</a></li>
            <li><a href="/locations/tampines">Tampines</a></li>
            <li><a href="/locations/tengah">Tengah (HQ) <span class="badge-new">New</span></a></li>
          </ul>
        </li>
      </ul>

      <div class="nav-end">
        <!-- 中文 toggle: ACTIVE on root index.html only (links to index-zh.html). On all other pages, the Chinese counterpart doesn't exist yet — keep the disabled <span> below until each page-zh is built out. See Section 14 for the active-state markup. -->
        <span class="nav-lang" style="opacity:0.35;cursor:not-allowed;pointer-events:none;">中文</span>
        <!-- Book Trial button — exact padding/size must match -->
        <a href="trial.html" class="btn btn-cta" style="padding:10px 22px;font-size:14px;">Book Trial Class</a>
      </div>

      <button class="nav-ham" id="navHam" aria-label="Menu" aria-expanded="false">
        <span></span><span></span><span></span>
      </button>
    </div>
  </div>
</nav>

<!-- MOBILE DRAWER (with Contact dropdown expanded inline) -->
<nav class="nav-drawer" id="navDrawer" aria-label="Mobile navigation">
  <a href="../index.html">Home</a>
  <a href="about.html">About</a>
  <a href="courses.html">Courses</a>
  <a href="instructors.html">Instructors</a>
  <a href="review.html">Review</a>
  <a href="blog.html">Blog</a>

  <!-- Contact dropdown — in drawer it's flat (always expanded, no hover). Same <ul><li> markup as desktop. -->
  <div class="nav-item-dropdown">
    <a href="contact.html" class="dropdown-trigger" style="padding-left:0;">Contact <span class="arrow">▾</span></a>
    <ul class="dropdown-menu">
      <li><a href="/locations/jurong-west">Jurong West</a></li>
      <li><a href="/locations/bukit-batok">Bukit Batok (Le Quest)</a></li>
      <li><a href="/locations/tampines">Tampines</a></li>
      <li><a href="/locations/tengah">Tengah (HQ) <span class="badge-new">New</span></a></li>
    </ul>
  </div>

  <a href="trial.html" class="btn btn-cta">Book Trial Class</a>
</nav>
```

> **Path notes for the dropdown:**
> - **`href` of the Contact trigger** is page-relative (e.g. `contact.html` for `pages/*.html`, `pages/contact` for root). Preserve the same path that the page used before adding the dropdown.
> - **All 4 location items use absolute paths** `/locations/<branch>` — these work from any page depth (root, `pages/`, `pages/articles/`, `locations/`).
> - **Active page:** if the page IS contact.html, mark the trigger as active by merging classes: `class="dropdown-trigger active"` (one `class` attribute, two values). Do NOT add a second `class="active"` attribute — browsers ignore the duplicate and your dropdown styling silently breaks.

> **Active page:** Add `class="active"` to the `<a>` matching the current page.  
> **Instructor profile pages** (cecily.html, calvin.html, etc.): set `class="active"` on the **Instructors** nav link — they are sub-pages of Instructors.  
> **`<main>` padding-top:** Always `padding-top:108px` (36px bar + 72px nav).

---

---

## 4.5. NAVBAR DROPDOWN CSS (Contact ▾ — added May 17 2026, canonicalised May 18 2026)

The Contact dropdown is implemented as a `<li class="nav-item-dropdown">` inside `.nav-links`. Hover-opens on desktop (≥1025px) as a centered tooltip with a small arrow callout, and renders flat in the mobile drawer (≤1024px) as a nested expanded list. Paste the block below into your `<style>` after the existing nav rules.

**This CSS pairs with the `<ul class="dropdown-menu"><li><a>` markup in Section 4.** Do not mix with the older `<div class="dropdown-menu"><a class="dropdown-item">` variant — the selectors here target `.dropdown-menu li a`, so the `<div>/<a>` variant would render unstyled.

```css
/* ──────────────────────────────────────────────────────────────────
   🎯 NAVBAR DROPDOWN EXTENSION (Contact ▾ menu)
   Breakpoints aligned to nav-collapse at 1024px.
   ────────────────────────────────────────────────────────────────── */

/* 1. Desktop hover dropdown (nav-links visible at >=1025px) */
@media (min-width: 1025px) {
  .nav-links .nav-item-dropdown { position: relative; display: inline-block; }
  .nav-links .dropdown-trigger .arrow {
    display: inline-block;
    transition: transform 0.22s var(--sp);
    font-size: 12px;
    margin-left: 2px;
  }
  .nav-links .nav-item-dropdown:hover .dropdown-trigger .arrow {
    transform: rotate(180deg);
    color: var(--or);
  }
  .nav-links .dropdown-menu {
    display: block;
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translate(-50%, 15px);
    background: #FFFFFF;
    min-width: 240px;
    box-shadow: 0 12px 35px rgba(31, 42, 68, 0.12);
    border-radius: 12px;
    padding: 8px 0;
    border: 1.5px solid #EEF2F8;
    z-index: 1050;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.25s var(--sp), transform 0.25s var(--sp);
    list-style: none;
    margin: 0;
  }
  .nav-links .nav-item-dropdown:hover .dropdown-menu {
    opacity: 1;
    pointer-events: auto;
    transform: translate(-50%, 0);
  }
  /* Small triangle pointing UP to the trigger — pure CSS, no extra element */
  .nav-links .dropdown-menu::before {
    content: '';
    position: absolute;
    top: -7px;
    left: 50%;
    transform: translateX(-50%) rotate(45deg);
    width: 12px;
    height: 12px;
    background: #FFFFFF;
    border-left: 1.5px solid #EEF2F8;
    border-top: 1.5px solid #EEF2F8;
  }
  .nav-links .dropdown-menu li { margin: 0 !important; display: block; }
  .nav-links .dropdown-menu li a {
    display: block;
    padding: 11px 20px;
    font-size: 15px;
    font-weight: 700;
    color: var(--ink);
    text-align: left;
    white-space: nowrap;
    border-radius: 0;
    background: transparent;
    transition: all 0.2s ease;
  }
  .nav-links .dropdown-menu li a:hover {
    color: var(--or) !important;
    background: var(--or-lt);
    padding-left: 25px;
  }
}

/* 2. Mobile drawer (dropdown always expanded, vertical) at <=1024px */
@media (max-width: 1024px) {
  .nav-drawer .nav-item-dropdown { width: 100%; }
  .nav-drawer .dropdown-trigger { text-align: left; }
  .nav-drawer .dropdown-menu {
    display: flex;
    flex-direction: column;
    gap: 8px;
    background: var(--s1);
    padding: 10px;
    margin: 4px 0 8px;
    border-radius: 10px;
    border: 1px solid #EEF2F8;
    list-style: none;
  }
  .nav-drawer .dropdown-menu li { margin: 0; }
  .nav-drawer .dropdown-menu li a {
    display: block;
    padding: 10px 14px;
    font-size: 15px;
    font-weight: 700;
    color: var(--ink);
    border-radius: 8px;
    background: #FFFFFF;
    box-shadow: 0 2px 6px rgba(0,0,0,0.02);
  }
}

/* 3. "New" badge chip — used on the Tengah dropdown item */
.badge-new {
  font-size: 9px;
  font-weight: 900;
  background: var(--or);
  color: #FFFFFF;
  padding: 2px 5px;
  border-radius: 4px;
  margin-left: 4px;
  vertical-align: middle;
  text-transform: uppercase;
  letter-spacing: .5px;
}
```

> **Two valid breakpoint pairs — choose to match the page's existing nav-collapse, NOT the other way around.** Some pages collapse the desktop nav at 900px, others at 1024px. The dropdown CSS must use the matching breakpoint pair or the dropdown will render in a half-broken state between 901–1024px.
>
> | Page family | nav-collapse | Dropdown CSS breakpoints |
> |---|---|---|
> | `index.html`, `index-zh.html` | 900px | `min-width: 901px` / `max-width: 900px` |
> | `pages/<instructor>.html` (cecily, calvin, kate, etc.) | 900px | `min-width: 901px` / `max-width: 900px` |
> | `pages/<course>.html` (piano-course, drum-course, etc.) | 900px | `min-width: 901px` / `max-width: 900px` |
> | `pages/about.html`, `blog.html`, `contact.html`, `courses.html`, `instructors.html`, `privacy.html`, `review.html`, `terms.html`, `trial.html` | 1024px | `min-width: 1025px` / `max-width: 1024px` |
> | `pages/articles/*.html` (blog posts) | 1024px | `min-width: 1025px` / `max-width: 1024px` |
> | `locations/*.html` | 1024px | `min-width: 1025px` / `max-width: 1024px` |
>
> The CSS block above shows the **1025/1024 variant**. For 901/900 pages, swap the two `@media` numbers — everything else (including the desktop hover styling and mobile drawer styling) is identical.

> **(HQ) suffix + NEW badge** are reserved for the **Tengah** dropdown item. Tengah opened as the Flagship HQ in 2026 and replaces Jurong West as the headquarters reference. JW is now described as "established cornerstone" in copy.

> **Common bug to avoid — duplicate `class` attribute on the active page.** When the page IS contact.html, you'll want the trigger to show as active. Do this by merging into a single class attribute (`class="dropdown-trigger active"`), NOT by adding a second one (`class="active" class="dropdown-trigger"`). Browsers silently drop the duplicate, and the result is the trigger losing its dropdown styling.

---

## 4.6. MOBILE / LANDSCAPE RESPONSIVE FIXES (added May 18 2026)

These fixes resolve real-device bugs found while testing on **Galaxy Tab A11**, **Nest Hub (1024×600)**, and **landscape phones**. Three problems were fixed:

1. **Mobile drawer was un-scrollable** → on short landscape screens, the last few menu items (中文, Book Trial Class) got clipped below the viewport edge
2. **WhatsApp FAB covered the Book Trial Class button** when the drawer was open (drawer `z-index:999` < `#waWrap` inline `z-index:9999`)
3. **Android Chrome `100vh` bug** → `100vh` measures the "large" viewport (URL bar hidden), but URL bar + system nav bar are actually visible, so the drawer extended ~100px below the visible screen

### 4.6.1 Universal fixes — paste into EVERY page

This CSS block goes into `<style>` of **every** EN and ZH page (root + `pages/` + `pages-zh/` + `locations/`). It does not depend on page-specific markup — it only touches `.nav-drawer` and `#waWrap`, both of which are present on every page.

```css
/* ── Mobile drawer + WhatsApp FAB landscape fixes (May 18 2026) ── */

/* A. Drawer must scroll when content exceeds the viewport.
   - 100dvh (dynamic viewport) avoids Android's "100vh hides under system nav" bug
   - 100vh fallback for older browsers without dvh support
   - safe-area-inset-bottom keeps the last item clear of iOS home indicator
   - padding-bottom 40px keeps 中文 / Book Trial Class from touching the screen edge */
.nav-drawer{
  max-height: calc(100vh - 108px);
  max-height: calc(100dvh - 108px);
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
  overscroll-behavior: contain;
  padding-bottom: calc(40px + env(safe-area-inset-bottom, 0px));
}

/* B. Hide the WhatsApp FAB when the drawer is open — without this, the
   green circle sits ON TOP of the Book Trial Class button at the bottom
   of the drawer (inline z-index:9999 on #waWrap beats drawer z-index:999). */
.nav-drawer.on ~ #waWrap{ display: none; }
```

> **Why `~ #waWrap`:** the WhatsApp FAB markup is `<div id="waWrap">` placed near the end of `<body>` as a direct sibling of `<nav class="nav-drawer">`. The general sibling combinator targets it without needing JS coordination.

> **If a page uses the class-based `.wa` FAB instead** (older pattern — see Section 7): also add `.nav-drawer.on ~ .wa{ display: none; }`. Most pages have migrated to `#waWrap`; locations/ pages always use `#waWrap`. If unsure, include both selectors — the non-matching one is a no-op.

### 4.6.2 Homepage-only fixes — `index.html` and `index-zh.html`

These fixes ONLY apply to pages with the **hero video** section. They do NOT belong on About, Courses, Instructors, etc.

```css
/* ── Hero video landscape fixes (May 18 2026) — index.html + index-zh.html only ── */

/* C. Hero video aspect ratio + tap-to-play poster on mobile and tablets.
   - 4:5 frame letterboxes a 16:9 YouTube video → looks tiny on phones/tablets
   - Android tablet Chrome blocks YouTube autoplay → iframe loads blank
   - Fix: 16:9 frame + force the tap-to-play poster (was only <540px)
   - Hide .fc-a/.fc-b floating cards on tablets too — they're position:relative
     for the reaction-burst animation, and .fc-b (top:-800px) is visually off-
     screen but STILL occupies its normal flow space → produced a huge empty
     gap below the video on Galaxy Tab A11 in portrait. */
@media (max-width: 900px){
  .hero-frame{
    aspect-ratio: 16 / 9;
    min-width: 0;
    width: 100%;
    background: #000;
  }
  .hero-vis{ max-width: 100%; width: 100%; }
  #heroIframe{ display: none; }
  .hero-mobile-play{ display: flex; }
  .fc-a, .fc-b, .fc-c{ display: none; }
}

/* D. Short-viewport landscape (Nest Hub 1024×600, landscape tablets).
   - padding-top MUST be >= 108px (ann-bar 36 + nav 72) or the hero
     kicker pill gets clipped behind the fixed nav. Using 120px for
     breathing room.
   - Cap video height so it never overflows the screen. */
@media (orientation: landscape) and (max-height: 700px){
  .hero{
    min-height: 0;
    padding: 120px 0 50px;
    align-items: flex-start;
  }
  .hero-frame{
    aspect-ratio: 16 / 9;
    max-height: calc(100vh - 160px);
  }
  .hero-notes, .hero-ring{ display: none; }
  .fc-b{ display: none; }
}

/* E. Landscape phones (narrow AND short — e.g. Galaxy S in landscape
   ~740×360). Force a 2-column hero so the video sits beside the copy
   instead of pushing it off-screen. */
@media (orientation: landscape) and (max-width: 900px) and (max-height: 500px){
  .hero-grid{ grid-template-columns: 1.05fr 1fr; gap: 24px; }
  .hero-vis{ order: 0; max-width: none; margin: 0; }
  .hero h1{ font-size: clamp(1.4rem, 3.8vw, 2rem); margin-bottom: 12px; letter-spacing: -.5px; }
  .hero-desc{ font-size: 14px; line-height: 1.5; margin-bottom: 14px; padding-right: 0; }
  .hero-kicker{ font-size: 12px; padding: 5px 14px; margin-bottom: 12px; }
  .glance-card{ display: none; }
  .i-pills{ margin-bottom: 14px; gap: 6px; }
  .i-pill{ font-size: 13px; padding: 4px 10px; }
  .hero-btns{ margin-bottom: 16px; gap: 10px; }
  .hero-btns .btn{ font-size: 14px; padding: 10px 18px; }
  .proof{ font-size: 13px; }
  .pf{ width: 32px; height: 32px; font-size: 18px; }
  .fc-a, .fc-b, .vis-a, .vis-b{ display: none; }
}
```

### 4.6.3 Hero video poster HTML — `index.html` and `index-zh.html`

The mobile/tablet tap-to-play poster must use **`maxresdefault.jpg`** (1280×720) with `hqdefault.jpg` fallback — `hqdefault` (480×360) is too low-res for tablets and looks blurry when stretched.

```html
<!-- Inside .hero-frame, after the YouTube iframe -->
<button type="button" class="hero-mobile-play" id="heroMobilePlay" aria-label="Play video">
  <img src="https://img.youtube.com/vi/Yh8Z6yca-28/maxresdefault.jpg"
       alt="Video preview" loading="lazy"
       onerror="this.onerror=null;this.src='https://img.youtube.com/vi/Yh8Z6yca-28/hqdefault.jpg'"/>
  <span class="hero-mobile-play-btn" aria-hidden="true">
    <svg viewBox="0 0 24 24" width="36" height="36" fill="#fff"><path d="M8 5v14l11-7z"/></svg>
  </span>
</button>
```

> **For `index-zh.html`:** same markup, only `alt="Video preview"` becomes `alt="视频预览"`.

### 4.6.4 Where to paste in your `<style>` block

Order matters because of CSS cascade. Place the 4.6 block **after** the 4.5 dropdown CSS and **before** the FOOTER CSS (Section 5):

```css
/* … Section 3 HEADER CSS … */
/* … Section 4.5 NAVBAR DROPDOWN CSS … */
/* … Section 4.6 MOBILE / LANDSCAPE FIXES ← HERE … */
/* … Section 5 FOOTER CSS … */
```

### 4.6.5 Per-page application matrix

| Page type | 4.6.1 (drawer + FAB) | 4.6.2 (hero video) | 4.6.3 (poster HTML) |
|---|---|---|---|
| `index.html` (EN home) | ✅ Required | ✅ Required | ✅ Required |
| `index-zh.html` (ZH home) | ✅ Required | ✅ Required | ✅ Required (`alt` localized) |
| `pages/*.html` (About, Courses, Instructors, Review, Blog, Contact, Trial, Privacy, Terms, instructor profiles) | ✅ Required | ❌ Skip (no hero video) | ❌ Skip |
| `locations/*.html` (Tengah, Bukit Batok, Jurong West, Tampines) | ✅ Required | ❌ Skip (no hero video) | ❌ Skip |
| `pages-zh/*.html` (future) | ✅ Required | ❌ Skip | ❌ Skip |

### 4.6.6 Verification — testing on real devices

After applying, test these scenarios:

| Device / mode | What to check |
|---|---|
| Galaxy Tab A11 landscape (≈1340×800 CSS) | Open hamburger → scroll to bottom → **Book Trial Class button must be fully visible**, not hidden under Android system nav |
| Galaxy Tab A11 portrait | Hero shows a **clear video poster** with orange ▶ button; tapping it plays the video. No huge white gap below the video. |
| Nest Hub 1024×600 simulator | Open hamburger → drawer scrolls. The orange "Singapore's Most Trusted ABRSM Specialist" pill is fully visible (not clipped under nav). |
| Landscape phone (Galaxy S in landscape, ~740×360) | Hero shows side-by-side text + video; no overflow; menu drawer scrolls |
| Any tablet with drawer open | Green WhatsApp FAB is **hidden**. After closing the drawer, it reappears. |

---

## 4.7. ORANGE KEYWORD UNDERLINE ANIMATION — `.kw` (added May 18 2026)

The site's "highlighter" effect: orange keywords inside H1 headlines get a soft teal underline that animates in (scaleX 0 → 1) shortly after page load. This is a brand-signature touch — every hero headline should use it on its key noun.

### 4.7.1 The class — `.kw`

```html
<h1>Music & Arts for Every <span class="kw">Child</span></h1>
```

- Wrap **one keyword per headline** in `<span class="kw">`.
- Pick a noun that carries the headline's meaning (Child, Lessons, Hearts, First Lesson, Top-Rated, Confident, etc.). Avoid wrapping verbs or articles.
- Never wrap more than one phrase per H1 — the highlight loses impact when used twice.
- Don't use `<em>` for this purpose — the canonical class is `.kw`. (Legacy `<em>` usage in older versions of `about.html` was migrated on May 18, 2026.)

### 4.7.2 Canonical CSS — paste verbatim into every page

```css
/* ── Orange keyword underline (canonical, May 18 2026) ──
   .kw uses isolation:isolate so z-index:-1 on ::after stays
   inside .kw and doesn't escape behind page-hero's gradient
   background (the bug that made the underline invisible on
   8 of 9 pages until May 18 2026). */
.kw{position:relative;display:inline-block;color:var(--or);isolation:isolate}
.kw::after{
  content:'';
  position:absolute;
  bottom:4px;
  left:0;
  width:100%;
  height:9px;
  background:#8ddbd1;
  border-radius:5px;
  z-index:-1;
  transform:scaleX(0);
  transform-origin:left;
  animation:kw 0.6s var(--sp) 0.95s forwards;
}
@keyframes kw{to{transform:scaleX(1)}}
```

| Property | Value | Why |
|---|---|---|
| color | `var(--or)` #FF6600 | Brand orange — matches CTA accents |
| underline color | `#8ddbd1` teal | Site's secondary highlight color |
| underline height | 9px | Thick enough to feel like a brush stroke without overpowering the text |
| `bottom: 4px` | Below baseline | Sits just under the descenders, mimics handwritten highlighter |
| animation delay | 0.95s | Lets hero text settle before the underline draws in |
| animation duration | 0.6s | Quick enough to feel reactive, slow enough to register |
| `forwards` | retains scaleX(1) | Otherwise the underline reverts to invisible after the animation ends |
| **`isolation: isolate`** | **stacking context** | **Critical fix** — see §4.7.3 |

### 4.7.3 ⚠️ The bug this fixed (and why `isolation: isolate` is mandatory)

Until May 18, 2026, the `.kw::after` underline was invisible on 8 of 9 `pages/*.html` files even though the CSS was technically correct. The flash-and-vanish behavior reported by the user is the visual signature of this bug.

**Why it happened:**

`.kw::after` uses `z-index: -1` to slip the underline behind the text (creating the highlighter effect — the text reads over the colored bar). For this to work, the underline must stay **inside `.kw`'s stacking context**. Without one, `z-index: -1` escapes outward, hunting for the nearest stacking context to settle behind.

- `.kw` is `position: relative` + `display: inline-block`. By CSS spec, **this alone does NOT create a stacking context.**
- `.page-hero` is `position: relative` (no `z-index`). **Also doesn't create a stacking context.**
- `.page-hero` has an opaque `linear-gradient(...)` background.

Result: `.kw::after { z-index: -1 }` escapes out of `.kw`, out of `.page-hero`, ends up behind `.page-hero`'s gradient → completely hidden. The "flash" the user saw was the scaleX(0)→scaleX(1) animation running BEFORE the page-hero's paint had finished, briefly visible, then covered.

**Why `about.html` worked anyway:** its hero had `.hero-inner { position:relative; z-index:1 }` — an explicit `z-index` that DID create a stacking context. The underline got trapped inside `.hero-inner` (a transparent box) and remained visible.

**The fix:** `isolation: isolate` on `.kw` itself. This is the cleanest way to create a stacking context — designed for exactly this use case, no layout side effects, no need for explicit z-index. The `::after` is now sealed inside `.kw` regardless of what the ancestors do.

### 4.7.4 Per-page application

The CSS is structural — paste it into **every page** even if the page doesn't currently use `<span class="kw">`. Cost is ~3 lines of CSS; benefit is that adding a `.kw` later "just works" without re-debugging.

| Page family | Has `.kw` usage today | Apply canonical CSS |
|---|---|---|
| `index.html` + `index-zh.html` | ✅ Yes ("Top-Rated") | ✅ Required (already canonical) |
| `pages/about, blog, contact, courses, instructors, review, trial` | ✅ Yes | ✅ Required |
| `pages/privacy, terms` | ❌ No (legal pages) | ✅ Required (no-op placeholder for consistency) |
| `pages/<instructor>.html` (13 files) | ❌ No | ✅ Required (no-op placeholder) |
| `pages/<course>.html` (12 files) | ✅ Yes (every one — Course/Lessons/Training/Kids/Top-Rated) | ✅ Required |
| `pages/articles/*.html` (blog posts) | ❌ No | ✅ Required (no-op placeholder) |
| `locations/*.html` | ✅ Yes | ✅ Required |

### 4.7.5 Multiple `<style>` blocks — duplicate rule risk

If a page has competing `.kw` rules from earlier development (e.g. `.hero-headline .kw{...}` or `.trial-headline .kw{...}`), the **more specific selector wins** and overrides the canonical version's `isolation: isolate`. When migrating an old page:

1. Search for `\.kw\s*\{`, `\.kw::after`, and `@keyframes kw` — there should be **exactly one** of each after migration.
2. If older selectors with prefixes exist (`.hero-headline .kw`, `.trial-headline .kw`, `.page-hero h1 em`, etc.), **delete them entirely**. The canonical unprefixed `.kw` selector is sufficient and avoids specificity wars.

### 4.7.6 Sanity-check script (run after editing a page)

```bash
grep -c "isolation:isolate" page.html      # → 1
grep -c "#8ddbd1" page.html                # → 1
grep -c "0.95s forwards" page.html         # → 1
grep -c "@keyframes kw" page.html          # → 1
```

All four should return `1`. If any returns `0`, the canonical block wasn't applied. If any returns `2+`, there are duplicate rules — delete the older variant.

---

## 5. FOOTER CSS

Copy verbatim into every page `<style>`:

```css
/* ── Footer ── */
.footer{background:#1F2A44;margin:0;border-top:none;padding:80px 0 0}
.foot-grid{display:grid;grid-template-columns:1.8fr 1fr 1.7fr;gap:60px;padding-bottom:60px;border-bottom:1px solid rgba(255,255,255,.08);margin-bottom:0}
.foot-brand img{height:56px;width:auto;margin-bottom:22px;display:block}
.foot-brand p{font-size:15px;line-height:1.82;color:#fff;max-width:300px;margin-bottom:8px}
.foot-soc{display:flex;gap:9px;margin-top:24px;padding-bottom:4px}
.foot-soc a{width:36px;height:36px;border-radius:0;background:transparent;border:none;display:flex;align-items:center;justify-content:center;padding:0;transition:opacity .18s,transform .18s var(--sp)}
.foot-soc a:hover{opacity:.75;transform:translateY(-2px)}
.foot-col h5{font-family:'Nunito',sans-serif;font-weight:900;font-size:15px;text-transform:uppercase;letter-spacing:1.4px;color:#fff;margin-bottom:22px;display:flex;align-items:center;gap:7px}
.foot-col h5::after{content:'';flex:1;height:1px;background:rgba(255,255,255,.12)}
.foot-col ul{display:flex;flex-direction:column;gap:10px}
.foot-col a{font-size:15px;color:#fff;transition:color .18s,padding-left .18s;display:block}
.foot-col a:hover{color:#fff;padding-left:4px}
.foot-locs{display:flex;flex-direction:column;gap:8px}
.foot-loc{display:grid;grid-template-columns:18px 1fr;gap:9px;align-items:flex-start;padding:11px 13px;border-radius:12px;background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.07);transition:background .18s,border-color .18s,transform .18s var(--sp)}
.foot-loc:hover{background:rgba(255,102,0,.12);border-color:rgba(255,102,0,.30);transform:translateX(3px)}
.foot-loc-pin{color:var(--or);font-size:22px;line-height:1.6;margin-top:1px;flex-shrink:0}
.foot-loc-text strong{display:block;font-family:'Nunito',sans-serif;font-weight:800;font-size:15px;color:#fff;margin-bottom:2px}
.foot-loc-text span{font-size:13px;color:rgba(255,255,255,.8);line-height:1.5}
.foot-loc-meta{display:block;margin-top:6px;font-size:11.5px;color:rgba(255,255,255,.55);line-height:1.5;letter-spacing:.1px}
.foot-loc-meta .sep{margin:0 6px;color:rgba(255,255,255,.3)}
.foot-loc.soon{background:rgba(255,102,0,.10);border-color:rgba(255,102,0,.25)}
.foot-loc.soon .foot-loc-text strong{color:var(--or)}
.foot-loc.soon .foot-loc-text span{color:rgba(255,150,50,.7);font-weight:700}
.foot-loc.soon .foot-loc-meta{color:rgba(255,170,90,.7)}
.foot-loc.soon .foot-loc-meta .sep{color:rgba(255,170,90,.4)}
.foot-btm{display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px;padding:22px 0 30px;background:#1F2A44}
.foot-btm p{font-size:15px;color:rgba(255,255,255,.35)}
.foot-btm-links{display:flex;gap:20px;align-items:center}
.foot-btm a{font-size:15px;color:rgba(255,255,255,.35);transition:color .18s}
.foot-btm a:hover{color:#fff}
@media(max-width:900px){.foot-grid{grid-template-columns:1fr 1fr}}
@media(max-width:700px){.foot-grid{grid-template-columns:1fr}.foot-brand{border-bottom:1px solid rgba(255,102,0,.1);padding-bottom:28px}}
html,body{margin-bottom:0!important;padding-bottom:0!important;height:auto!important}
footer{margin-bottom:0!important}
.footer{padding-bottom:0!important}
```

---

## 6. FOOTER HTML (pages/ subfolder version)

```html
<!-- FOOTER -->
<footer class="footer">
  <div class="W">
    <div class="foot-grid">

      <!-- Col 1: Brand -->
      <div class="foot-brand">
        <img src="../assets/logofooter.webp" alt="Liberal Music &amp; Arts School"
             onerror="this.src='../assets/logo.webp'"/>
        <p>Liberal Music &amp; Arts School nurtures creativity, confidence, and a lifelong love of music and the arts — for ages 2.5 to adult. With expert teachers, holistic learning, and proven results, we are proud to be trusted by over 20,000 families in Singapore since 2009.</p>
        <div class="foot-soc">
          <a href="https://www.instagram.com/liberalmusic_arts/" target="_blank" rel="noopener noreferrer" aria-label="Instagram">
            <img src="../assets/Instagram.webp" alt="Instagram" style="width:26px;height:26px;object-fit:contain;filter:brightness(0) invert(1);display:block;"/>
          </a>
          <a href="https://www.facebook.com/liberalmusicandarts/" target="_blank" rel="noopener noreferrer" aria-label="Facebook">
            <img src="../assets/facebook.webp" alt="Facebook" style="width:22px;height:22px;object-fit:contain;filter:brightness(0) invert(1);"/>
          </a>
          <a href="https://youtube.com/@liberalmusicartsschoolsingapor?si=0EdJLdRw-WoXKxOR" target="_blank" rel="noopener noreferrer" aria-label="YouTube">
            <img src="../assets/youtube.webp" alt="YouTube" style="width:22px;height:22px;object-fit:contain;filter:brightness(0) invert(1);"/>
          </a>
          <!-- Xiaohongshu URL not yet supplied — keep href="#" until provided, then wire up site-wide -->
          <a href="#" aria-label="Xiaohongshu">
            <img src="../assets/xiaohongshu.webp" alt="Xiaohongshu" style="width:22px;height:22px;object-fit:contain;filter:brightness(0) invert(1);"/>
          </a>
        </div>
      </div>

      <!-- Col 2: Navigation -->
      <div class="foot-col">
        <h5>Navigation</h5>
        <ul>
          <li><a href="../index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="courses.html">Courses</a></li>
          <li><a href="instructors.html">Instructors</a></li>
          <li><a href="review.html">Review</a></li>
          <li><a href="blog.html">Blog</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </div>

      <!-- Col 3: Locations — ALL 5, never remove any -->
      <div class="foot-col">
        <h5>Our Locations</h5>
        <div class="foot-locs">

          <div class="foot-loc">
            <span class="foot-loc-pin">
              <img src="../assets/address.webp" alt="location"
                   style="width:16px;height:16px;object-fit:contain;filter:brightness(0) invert(1);opacity:.7;"/>
            </span>
            <div class="foot-loc-text">
              <strong>Tengah Music School</strong>
              <span>127A Plantation Crescent, #01-381<br>Singapore 691127</span>
              <span class="foot-loc-meta"><img src="../assets/mrt.webp" alt="MRT" style="width:15px;height:15px;object-fit:contain;filter:brightness(0) invert(1);opacity:.8;vertical-align:-3px;margin-right:5px;display:inline-block;"/>Near future Jurong Region Line (opening 2028)<span class="sep">·</span>🕐 Daily 1pm–9pm</span>
            </div>
          </div>

          <div class="foot-loc">
            <span class="foot-loc-pin">
              <img src="../assets/address.webp" alt="location"
                   style="width:16px;height:16px;object-fit:contain;filter:brightness(0) invert(1);opacity:.7;"/>
            </span>
            <div class="foot-loc-text">
              <strong>Tampines Music School</strong>
              <span>Blk 139 Tampines St 11, #01-60<br>Singapore 521139</span>
              <span class="foot-loc-meta"><img src="../assets/mrt.webp" alt="MRT" style="width:15px;height:15px;object-fit:contain;filter:brightness(0) invert(1);opacity:.8;vertical-align:-3px;margin-right:5px;display:inline-block;"/>Near Tampines West MRT<span class="sep">·</span>🕐 Daily 1pm–9pm</span>
            </div>
          </div>

          <div class="foot-loc">
            <span class="foot-loc-pin">
              <img src="../assets/address.webp" alt="location"
                   style="width:16px;height:16px;object-fit:contain;filter:brightness(0) invert(1);opacity:.7;"/>
            </span>
            <div class="foot-loc-text">
              <strong>Jurong West Music School</strong>
              <span>Blk 492 Jurong West St 41, #01-10<br>Singapore 640492</span>
              <span class="foot-loc-meta"><img src="../assets/mrt.webp" alt="MRT" style="width:15px;height:15px;object-fit:contain;filter:brightness(0) invert(1);opacity:.8;vertical-align:-3px;margin-right:5px;display:inline-block;"/>Near Lakeside MRT<span class="sep">·</span>🕐 Daily 1pm–9pm</span>
            </div>
          </div>

          <div class="foot-loc">
            <span class="foot-loc-pin">
              <img src="../assets/address.webp" alt="location"
                   style="width:16px;height:16px;object-fit:contain;filter:brightness(0) invert(1);opacity:.7;"/>
            </span>
            <div class="foot-loc-text">
              <strong>Le Quest Mall Music School</strong>
              <span>4 Bukit Batok St 41, #01-83<br>Singapore 657991</span>
              <span class="foot-loc-meta"><img src="../assets/mrt.webp" alt="MRT" style="width:15px;height:15px;object-fit:contain;filter:brightness(0) invert(1);opacity:.8;vertical-align:-3px;margin-right:5px;display:inline-block;"/>Near Bukit Batok MRT<span class="sep">·</span>🕐 Daily 1pm–9pm</span>
            </div>
          </div>

          <!-- 5th slot: Coloury Art By Liberal — clickable card linking to colouryart.com -->
          <a href="https://colouryart.com/" target="_blank" rel="noopener" class="foot-loc soon" style="text-decoration:none;display:grid;">
            <span class="foot-loc-pin">✦</span>
            <div class="foot-loc-text">
              <strong>Coloury Art By Liberal</strong>
              <span>#03-07C Level 3, Jurong Point<br>Singapore 648886</span>
              <span class="foot-loc-meta"><img src="../assets/mrt.webp" alt="MRT" style="width:15px;height:15px;object-fit:contain;filter:brightness(0) invert(1);opacity:.8;vertical-align:-3px;margin-right:5px;display:inline-block;"/>Near Boon Lay MRT<span class="sep">·</span>✦ Opening Soon</span>
            </div>
          </a>

        </div>
      </div>

    </div>

    <!-- Bottom bar -->
    <div class="foot-btm">
      <p>© 2025 Liberal Music &amp; Arts School. All rights reserved.</p>
      <div class="foot-btm-links">
        <span style="font-size:12px;color:rgba(255,255,255,.22);font-family:'Nunito',sans-serif;font-weight:700;letter-spacing:.5px;">v1.0.1</span>
        <a href="privacy">Privacy Policy</a>
        <a href="terms">Terms of Use</a>
        <!-- 中文版本 toggle: ACTIVE on root index.html only (links to index-zh.html). All other pages keep the disabled <span> below until each page-zh is built out. See Section 14. -->
        <span style="font-size:15px;color:rgba(255,255,255,.15);cursor:not-allowed;">中文版本</span>
      </div>
    </div>
  </div>
</footer>
```

> **About the `.foot-loc-meta` line on each card** *(added April 28 2026 for AEO/local-search):* Every location card carries a third line beneath the address showing 🚇 nearest MRT + 🕐 hours (or "✦ Opening Soon" for Coloury Art). It exists so AI search engines (Perplexity, SearchGPT, Gemini) can answer queries like *"music school near Lakeside MRT"* or *"music school open now"* by scraping the footer text. The `.foot-loc-meta` rule is small (11.5px) and muted (`opacity .55`) so it sits visually quiet — bold enough for scrapers, light enough not to fight the address. The MRT icon uses `assets/mrt.webp` (purple/blue source, white-rendered via `filter:brightness(0) invert(1)`). The `.sep` `<span>·</span>` is a thin middot separator. The Coloury Art card auto-inherits an orange-tinted variant via `.foot-loc.soon .foot-loc-meta`.

---

## 7. WHATSAPP FAB + MOBILE STICKY BAR CSS

```css
/* WA FAB */
.wa{position:fixed;bottom:28px;right:28px;z-index:900;pointer-events:none}
.wa-fab{pointer-events:all;width:58px;height:58px;border-radius:50%;background:#25D366;color:#fff;display:flex;align-items:center;justify-content:center;font-size:36px;box-shadow:0 8px 28px rgba(37,211,102,.42);transition:transform var(--t) var(--sp),box-shadow var(--t);cursor:pointer;border:none}
.wa-fab:hover{transform:scale(1.12);box-shadow:0 14px 40px rgba(37,211,102,.54)}
.wa-panel{pointer-events:all;position:absolute;bottom:68px;right:0;background:var(--w);border-radius:var(--r-l);box-shadow:var(--sh-l);width:290px;padding:22px;border:1px solid #EEF2F8;opacity:0;transform:scale(.88) translateY(10px);transform-origin:bottom right;pointer-events:none;transition:opacity var(--t) var(--sp),transform var(--t) var(--sp)}
.wa-panel.on{opacity:1;transform:scale(1) translateY(0);pointer-events:all}
.wa-panel h4{font-family:'Nunito',sans-serif;font-size:16px;font-weight:900;color:var(--ink);margin-bottom:4px}
.wa-panel p{font-size:13px;color:var(--muted);margin-bottom:14px}
.wa-row{display:flex;align-items:center;justify-content:space-between;padding:11px 14px;border-radius:12px;background:var(--s2);border:1.5px solid #EEF2F8;margin-bottom:8px;font-family:'Nunito',sans-serif;font-weight:700;font-size:14px;color:var(--ink);transition:all var(--t);text-decoration:none}
.wa-row:hover{border-color:#25D366;background:#E8FFF1;color:#1a8a45}
.wa-row span{font-size:12px;font-weight:500;color:var(--muted)}
.wa-row:hover span{color:#1a8a45}

/* Mobile sticky bar */
.mob-bar{display:none;position:fixed;bottom:0;left:0;right:0;z-index:800;background:var(--w);padding:12px 20px 16px;box-shadow:0 -4px 20px rgba(31,42,68,.09);border-top:1px solid #EEF2F8}
.mob-bar .btn-cta{width:100%;justify-content:center;font-size:18px;padding:15px}

@media(max-width:1024px){
  /* Raised from 900px to 1024px (May 14 + May 17 2026) so hamburger / mobile sticky bar
     also kick in at Nest Hub width (1024×600). The footer .foot-grid breakpoint stays at 900px. */
  .mob-bar{display:block}
  .wa{bottom:84px}
}
```

---

## 8. WHATSAPP FAB + MOBILE STICKY BAR HTML

```html
<!-- FLOATING WHATSAPP FAB -->
<div class="wa">
  <div class="wa-panel" id="waPanel" role="dialog" aria-label="WhatsApp us">
    <h4>💬 Chat with Us!</h4>
    <p>Pick your nearest branch to WhatsApp directly.</p>
    <a href="https://wa.me/6589222848" target="_blank" rel="noopener" class="wa-row">
      🏡 Tengah <span>8922 2848</span>
    </a>
    <a href="https://wa.me/6588921198" target="_blank" rel="noopener" class="wa-row">
      🌅 Tampines <span>8892 1198</span>
    </a>
    <a href="https://wa.me/6596277588" target="_blank" rel="noopener" class="wa-row">
      🌸 Jurong West <span>9627 7588</span>
    </a>
    <a href="https://wa.me/6596277582" target="_blank" rel="noopener" class="wa-row">
      🏬 Le Quest <span>9627 7582</span>
    </a>
    <a href="https://wa.me/6589951163" target="_blank" rel="noopener" class="wa-row">
      ✦ Coloury Art <span>8995 1163</span>
    </a>
  </div>
  <button class="wa-fab" id="waFab" aria-label="Open WhatsApp"><img src="../assets/whatsapp.webp" alt="WhatsApp" style="width:32px;height:32px;object-fit:contain;display:block;"/></button>
</div>
```

> **FAB icon notes:**
> - Use `whatsapp.webp` (NOT the 💬 emoji — emoji renders inconsistently across platforms).
> - **Do NOT apply `filter:brightness(0) invert(1)`** to the icon. The image is already a green WhatsApp logo with a white phone inside. The green blends invisibly into the FAB's `#25D366` background, leaving only the recognizable white phone silhouette visible. Applying the filter merges everything into a featureless white blob.
> - Asset path is `../assets/whatsapp.webp` from `pages/`, `assets/whatsapp.webp` from root, `../../assets/whatsapp.webp` from `pages/articles/`.

> **Popup row order (always exactly 5):** Tengah → Tampines → Jurong West → Le Quest → Coloury Art. See `HOW-TO-START.md` for the WhatsApp number table and history of the April 2026 number split.

<!-- MOBILE STICKY CTA BAR -->
<div class="mob-bar">
  <!-- For pages/ subfolder: -->
  <a href="trial.html" class="btn btn-cta">✦ Book Free Trial Class</a>
  <!-- For root pages: href="pages/trial.html" -->
</div>
```

---

## 9. JAVASCRIPT (paste before `</body>` on every page)

```html
<script>
(function(){
  'use strict';

  /* Navbar scroll shadow */
  const nav = document.getElementById('nav');
  window.addEventListener('scroll', () => nav.classList.toggle('scrolled', scrollY > 20), {passive:true});

  /* Hamburger toggle */
  const ham = document.getElementById('navHam');
  const drw = document.getElementById('navDrawer');
  ham.addEventListener('click', () => {
    const o = drw.classList.toggle('on');
    ham.classList.toggle('open', o);
    ham.setAttribute('aria-expanded', String(o));
  });
  document.addEventListener('click', e => {
    if (!e.target.closest('.nav') && !e.target.closest('.nav-drawer')) {
      drw.classList.remove('on');
      ham.classList.remove('open');
    }
  });

  /* WhatsApp popup */
  const waFab   = document.getElementById('waFab');
  const waPanel = document.getElementById('waPanel');
  waFab.addEventListener('click', e => { e.stopPropagation(); waPanel.classList.toggle('on'); });
  document.addEventListener('click', e => { if (!e.target.closest('.wa')) waPanel.classList.remove('on'); });

  /* Scroll reveal */
  document.body.classList.add('reveal-ready');
  const rvIO = new IntersectionObserver(entries => {
    entries.forEach(en => {
      if (en.isIntersecting) { en.target.classList.add('in'); rvIO.unobserve(en.target); }
    });
  }, { threshold:.05, rootMargin:'0px 0px -10px 0px' });
  document.querySelectorAll('.sr,.sl,.sfr').forEach(el => rvIO.observe(el));

})();
</script>
```

---

## 10. PAGE SKELETON (complete shell for a new page)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
  <title>PAGE TITLE | Liberal Music &amp; Arts School</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
  <link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,400;0,600;0,700;0,800;0,900;1,800&family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet"/>
  <style>
    /* 1. :root variables (Section 2) */
    /* 2. Reset */
    *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
    html{scroll-behavior:smooth;background:#1F2A44}
    body{font-family:'Quicksand',system-ui,sans-serif;color:var(--body);background:var(--w);overflow-x:hidden;-webkit-font-smoothing:antialiased}
    h1,h2,h3,h4{font-family:'Nunito',sans-serif;color:var(--ink);line-height:1.18;font-weight:900}
    a{text-decoration:none;color:inherit}img{display:block;max-width:100%}ul{list-style:none}
    /* 3. Layout */
    .W{max-width:1240px;margin:0 auto;padding:0 32px}
    section{padding:100px 0}
    /* 4. Buttons */
    .btn{display:inline-flex;align-items:center;justify-content:center;gap:8px;font-family:'Nunito',sans-serif;font-weight:800;border-radius:999px;white-space:nowrap;transition:background var(--t) var(--ea),box-shadow var(--t) var(--sp),transform var(--t) var(--sp)}
    .btn-cta{background:var(--or);color:#fff;box-shadow:var(--or-sh);font-size:15px;padding:13px 28px}
    .btn-cta:hover{background:var(--or-dk);box-shadow:var(--or-shh);transform:translateY(-2px) scale(1.04)}
    .btn-outline{background:transparent;color:var(--ink);border:2px solid #DDE6F2;font-size:15px;padding:13px 28px}
    .btn-outline:hover{border-color:var(--or);color:var(--or);transform:translateY(-2px)}
    .btn-lg{font-size:17px;padding:17px 40px}
    /* 5. Scroll reveal */
    .sr,.sl,.sfr{opacity:1;transform:none}
    body.reveal-ready .sr{opacity:0;transform:translateY(22px);transition:opacity .65s var(--sp),transform .65s var(--sp)}
    body.reveal-ready .sl{opacity:0;transform:translateX(-22px);transition:opacity .65s var(--sp),transform .65s var(--sp)}
    body.reveal-ready .sfr{opacity:0;transform:translateX(22px);transition:opacity .65s var(--sp),transform .65s var(--sp)}
    body.reveal-ready .sr.in,body.reveal-ready .sl.in,body.reveal-ready .sfr.in{opacity:1!important;transform:none!important}
    .d1{transition-delay:.07s}.d2{transition-delay:.14s}.d3{transition-delay:.21s}.d4{transition-delay:.28s}.d5{transition-delay:.35s}
    /* 6. Header CSS (Section 3) */
    /* 7. Footer CSS (Section 5) */
    /* 8. WA + mob-bar CSS (Section 7) */
    /* 9. Page-specific styles */
  </style>
</head>
<body>

  <!-- ANNOUNCEMENT BAR (Section 4) -->
  <!-- NAVBAR (Section 4) -->
  <!-- MOBILE DRAWER (Section 4) -->

  <main style="padding-top:108px">
    <!-- PAGE CONTENT HERE -->
  </main>

  <!-- FOOTER (Section 6) -->
  <!-- WA FAB + MOBILE STICKY (Section 8) -->

  <!-- JS (Section 9) -->
</body>
</html>
```

---

## 11. INSTRUCTOR PROFILE PAGE PATTERN

All instructor profile pages (cecily, calvin, kate, jescelyn, tina, verginia, cheng, aliona, teresa, jiang, mindy, leonard, loy) follow a fixed structure.  
**Always use the most recently edited `cecily.html` as the copy base** — it is the canonical template.

### File locations
```
pages/cecily.html
pages/calvin.html
pages/kate.html
pages/jescelyn.html
pages/tina.html
pages/verginia.html
pages/cheng.html
pages/aliona.html
pages/teresa.html
pages/jiang.html
pages/mindy.html
pages/leonard.html
pages/loy.html
```

### Active nav link rule
Instructor profile pages are sub-pages of Instructors. Always set `class="active"` on the **Instructors** link:
```html
<li><a href="instructors.html" class="active">Instructors</a></li>
```

### Breadcrumb pattern (below nav, above profile)
```html
<div class="breadcrumb sr">
  <a href="../index.html">Home</a>
  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="9 18 15 12 9 6"/></svg>
  <a href="instructors.html">Our Instructors</a>
  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="9 18 15 12 9 6"/></svg>
  <span>INSTRUCTOR NAME</span>
</div>
```

### Layout: 2-column profile grid
```
Left col (380px sticky): photo card → tags → book card
Right col (1fr):         back link → pill tag → name → title → stat pills → lead → education → achievements
```

### Photo card badge colours by role
| Role | Badge background |
|---|---|
| Principal | `var(--or)` #FF6600 (default orange) |
| Vice Principal | `#2472a4` (blue) |
| Instructor (Chinese instruments) | `#1a7058` (teal) |
| Instructor (Piano/Western) | `var(--lav)` / `#5550c8` (lavender) |
| Instructor (Strings) | `#c75b8a` (pink) |
| Instructor (Guitar/Drums) | `#2472a4` (blue) |
| Instructor (Guitar/Ukulele) | `#5b8a3c` (green) |

### Book card CTA text
Always: `Book Trial Class` — **never** "Book Free Trial Class" on the photo card button.

### "Other Instructors" strip
Each instructor profile shows the **other 12** instructors at the bottom — the current page's instructor must be **excluded**. Cards use portrait shape (4:5 ratio, `object-position:top center`), name at 18px Nunito 900.

### Current instructor roster (13 total)
| File | Name | Speciality |
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

### Pill tag colours used on profile pages
```css
.pill-tag { font-family:'Nunito'; font-weight:800; font-size:13px; text-transform:uppercase; letter-spacing:1.4px; padding:6px 14px; border-radius:999px; display:inline-block; }
.pt-lv    { background:#98a3f8; color:#fff; }           /* section label — purple */
.pt-tl    { background:var(--teal); color:#1a7058; }    /* Chinese/strings — teal */
.pt-or    { background:var(--or-lt); color:var(--or); } /* orange highlight */
```

### Instructor page — adding a new one
1. Copy `cecily.html` → rename to `newname.html`
2. Update: `<title>`, breadcrumb `<span>`, photo `src` + `alt`, badge colour + text, tags, book-card text, name `h1`, title `p`, stat pills, lead paragraph, education items, achievements text
3. Set `class="active"` on Instructors nav link
4. In the "Other Instructors" strip: remove the new instructor's card, add all others with correct `href` and speciality labels
5. Add the new page to `instructors.html` grid with a clickable `<a class="icard">` wrapper

---

---

## 11.5. LOCATION PAGE PATTERN (`locations/*.html` — added May 17 2026)

Branch landing pages live at `/locations/<branch>` and are structurally similar to instructor profile pages, but with a different content focus (local-search AEO instead of teacher bio).

> **Chinese counterpart:** see **§14.16 LOCATION-ZH PAGE PATTERN** below for the `locations-zh/*.html` localisation rules (bilingual JSON-LD, hreflang, EN slug preservation, dropdown routing to `/locations-zh/`).

> **Contact dropdown — uses canonical `<ul><li>` markup** (matching Section 4) as of May 18 2026. All 4 location pages (Tengah, Bukit Batok, Jurong West, Tampines) now follow the standard pattern — no legacy variants remaining. Section 4.5 CSS with 1024/1025px breakpoints applies.

### File locations
| File | Branch | URL |
|---|---|---|
| `locations/tengah.html` | Tengah (Flagship HQ) | `/locations/tengah` |
| `locations/bukit-batok.html` | Bukit Batok (Le Quest) | `/locations/bukit-batok` |
| `locations/jurong-west.html` | Jurong West | `/locations/jurong-west` |
| `locations/tampines.html` | Tampines | `/locations/tampines` |

### Canonical template
**`locations/tengah.html` is the canonical template.** When adding a new branch (e.g. a future Coloury Art landing page at `locations/coloury-art.html`), clone Tengah and swap branch-specific data.

### Path conventions inside a location page

| Item | Path used | Why |
|---|---|---|
| Asset (logo, icon, image) | `../assets/<file>` | locations/ is one level deep, same as pages/ |
| Internal page link (e.g. About, Courses) | `../pages/about` | go up one, then into pages/ |
| Index link | `../index.html` | go up one |
| Dropdown menu items | `/locations/<branch>` | absolute paths (work from any URL depth) |
| Privacy / Terms in footer | `../pages/privacy`, `../pages/terms` | one up, into pages |

### Required `<head>` items
- `<title>` — pattern: `Top Music School in <Branch> | <Optional sub-tag> | Liberal Music School`
- `<link rel="canonical" href="https://liberalmusicschool.com/locations/<branch>">`
- `<meta name="description">` — branch-specific, 140–160 chars, includes nearest MRT
- **Two JSON-LD blocks**: `@type: "MusicSchool"` (branch-specific name/address/geo/hours/sameAs to Google Business Profile) + `@type: "FAQPage"` (mirrors visible FAQ Q&A exactly)

### Page section order (top to bottom)
1. **Hero** — breadcrumb + pill tag + H1 + sub-headline + Quick Facts (4-up grid) + 2 CTAs + 10 course pills
2. **Location Hub** — full address + "Getting Here" paragraph + Studio Hours (per-branch) + Chat-on-WhatsApp action button + embedded Google Maps iframe
3. **Programs** — 10 course cards (Piano, Violin, Guitar, Ukulele, Drums, Vocal, Music for Kids, Chinese, Music Theory, Aural) in a 4-col responsive grid
4. **Stats Strip** — 4 metrics (20K+ Families · 4.7★ Rating · 15+ Years · 10+ Programmes)
5. **FAQ** — 3 Q&As using `<details>` accordion (schema + visible must match exactly)
6. **CTA Banner** — Book Trial Class button

### Branch-specific data (canonical, per Google Business Profile)

| Branch | Address | MRT | WhatsApp |
|---|---|---|---|
| Tengah | 127A Plantation Crescent, #01-381, S691127 | Future Tengah Plantation MRT (JRL 2028) | 8922 2848 |
| Bukit Batok (Le Quest) | 4 Bukit Batok St 41, **#01-83**, S657991 | Bukit Batok MRT (NS2) | 9627 7582 |
| Jurong West | Blk 492 Jurong West St 41, #01-10, S640492 | Lakeside MRT (EW26) | 9627 7588 |
| Tampines | Blk 139 Tampines St 11, #01-60, S521139 | Tampines West MRT (DT31) | 8892 1198 |

> Le Quest is **#01-83**, NOT `#01-K1` (corrected per Google Business Profile, May 17 2026). Any leftover `#01-K1` references on the site are stale.

### Branch-specific Studio Hours (each branch is different — DO NOT use generic "Daily 1pm-9pm")

| Branch | Mon-Fri | Sat | Sun | Wed |
|---|---|---|---|---|
| Tengah | 1pm-9pm | 9am-7:30pm | 9am-7:30pm | open |
| Bukit Batok | 1pm-9pm | 9am-8pm | 9:30am-7:30pm | open |
| Jurong West | 1pm-9pm | 9:30am-8:30pm | 9:30am-8:30pm | open |
| Tampines | 1pm-9pm (Mon/Tue/Thu/Fri only) | 9am-7pm | 9am-7pm | **CLOSED** |

> **Tampines Wednesday-closed handling:** in JSON-LD `openingHoursSpecification` array, OMIT Wednesday entirely (schema.org idiom for "closed"). On the visible Studio Hours block, render Wednesday line as `<strong style="color:var(--or)">Wed: Closed</strong>` — orange callout so visitors notice. FAQ Q2 must also call this out: *"Please note that our Tampines studio is closed on Wednesdays."*

### Active nav link rule
On location pages, the **Contact ▾** dropdown trigger should be considered the active nav item (no class change needed for the trigger; the dropdown items are sub-pages of Contact).

### Positioning rules (Tengah HQ vs other branches)
- **Tengah is the Flagship HQ** as of 2026. Use the phrases "flagship headquarters", "Flagship HQ", or "Tengah HQ" in copy.
- **Tengah's pill tag exception** — Art Bible §6 normally bans emojis in pill tags. Tengah's pill uses `📍 Flagship HQ · Liberal Tengah` as an explicit one-off exception per user spec.
- **Jurong West is NOT HQ** anymore. It's described as the "established cornerstone of Liberal Music & Arts School in the West" — not the headquarters.
- Never describe any other branch as HQ.

### Location page hero pills (current state)
| Branch | Pill text |
|---|---|
| Tengah | `📍 Flagship HQ · Liberal Tengah` (emoji exception) |
| Bukit Batok | `Liberal Bukit Batok Branch` |
| Jurong West | `Liberal Jurong West Branch` |
| Tampines | `Liberal Tampines Branch` |

### Adding a new location page
1. Copy `locations/tengah.html` → `locations/<new-branch>.html`
2. Swap branch-specific data (address, WhatsApp, MRT, hours, landmark mentions, Google Maps iframe `src`)
3. Update both JSON-LD blocks (`MusicSchool` name/address/geo/hours/sameAs + `FAQPage` matching the visible FAQ)
4. Update canonical link
5. Add an entry to the `Contact ▾` dropdown in nav (on `index.html` + all 4 existing location pages + propagate to other pages once site-wide dropdown sync is done)
6. Add a footer card (5th slot or extend grid)
7. Add a row to the WA FAB popup
8. Update `HOW-TO-START.md` file structure + file-table sections

### WhatsApp FAB on location pages — inline-styled variant
**The 4 location pages use a different FAB implementation than the rest of the site.** Instead of the class-based `.wa-fab` / `.wa-panel` (Section 7/8 of this guide), location pages use an inline-styled `#waWrap` component with `onclick` toggle. The two approaches are functionally identical but visually equivalent; the inline version is being used as the "new pattern" pending a future site-wide migration.

```html
<!-- Inline-styled FAB used on locations/*.html (alternative to Section 7/8) -->
<div id="waWrap" style="position:fixed;bottom:28px;right:28px;z-index:9999;isolation:isolate;">
  <div id="waPanel" style="display:none;position:absolute;bottom:68px;right:0;background:#fff;border-radius:16px;box-shadow:0 20px 56px rgba(31,42,68,.11);width:290px;padding:22px;border:1px solid #EEF2F8;">
    <h4 style="font-size:14.5px;font-weight:900;color:#1F2A44;margin-bottom:4px;">💬 Chat with Us!</h4>
    <p style="font-size:12.5px;color:#8FA2BC;margin-bottom:14px;">Pick your nearest branch to WhatsApp directly.</p>
    <!-- 5 anchor rows in order: Tengah · Tampines · Jurong West · Le Quest · Coloury Art -->
    <a href="https://wa.me/6589222848" target="_blank" rel="noopener" style="display:flex;justify-content:space-between;padding:11px 14px;border-radius:12px;background:#F8FBFF;border:1.5px solid #EEF2F8;margin-bottom:8px;font-weight:700;font-size:13.5px;color:#1F2A44;text-decoration:none;">🏡 Tengah <span style="font-size:11.5px;color:#8FA2BC;">8922 2848</span></a>
    <!-- ... 4 more rows ... -->
  </div>
  <button onclick="var p=document.getElementById('waPanel');p.style.display=p.style.display==='none'?'block':'none';" style="width:58px;height:58px;border-radius:50%;background:#25D366;color:#fff;border:none;cursor:pointer;box-shadow:0 8px 28px rgba(37,211,102,.42);display:flex;align-items:center;justify-content:center;padding:0;overflow:hidden;"><img src="../assets/whatsapp.webp" alt="WhatsApp" style="width:34px;height:34px;object-fit:contain;display:block;"/></button>
</div>
```

- No external CSS required (everything inline)
- No JavaScript file required (toggle is in `onclick` attribute)
- No outside-click-to-close behaviour — panel stays open until user re-clicks the button
- Both approaches end up with **the same 5 branches in the same order**: Tengah → Tampines → Jurong West → Le Quest → Coloury Art

---

## 12. QUICK CHECKLIST

Before finalising any page, verify:

- [ ] `Nunito + Quicksand` fonts imported in `<head>`
- [ ] `:root` CSS variables present and unmodified
- [ ] Announcement bar: `#f56c22`, SVG icon, correct trial link
- [ ] `<nav>` top: `36px` (shifted down by announcement bar)
- [ ] `<main>` padding-top: `108px`
- [ ] Nav logo height: `42px`, using `logo.webp` (never base64)
- [ ] Nav links font-size: `18px`, font-weight: `600`
- [ ] Nav link order: **Home | About | Courses | Instructors | Review | Blog | Contact**
- [ ] **Contact ▾ dropdown present in BOTH desktop nav AND mobile drawer** — `<li class="nav-item-dropdown">` (desktop) and `<div class="nav-item-dropdown">` (drawer). 4 submenu items in exact order: **Jurong West · Bukit Batok (Le Quest) · Tampines · Tengah (HQ) [NEW badge]**. Each item is `<li><a href="/locations/<branch>">…</a></li>` (canonical `<ul><li>` markup per Section 4). Section 4.5 dropdown CSS must also be present in `<style>`.
- [ ] **Active page styling on contact.html:** when the current page IS contact, mark the trigger with a SINGLE merged class attribute `class="dropdown-trigger active"`. Never write `class="active" class="dropdown-trigger"` — duplicate `class` attributes are ignored and silently break dropdown styling.
- [ ] **Orange keyword underline animation present** — Section 4.7 canonical CSS block (`.kw{... isolation:isolate}` + `.kw::after{... #8ddbd1 ... 0.95s forwards}` + `@keyframes kw`) is in `<style>`. The `isolation:isolate` declaration is **mandatory** — without it, the underline is invisible behind the page-hero gradient on most pages. Exactly **one** of each rule; delete any prefixed legacy variants like `.hero-headline .kw{...}`, `.trial-headline .kw{...}`, or `.page-hero h1 em{...}`.
- [ ] **Use `<span class="kw">` for the hero's keyword** — one keyword per headline, on a noun that carries the meaning. Never use `<em>` for this purpose.
- [ ] **Review link points to `review.html`** (NOT `testimonial.html` — deprecated)
- [ ] Active page has `class="active"` on its nav link (instructor profiles → active on Instructors)
- [ ] **中文 button:** ACTIVE only on root `index.html` (links to `index-zh.html`). Disabled `<span>` everywhere else — keep `opacity:0.35;cursor:not-allowed;pointer-events:none;` until that page's Chinese counterpart is built. See Section 14 for the active-state markup.
- [ ] Book Trial button: `class="btn btn-cta"` + `style="padding:10px 22px;font-size:14px;"`
- [ ] Mobile drawer font-size: `25.5px`
- [ ] Footer background: `#1F2A44`
- [ ] Footer logo: `logofooter.webp`, height `56px`
- [ ] Footer description text: `color:#fff` (solid white), `font-size:15px`
- [ ] **Footer description ends with `trusted by over 20,000 families in Singapore since 2009.`** Canonical copy: `Liberal Music & Arts School nurtures creativity, confidence, and a lifelong love of music and the arts — for ages 2.5 to adult. With expert teachers, holistic learning, and proven results, we are proud to be trusted by over 20,000 families in Singapore since 2009.` (April 27, 2026 update — replaced the older "Ages 2.5+ to Adult / 500 families since 2014" copy.)
- [ ] Social icons: `Instagram.webp` (26px), `facebook.webp`, `youtube.webp`, `xiaohongshu.webp` (22px each) — `filter:brightness(0) invert(1)`, no borders, no rounded box
- [ ] **Social link `href` values are wired to live URLs** (April 27, 2026 — was `href="#"` placeholders before): Instagram → `https://www.instagram.com/liberalmusic_arts/`, Facebook → `https://www.facebook.com/liberalmusicandarts/`, YouTube → `https://youtube.com/@liberalmusicartsschoolsingapor?si=0EdJLdRw-WoXKxOR`. Each carries `target="_blank" rel="noopener noreferrer"`. **Xiaohongshu still `href="#"`** until the URL is supplied.
- [ ] **`.foot-soc` has `padding-bottom:4px`**; `.foot-soc a` must NOT have `overflow:hidden` (otherwise icons render as solid white blocks)
- [ ] No `.foot-contact` email/phone block in footer (removed)
- [ ] All 5 locations listed with full names: "Tengah Music School", "Tampines Music School", etc.
- [ ] Location pin icons: `address.webp` with `filter:brightness(0) invert(1);opacity:.7`
- [ ] **5th location is Coloury Art By Liberal**: clickable `<a href="https://colouryart.com/" target="_blank" rel="noopener" class="foot-loc soon" style="text-decoration:none;display:grid;">`, pin = `✦`, title = `Coloury Art By Liberal`, subtitle line 1 = `#03-07C Level 3, Jurong Point` + `Singapore 648886`, meta line = `🚇 Near Boon Lay MRT · ✦ Opening Soon` (replaces the deprecated "Jurong Point Music School · Opening Soon" div, and also replaces the older `colouryart.com`-only subtitle from before April 28 2026)
- [ ] Footer navigation Review link also points to `review.html`
- [ ] Nav links in footer: `font-size:15px`, `color:#fff` — no "✦ Free Trial Class" item
- [ ] **Privacy Policy link** → `privacy` (from `pages/`) or `pages/privacy` (from root) or `../../pages/privacy` (from `pages/articles/`) — NEVER `#`, NEVER `.html`
- [ ] **Terms of Use link** → `terms` (from `pages/`) or `pages/terms` (from root) or `../../pages/terms` (from `pages/articles/`) — NEVER `#`, NEVER `.html`
- [ ] **中文版本 footer link:** ACTIVE only on root `index.html` (`<a href="index-zh.html" style="font-size:15px;color:rgba(255,255,255,.7);">中文版本</a>`). Disabled `<span>` everywhere else until that page's Chinese counterpart is built. See Section 14.
- [ ] Bottom bar includes `v1.0.1` version tag
- [ ] WA FAB present, uses `whatsapp.webp` image (NOT 💬 emoji), all 5 WhatsApp numbers correct (5-row popup: Tengah · Tampines · Jurong West · Le Quest · Coloury Art)
- [ ] Mobile sticky bar present with trial link
- [ ] All asset paths use `../assets/` for `pages/` files, `assets/` for root files
- [ ] **Section 4.6 Mobile/Landscape fixes block present** — drawer `max-height: calc(100dvh - 108px)` + `overflow-y:auto` + `padding-bottom: calc(40px + env(safe-area-inset-bottom, 0px))` + `.nav-drawer.on ~ #waWrap{display:none}`. Required on ALL pages (EN + ZH).
- [ ] **Homepage only (`index.html` / `index-zh.html`):** Section 4.6.2 hero video CSS (16:9 frame, force tap-to-play poster at <900px, hide `.fc-*` cards, landscape hero adaptations) + Section 4.6.3 `maxresdefault.jpg` poster img with `hqdefault.jpg` onerror fallback
- [ ] **Instructor profile pages only:** breadcrumb present · "Other Instructors" strip excludes self · book card says "Book Trial Class" (no "Free")

---

## 13. WHATSAPP NUMBERS (never change)

| Branch | Number | wa.me link |
|---|---|---|
| Tengah | +65 8922 2848 | `https://wa.me/6589222848` |
| Tampines | +65 8892 1198 | `https://wa.me/6588921198` |
| Jurong West | +65 9627 7588 | `https://wa.me/6596277588` |
| Le Quest | +65 9627 7582 | `https://wa.me/6596277582` |
| Coloury Art | +65 8995 1163 | `https://wa.me/6589951163` |

---

## 14. CHINESE VERSION (中文版) — STRINGS REFERENCE

> Source of truth: `pages-zh/cecily.html` (canonical ZH instructor template) + `locations-zh/tengah.html` (canonical ZH location template). Last updated: May 18, 2026 (r8 — full pages-zh/ instructor rollout + locations-zh/ 4 main branches).
>
> **Pattern:** the English markup in Sections 1–8 above is the structural canonical. For Chinese pages, keep the markup, CSS classes, asset paths, IDs, and JSON-LD schemas identical — only swap the visible strings per the tables below. This keeps a single structural source of truth and avoids drift between EN and ZH.
>
> **Current ZH coverage (May 18 2026):** `index-zh.html` (root), `pages-zh/<13 instructors>.html`, `pages-zh/privacy.html`, `pages-zh/terms.html`, `pages-zh/contact.html`, `pages-zh/articles/<2 articles>.html`, `locations-zh/<4 main branches>.html` = **22 ZH pages live**. Still pending: pages-zh main pages (about, courses, instructors, blog, review, trial), pages-zh course-detail pages, `locations-zh/coloury-art.html`.

### 14.0 Required Chinese font stack — `--zh` CSS variable (MANDATORY on every ZH page)

Every Chinese page must include the Noto Sans SC font import **plus** a `--zh` CSS variable injected into body and heading font stacks. Without this, Chinese glyphs fall back to system fonts and look noticeably different across browsers (especially Windows Chromium → DengXian vs Mac → PingFang SC).

**Font import — add to `<head>` (extends the EN canonical import):**
```html
<link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,400;0,600;0,700;0,800;0,900;1,800&family=Quicksand:wght@400;500;600;700&family=Noto+Sans+SC:wght@400;500;700;900&display=swap" rel="stylesheet"/>
```

**CSS variable — add to `:root` (typically right after `--or-shh`):**
```css
--zh: 'Noto Sans SC', 'PingFang SC', 'Microsoft YaHei', '微软雅黑', sans-serif;
```

**Font stacks — update body + h1–h4 to interleave `--zh` between the Latin font and the system fallback:**
```css
body{font-family:'Quicksand',var(--zh),system-ui,sans-serif;color:var(--body);background:var(--w);overflow-x:hidden;-webkit-font-smoothing:antialiased;line-height:1.65}
h1,h2,h3,h4{font-family:'Nunito',var(--zh),sans-serif;color:var(--ink);line-height:1.18;font-weight:900}
```

This positioning matters: Latin glyphs (`A-Z 0-9`) render Quicksand/Nunito, then CJK glyphs fall through to Noto Sans SC, then anything still unhandled hits the OS fallback. Reversed order (Noto first) would force Noto to render Latin too, breaking the brand typography.

### 14.1 `<html>` lang attribute and head meta

| Attribute | English page | Chinese page |
|---|---|---|
| `<html lang>` | `en` | `zh-CN` |
| `<title>` | `… \| Liberal Music & Arts School` | `… \| 博雅音乐艺术学校` |
| `<meta name="description">` | English copy | Localized Chinese copy |
| `<link rel="canonical">` | `https://liberalmusicschool.com/<slug>` | `https://liberalmusicschool.com/pages-zh/<slug>` *or* `https://liberalmusicschool.com/locations-zh/<slug>` |
| `<link rel="alternate" hreflang="en">` | `…/<slug>` (self link if no ZH counterpart yet) | `…/<en-slug>` (link to EN counterpart) |
| `<link rel="alternate" hreflang="zh-CN">` | `…/pages-zh/<slug>` or `…/locations-zh/<slug>` (link to ZH counterpart) | `…/pages-zh/<slug>` or `…/locations-zh/<slug>` (self link) |

**Brand name:** Liberal Music & Arts School → 博雅音乐艺术学校.

> **URL slugs stay English on both sides.** The Chinese mirror lives at `/pages-zh/<en-slug>` or `/locations-zh/<en-slug>` — the slug itself is never localised. This is because (a) slugs for the 4 main branches are Google Business Profile-registered and indexed, (b) crawlers handle a folder-prefix split (`/pages-zh/cecily` ↔ `/pages/cecily`) more reliably than a localised-slug split.
>
> **hreflang is bidirectional.** Both the EN page and the ZH page must declare both `hreflang="en"` and `hreflang="zh-CN"` alternates to be valid. Each side's `canonical` is its own URL; the alternates point at the other side. Missing the EN-side alternate is a common omission — sweep EN pages when adding a new ZH counterpart.

### 14.2 Path conventions for Chinese pages

| File location | Logo src | Asset prefix | Link to ZH sibling | Link to EN counterpart |
|---|---|---|---|---|
| Root (`index-zh.html`) | `assets/logo.webp` | `assets/` | `pages-zh/<slug>` or `locations-zh/<slug>` | `index.html` |
| Subfolder (`pages-zh/*.html`) | `../assets/logo.webp` | `../assets/` | `<slug>` (sibling) or `../locations-zh/<slug>` (across-folder) | `../pages/<slug>` |
| Subfolder (`locations-zh/*.html`) | `../assets/logo.webp` | `../assets/` | `../pages-zh/<slug>` (across-folder) or `<slug>` (sibling location) | `../locations/<slug>` |
| Sub-subfolder (`pages-zh/articles/*.html`) | `../../assets/logo.webp` | `../../assets/` | `../<slug>` (into pages-zh root) | `../../pages/articles/<slug>` |

> **Current state (May 18 2026):** all 4 path categories above are populated — root, pages-zh/, locations-zh/, pages-zh/articles/. Internal nav links on ZH pages now point to ZH counterparts where they exist (e.g. instructor pages link to other instructor pages via `../pages-zh/<name>`). Where no ZH counterpart exists yet (e.g. `pages-zh/about` doesn't exist), the link falls back to the EN page (`../pages/about`).
>
> **Dropdown URLs use absolute paths** — `/locations-zh/<branch>` on every ZH page, `/locations/<branch>` on every EN page. This is independent of which folder the page lives in (absolute paths work from any URL depth). The site-wide May 18 2026 ZH bulk fix migrated every ZH page's dropdown from `/locations/<branch>` → `/locations-zh/<branch>` now that all 4 ZH branches exist.

### 14.3 Announcement bar

| English | 中文 |
|---|---|
| `Liberal Music & Arts School — Book your FREE Trial Class today at any of our 5 Singapore locations!` | `博雅音乐艺术学校 — 立即在新加坡5个分校预约试课！` |

### 14.4 Navbar — link order is identical, only text swaps

| English label | 中文 label |
|---|---|
| Home | 首页 |
| About | 关于我们 |
| Courses | 课程 |
| Instructors | 导师 |
| Review | 评价 |
| Blog | 博客 |
| Contact | 联系我们 |
| Book Trial Class *(button)* | 预约试课 |

**Order is locked:** `首页 | 关于我们 | 课程 | 导师 | 评价 | 博客 | 联系我们` — never change.

### 14.4.1 Contact ▾ dropdown — Chinese version (REQUIRED on every ZH page)

The Contact dropdown structure from Section 4 carries over to Chinese pages identically — same HTML markup, same CSS (4.5), same `.badge-new` chip. **Only the visible labels and dropdown URLs change.** Numbers stay in English (these would be wa.me numbers if they were links), and **URL slugs stay in English** (these are GBP-registered + indexed). What differs from EN: the dropdown items point to **`/locations-zh/<en-slug>`** (the Chinese branch pages) so ZH users stay inside the Chinese navigation.

| English dropdown item | 中文 dropdown item | Dropdown URL |
|---|---|---|
| `Contact ▾` (trigger) | `联系我们 ▾` | (trigger only, no destination) |
| `Jurong West` | `裕廊西` | `/locations-zh/jurong-west` |
| `Bukit Batok (Le Quest)` | `武吉巴督 (Le Quest)` | `/locations-zh/bukit-batok` |
| `Tampines` | `淡滨尼` | `/locations-zh/tampines` |
| `Tengah (HQ) New` | `登加 (旗舰总部) New` | `/locations-zh/tengah` |

> The `Le Quest` brand name and the `New` badge text remain in English — `Le Quest` is the mall's actual name, and `New` is a short visual chip whose meaning is universal.
>
> **URL slug stays English** even on Chinese pages — `/locations-zh/jurong-west`, not `/locations-zh/裕廊西`. The folder prefix `/locations-zh/` does the language switch; the slug itself is GBP-registered + indexed, never localised.

Example desktop nav `<li>` on a Chinese page:

```html
<li class="nav-item-dropdown">
  <a href="../pages-zh/contact" class="dropdown-trigger">联系我们 <span class="arrow" aria-hidden="true">▾</span></a>
  <ul class="dropdown-menu">
    <li><a href="/locations-zh/jurong-west">裕廊西</a></li>
    <li><a href="/locations-zh/bukit-batok">武吉巴督 (Le Quest)</a></li>
    <li><a href="/locations-zh/tampines">淡滨尼</a></li>
    <li><a href="/locations-zh/tengah">登加 (旗舰总部) <span class="badge-new">New</span></a></li>
  </ul>
</li>
```

> **History — May 18 2026 bulk URL fix:** earlier ZH pages (built before all 4 ZH branches existed) had dropdown items pointing to `/locations/<en-slug>` as a fallback, sending ZH users back to the English branch pages. After all 4 `locations-zh/` pages were built, a PowerShell bulk-replace updated every ZH page's dropdown to `/locations-zh/<en-slug>`. The pattern `"/locations/<slug>"` (quote-prefixed absolute path) was deliberately chosen because relative paths `"../locations/<slug>"` (used for EN-toggle buttons and footer English links) are protected — the leading `..` before `/locations/` means the quote-prefixed pattern doesn't match them. See HOW-TO-START.md "PAGE-SPECIFIC NOTES (May 18, 2026 session)" §D for the full PowerShell script.

### 14.5 Language toggle — direction reverses on Chinese pages, points to per-page counterpart

```html
<!-- On English pages → toggle says 中文, links to ZH counterpart -->
<!-- Root: links to ZH homepage -->
<a class="nav-lang" href="index-zh">中文</a>
<!-- Instructor / location / course / article pages: links to ZH counterpart of THIS page -->
<a class="nav-lang" href="../pages-zh/cecily">中文</a>           <!-- on pages/cecily.html -->
<a class="nav-lang" href="../locations-zh/tengah">中文</a>       <!-- on locations/tengah.html -->

<!-- On Chinese pages → toggle says EN, links back to EN counterpart of THIS page -->
<!-- Root: links to EN homepage -->
<a class="nav-lang" href="index" style="text-decoration:none;color:var(--ink);font-weight:700;">EN</a>
<!-- Instructor / location / course / article pages: links to EN counterpart of THIS page -->
<a class="nav-lang" href="../pages/cecily" style="text-decoration:none;color:var(--ink);font-weight:700;">EN</a>       <!-- on pages-zh/cecily.html -->
<a class="nav-lang" href="../locations/tengah" style="text-decoration:none;color:var(--ink);font-weight:700;">EN</a>  <!-- on locations-zh/tengah.html -->
```

The same reversal applies in the footer bottom bar (`中文版本` ↔ `English`) and the mobile drawer (where the toggle sits as a low-opacity row above the CTA button).

> **Per-page counterpart rule (May 18 2026):** the toggle should **always** drop the user on the same page in the other language, not on the homepage. A user reading about Ms Cheng wants to continue reading about Ms Cheng — not be dumped back at the homepage.
>
> **Bidirectional pairing rule (May 19 2026):** every time you ship a new `pages-zh/<slug>.html` or `locations-zh/<slug>.html`, you **must** simultaneously activate the 中文 toggle in 4 spots on the matching EN page (`pages/<slug>.html` or `locations/<slug>.html`) — head hreflang, desktop nav, mobile drawer, footer. **See §14.17 for the exact 4-spot pattern with copy-paste snippets.** Skipping this means the ZH page exists but Chinese-curious EN visitors can't discover it: the 中文 button stays disabled-grey and routes nowhere. This is a routine omission — bake it into the build checklist (§14.14 step 15).
>
> **Current pairing status (May 19 2026):**
> - ✅ All 13 EN instructor pages — 中文 toggle active to ZH counterpart
> - ✅ All 12 EN course-detail pages — 中文 toggle active (10 currently point to ZH pages that don't exist yet → temporary 404 until ZH pages built)
> - ❌ 4 EN location pages — toggle still disabled-grey
> - ❌ 6 EN main pages (about, courses, instructors, blog, review, trial) — ZH counterparts don't exist yet, toggle correctly disabled
> - ✅ Root `index.html` ↔ `index-zh.html` — bidirectionally paired

### 14.6 Mobile drawer — Chinese version

```html
<nav class="nav-drawer" id="navDrawer" aria-label="移动端导航">
  <a href="../index-zh.html">首页</a>
  <a href="../pages-zh/about">关于我们</a>
  <a href="../pages-zh/courses">课程</a>
  <a href="../pages-zh/instructors">导师</a>
  <a href="../pages-zh/review">评价</a>
  <a href="../pages-zh/blog">博客</a>

  <!-- Contact dropdown — flat (always expanded) in drawer. Same markup as Section 4. -->
  <div class="nav-item-dropdown">
    <a href="../pages-zh/contact" class="dropdown-trigger" style="padding-left:0;">联系我们 <span class="arrow">▾</span></a>
    <ul class="dropdown-menu">
      <li><a href="/locations-zh/jurong-west">裕廊西</a></li>
      <li><a href="/locations-zh/bukit-batok">武吉巴督 (Le Quest)</a></li>
      <li><a href="/locations-zh/tampines">淡滨尼</a></li>
      <li><a href="/locations-zh/tengah">登加 (旗舰总部) <span class="badge-new">New</span></a></li>
    </ul>
  </div>

  <!-- EN toggle — links to per-page counterpart, NOT homepage. Adjust per page. -->
  <a href="../pages/cecily" style="background:var(--s2);text-align:center;font-weight:700;color:var(--muted);font-size:15px;margin-top:8px;">EN · English Version</a>
  <a href="../pages-zh/trial" class="btn btn-cta">预约试课</a>
</nav>
```

> **Drawer `aria-label`:** EN side uses `Mobile navigation`; ZH side uses `移动端导航`.
> **Hamburger button `aria-label`:** EN side uses `Menu`; ZH side uses `菜单`.

### 14.7 Footer — column headings

| English `<h5>` | 中文 `<h5>` |
|---|---|
| `Navigation` | `网站导航` |
| `Our Locations` | `我们的分校` |

### 14.8 Footer — brand paragraph

```text
博雅音乐艺术学校致力于培养孩子的创造力、自信心，以及对音乐与艺术的终生热爱——服务2.5岁至成人各年龄段。我们拥有专业师资、全人教育的理念与可见的教学成果，自2009年起，已荣幸地获得新加坡20,000+家庭的信赖。
```

### 14.9 Footer — locations (all 5)

| Branch (EN `<strong>`) | Branch (中文 `<strong>`) | Address line | MRT meta line |
|---|---|---|---|
| Tengah Music School | 登加（Tengah）分校 | unchanged | 邻近未来裕廊区域地铁线（2028年开通）`·` 🕐 每日1点-9点 |
| Tampines Music School | 淡滨尼（Tampines）分校 | unchanged | 邻近淡滨尼西地铁站（Tampines West MRT）`·` 🕐 每日1点-9点 |
| Jurong West Music School | 裕廊西（Jurong West）分校 | unchanged | 邻近 Lakeside 地铁站 `·` 🕐 每日1点-9点 |
| Le Quest Mall Music School | Le Quest 商场分校 | unchanged | 邻近武吉巴督地铁站（Bukit Batok MRT）`·` 🕐 每日1点-9点 |
| Coloury Art By Liberal | Coloury Art By Liberal（裕廊坊） | unchanged | 邻近文礼地铁站（Boon Lay MRT）`·` ✦ 即将开业 |

> **Address lines stay in English** — postal addresses are easier to navigate to via Google Maps in their original form. Only the branch heading (the `<strong>`) and the `.foot-loc-meta` line are localized.

### 14.10 Footer — bottom bar

| English | 中文 |
|---|---|
| `© 2025 Liberal Music & Arts School. All rights reserved.` | `© 2025 博雅音乐艺术学校 版权所有` |
| `Privacy Policy` | `隐私政策` |
| `Terms of Use` | `使用条款` |
| `中文版本` *(toggle)* | `English` *(toggle, links to `index`)* |

### 14.11 WhatsApp FAB popup

```html
<h4 style="font-size:14.5px;font-weight:900;color:#1F2A44;margin-bottom:4px;">💬 与我们联系！</h4>
<p style="font-size:12.5px;color:#8FA2BC;margin-bottom:14px;">选择就近分校，直接通过 WhatsApp 联系我们。</p>
<!-- Then the 5 wa-row anchors with these labels (numbers and wa.me links unchanged): -->
🏡 登加 <span>8922 2848</span>
🌅 淡滨尼 <span>8892 1198</span>
🌸 裕廊西 <span>9627 7588</span>
🏬 Le Quest <span>9627 7582</span>
✦ Coloury Art <span>8995 1163</span>
```

> **Le Quest** and **Coloury Art** keep their English names — they are mall/shop brand names, not branch descriptors.

### 14.12 Mobile sticky CTA bar

| English | 中文 |
|---|---|
| `✦ Book Free Trial Class` | `✦ 预约试课` *(or `✦ 免费预约试课` if you want to keep "Free")* |

### 14.13 What stays in English on Chinese pages

These should NOT be translated, even on Chinese pages:

- **JSON-LD schemas on `pages-zh/*` (instructor + legal + article pages)** — kept verbatim from EN. Search engines and AI scrapers index these primarily in English; translating them loses AEO coverage and risks "duplicate object" warnings in Google Search Console.
- **JSON-LD schemas on `locations-zh/*` are PARTIALLY translated** — see §14.16 for the rule (MusicSchool name is bilingual, FAQPage Q&A is fully translated to Chinese, structural fields stay English).
- **Brand names:** Liberal Music & Arts School, Coloury Art By Liberal, Le Quest, ABRSM, Trinity College London, RAD, MRT station English names (used in parentheses alongside the Chinese name on first occurrence).
- **CSS class names, IDs, ARIA labels (except mobile-drawer + hamburger aria-labels), asset filenames, `data-*` attributes** — purely structural.
- **Postal addresses** (e.g. `127A Plantation Crescent, #01-381 Singapore 691127`) — keep raw so users can paste into Google Maps.
- **WhatsApp numbers and `wa.me` links** — same numbers, same links, only the row label is localized.
- **URL slugs** — `/locations-zh/<en-slug>` and `/pages-zh/<en-slug>` always use the EN slug. Never localise slugs (GBP-registered + indexed).

### 14.14 Building a new Chinese page — checklist

When you're ready to build out `pages-zh/about.html`, `pages-zh/courses.html`, etc., follow this delta from the English template:

1. Copy the English page (e.g. `pages/about.html`) → save as `pages-zh/about.html`.
2. Change `<html lang="en">` → `<html lang="zh-CN">`.
3. Update `<title>`, `<meta name="description">`, `<link rel="canonical">` per Section 14.1. Add bidirectional `<link rel="alternate" hreflang="en">` + `<link rel="alternate" hreflang="zh-CN">`.
4. **Add Noto Sans SC font import** to the existing Google Fonts URL per §14.0 — `&family=Noto+Sans+SC:wght@400;500;700;900` appended.
5. **Add `--zh` CSS variable** to `:root` and inject it into body + h1–h4 font stacks per §14.0.
6. Swap announcement bar string per Section 14.3.
7. Swap nav link labels per Section 14.4. **Update href to point to ZH counterparts** — e.g. `../pages-zh/about`. Where no ZH counterpart exists, fall back to `../pages/about` (EN).
8. **Flip language toggle to per-page EN counterpart** per Section 14.5 — never homepage hop. `<a href="../pages/cecily">EN</a>` on `pages-zh/cecily.html`, etc.
9. Mobile drawer: localize labels, flip the language toggle, keep all hrefs in sync with step 7. Update `aria-label` to `移动端导航`. Hamburger button `aria-label` becomes `菜单`.
10. **Contact ▾ dropdown — REQUIRED in both desktop nav AND mobile drawer.** Use the localized labels AND `/locations-zh/<en-slug>` URLs per Section 14.4.1. Slugs stay English. Section 4.5 CSS must be present in `<style>` — it's structural, copy verbatim from the EN page.
11. Footer: localize column headings (Section 14.7), brand paragraph (14.8), all 5 location headings + meta lines (14.9), bottom bar (14.10). Footer English-link toggle uses `../pages/<slug>` or `../locations/<slug>` (per-page EN counterpart).
12. WhatsApp FAB: localize panel headline, intro, and the 5 row labels (Section 14.11). Numbers and `wa.me` links must NOT change. Button `aria-label` becomes `打开 WhatsApp`.
13. Page body content: localize section headings, lead paragraphs, FAQ Q&As, CTAs. Keep brand terms in English per Section 14.13.
14. **JSON-LD strategy depends on page type:**
   - `pages-zh/<instructor>.html` / `pages-zh/<article>.html` / `pages-zh/<legal>.html` → keep JSON-LD verbatim from EN page.
   - `locations-zh/<branch>.html` → **partially translate** per §14.16: MusicSchool `name` becomes bilingual, FAQPage fully translated, address + structural fields kept English.
15. **Mobile/Landscape responsive fixes (Section 4.6) — required on every ZH page.** The CSS is **fully structural and contains zero strings**, so it copies verbatim from the English page. Required selectors: `.nav-drawer{max-height:calc(100dvh - 108px); overflow-y:auto; padding-bottom:calc(40px + env(safe-area-inset-bottom, 0px))}` + `.nav-drawer.on ~ #waWrap, .wa, .mob-bar{display:none}`. On `index-zh.html` only, also include the hero video block (Section 4.6.2) — the poster `<img alt>` is the one piece that gets localized (`视频预览` instead of `Video preview`).
16. **🔁 SYNC EN-SIDE 中文 TOGGLE (CRITICAL — easy to forget).** The moment a `pages-zh/<slug>.html` or `locations-zh/<slug>.html` is committed, **immediately edit the matching `pages/<slug>.html` or `locations/<slug>.html` in 4 spots** to activate its 中文 toggle. Without this step, Chinese-curious visitors on the EN page see a disabled-grey 中文 button and never discover the ZH version exists. **See §14.17 for the exact 4-spot pattern with copy-paste snippets.** Mark this as DONE in the same git commit as the ZH page; do not split.

### 14.15 Verification markers (use in PowerShell verify-before-push)

When pushing Chinese-page edits, use distinctive Chinese strings as verification markers — they cannot collide with English-page content:

| Edit type | Suggested marker |
|---|---|
| Footer locations update | `每日 1 点-9 点` |
| Brand paragraph rewrite | `博雅音乐艺术学校致力于培养孩子的创造力` |
| FAQ rewrite | `加速学习路径` (or another distinctive ZH phrase) |
| WhatsApp panel rewrite | `选择就近分校` |
| Instructor ZH page (any of 13) | `加入 20,000+ 个信赖博雅音乐艺术学校的家庭` (book card subtitle) |
| Location ZH page (specific) | branch-unique phrase — see HOW-TO-START.md "PAGE-SPECIFIC NOTES May 18 2026 session" §E |

### 14.16 LOCATION-ZH PAGE PATTERN (`locations-zh/*.html` — added May 18 2026)

Chinese mirror of the EN location page pattern (§11.5). Same structural skeleton, same 6-section page order, same canonical template (`locations-zh/tengah.html` mirrors `locations/tengah.html`). What differs from §11.5: JSON-LD partial translation, bidirectional hreflang, all internal hrefs point to ZH counterparts.

#### File locations
| File | Branch | URL | EN counterpart |
|---|---|---|---|
| `locations-zh/tengah.html` | 登加 (Tengah · 旗舰总部) | `/locations-zh/tengah` | `/locations/tengah` |
| `locations-zh/bukit-batok.html` | 武吉巴督 (Bukit Batok · Le Quest) | `/locations-zh/bukit-batok` | `/locations/bukit-batok` |
| `locations-zh/jurong-west.html` | 裕廊西 (Jurong West) | `/locations-zh/jurong-west` | `/locations/jurong-west` |
| `locations-zh/tampines.html` | 淡滨尼 (Tampines · Wed closed) | `/locations-zh/tampines` | `/locations/tampines` |
| `locations-zh/coloury-art.html` | *(pending — EN side is `Opening Soon`)* | `/locations-zh/coloury-art` | `/locations/coloury-art` |

#### Canonical template
**`locations-zh/tengah.html` is the canonical ZH template.** When adding a 5th ZH location (e.g. `locations-zh/coloury-art.html`), clone Tengah ZH and swap branch-specific data.

#### Path conventions inside a `locations-zh/*.html` file

| Item | Path used | Why |
|---|---|---|
| Asset (logo, icon, image) | `../assets/<file>` | locations-zh/ one level deep, same as locations/ |
| ZH internal page link (e.g. trial, contact, instructor) | `../pages-zh/<slug>` | go up one, into pages-zh/ |
| Index | `../index-zh.html` | go up one |
| Dropdown menu items (other ZH branches) | `/locations-zh/<branch>` | absolute paths (work from any URL depth) |
| **EN counterpart toggle button** | `../locations/<en-slug>` | per-page counterpart, NOT homepage |
| Privacy / Terms in footer | `../pages-zh/privacy`, `../pages-zh/terms` | one up, into pages-zh |

#### Required `<head>` items
- `<title>` — pattern: `<Branch> 最优音乐学校 | <Optional sub-tag> | 博雅音乐艺术学校`
- `<link rel="canonical" href="https://liberalmusicschool.com/locations-zh/<en-slug>">`
- `<link rel="alternate" hreflang="en" href="https://liberalmusicschool.com/locations/<en-slug>">`
- `<link rel="alternate" hreflang="zh-CN" href="https://liberalmusicschool.com/locations-zh/<en-slug>">`
- Both JSON-LD blocks (see "JSON-LD strategy" below)
- Noto Sans SC font import + `--zh` CSS var per §14.0

#### JSON-LD strategy on location-zh pages (different from instructor pages!)

This is the key delta vs `pages-zh/<instructor>.html` (which keeps JSON-LD verbatim from EN). On location pages, the schemas are **partially translated** to drive Chinese-language Google rich results:

**`@type: "MusicSchool"`** — the canonical pattern:
```json
{
  "@context": "https://schema.org",
  "@type": "MusicSchool",
  "name": "博雅音乐艺术学校 (登加旗舰总部) · Liberal Music & Arts School (Tengah Flagship HQ)",
  "image": "https://liberalmusicschool.com/assets/logo.webp",
  "@id": "https://liberalmusicschool.com/locations-zh/tengah",
  "url": "https://liberalmusicschool.com/locations-zh/tengah",
  "telephone": "+6589222848",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "127A Plantation Crescent, #01-381",
    "addressLocality": "Singapore",
    "postalCode": "691127",
    "addressCountry": "SG"
  },
  "openingHoursSpecification": [ /* same as EN — pure structural data */ ]
}
```

- `name` → **bilingual** `"<中文> · <English>"` — gives the entity both Chinese discoverability AND backward-compat for English crawlers
- `@id` + `url` → point to the **ZH URL** (`/locations-zh/<slug>`)
- `address` block → **stays English** (postal addresses must be Google-Maps-parseable; localizing them breaks the maps lookup)
- `openingHoursSpecification` → unchanged (pure structural data, no strings)
- `telephone` → unchanged (same number across both languages)

**`@type: "FAQPage"`** — Questions + Answers **fully translated to Chinese**:
```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "登加 BTO 组屋区附近有音乐学校吗？",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "有的！博雅音乐艺术学校将其全新的旗舰总部设立在了..."
      }
    }
    /* ...remaining Q&As same structure... */
  ]
}
```

- Question `name` + Answer `text` → **fully translated** — these surface as rich snippets in Chinese Google
- Visible FAQ accordion text must match the schema text exactly (auditors check this)

#### Branch-specific Chinese data (per branch)

| Branch | Pill kicker | h1 | Sub-headline pattern |
|---|---|---|---|
| Tengah | `📍 旗舰总校 · 博雅登加校区` (emoji exception preserved) | `登加音乐学校` | mentions `森林市镇`, `BTO 预购组屋` |
| Bukit Batok | `博雅武吉巴督校区` | `武吉巴督音乐学校` | mentions Le Quest mall, FairPrice Finest + 麦当劳 |
| Jurong West | `博雅裕廊西校区` | `裕廊西音乐学校` | mentions Lakeside MRT, 西部基石 |
| Tampines | `博雅淡滨尼校区` | `淡滨尼音乐学校` | mentions 淡滨尼圆巴刹, Tampines West MRT |

#### Tengah CTA exception — `登加总校` is CORRECT, not a typo
- On the **other 3** branch pages, the bottom CTA banner phrase "Book a trial class at our Tengah branch" (a template-copy artefact from the EN source) was fixed to a **generic** `预约我们校区的试课` ("at our branch").
- On the **Tengah page itself**, `登加总校` is correct — we're literally on the Tengah branch — so the CTA reads `预约我们登加总校的试课——无需任何绑定承诺。`

#### Tengah hero kicker — 📍 emoji exception preserved
Art Bible §6 normally bans emojis in pill tags. Tengah's pill kicker `📍 旗舰总校 · 博雅登加校区` is the same one-off exception as the EN page (§11.5 Positioning rules) — preserved when translating.

#### Tampines Wednesday-closed handling — same dual-system pattern as EN
- Visible Studio Hours block: `<strong style="color:var(--or)">周三：休息</strong>` (orange callout)
- JSON-LD `openingHoursSpecification` array: Wednesday **omitted entirely** from any `dayOfWeek` array (schema.org idiom for "closed that day")
- FAQ Q2 explicitly mentions `请注意，我们的淡滨尼工作室周三休息。` — schema + visible must match exactly

#### SG Chinese place name translations (canonical — used across all ZH location pages)
See HOW-TO-START.md "PAGE-SPECIFIC NOTES (May 18 2026 session)" §C for the full table — covers MRT station names, mall/landmark names, official town/town-feature naming (森林市镇, 巴刹, 建屋局/HDB, BTO 预购组屋, etc.).

#### Adding a new location-zh page
1. Copy `locations-zh/tengah.html` → `locations-zh/<new-en-slug>.html` (slug stays English)
2. Build the matching EN page first (or in parallel) at `locations/<en-slug>.html`
3. Swap branch-specific data per the tables above
4. Update both JSON-LD blocks (MusicSchool bilingual name + FAQPage fully Chinese)
5. Update canonical link + bidirectional hreflang alternates
6. Add an entry to the Contact ▾ dropdown on ALL ZH pages (and the EN dropdown gets a parallel entry on all EN pages)
7. Add a footer card (5th slot or extend grid)
8. Add a row to the WA FAB popup
9. Update HOW-TO-START.md file structure + file-table sections

### 14.17 ACTIVATING THE 中文 TOGGLE ON AN EN PAGE (added May 19 2026)

When you ship a new `pages-zh/<slug>.html` (or `locations-zh/<slug>.html`), the EN counterpart's 中文 button is still in its default disabled-grey state. To activate it, edit the matching `pages/<slug>.html` (or `locations/<slug>.html`) in **exactly 4 spots**. This section is the canonical reference for that activation — paste in the snippets, swap the slug, push.

> **Why this is its own section:** the EN-side activation is **not** a one-line nav-href change — it's 4 coordinated edits (head meta, desktop nav, mobile drawer, footer), and skipping any of them leaves the toggle partially broken (e.g. works on desktop but disabled on mobile, or hreflang missing so Chinese-locale Google never sees the ZH page). It's also the step that's easiest to forget because it's on the EN side while you're focused on the ZH page. Hence the dedicated checklist entry (§14.14 step 16) and the worked snippets below.

#### The 4-spot pattern

Throughout the snippets, `<slug>` is the EN slug (always English, never localized — see §14.1) of the page you just shipped a ZH version for. E.g. `cecily`, `ballet-course`, `tengah`.

##### Spot 1 — `<head>`: add bidirectional `hreflang` alternates

Find:
```html
<link rel="canonical" href="https://liberalmusicschool.com/pages/<slug>"/>
```

Replace with:
```html
<link rel="canonical" href="https://liberalmusicschool.com/pages/<slug>"/>
<link rel="alternate" hreflang="en" href="https://liberalmusicschool.com/pages/<slug>"/>
<link rel="alternate" hreflang="zh-CN" href="https://liberalmusicschool.com/pages-zh/<slug>"/>
```

> For location pages, swap `/pages/` → `/locations/` and `/pages-zh/` → `/locations-zh/` in all three lines.

##### Spot 2 — Desktop nav: activate the 中文 toggle

Find the disabled `<span>` (this is the default state on every EN page that lacks a ZH counterpart):
```html
<span class="nav-lang" style="opacity:0.35;cursor:not-allowed;pointer-events:none;">中文</span>
```

Replace with the active `<a>`:
```html
<a class="nav-lang" href="../pages-zh/<slug>">中文</a>
```

> The `.nav-lang` class brings the active-state styling (orange hover border, pointer cursor) for free — no inline style needed.

##### Spot 3 — Mobile drawer: insert a 中文 link above the trial CTA

Find the drawer's closing pattern (this is where the dropdown ends and the CTA begins — unique in the file):
```html
  </div>
    <a href="trial" class="btn btn-cta">Book Trial Class</a>
  </nav>
```

Replace with (inserting a new `<a>` line between):
```html
  </div>
    <a href="../pages-zh/<slug>" style="background:var(--s2);text-align:center;font-weight:700;color:var(--muted);font-size:15px;margin-top:8px;">中文 · Chinese Version</a>
    <a href="trial" class="btn btn-cta">Book Trial Class</a>
  </nav>
```

> This is the mirror of the EN toggle on ZH pages (`<a href="../pages/<slug>">EN · English Version</a>`) — same `background:var(--s2)` muted-pill styling.
>
> For the article-page sub-subfolder (`pages/articles/<slug>.html` → ZH at `pages-zh/articles/<slug>.html`), the href becomes `../../pages-zh/articles/<slug>` (one extra `../`).

##### Spot 4 — Footer bottom bar: activate 中文版本

Find the disabled `<span>`:
```html
<span style="font-size:15px;color:rgba(255,255,255,.15);cursor:not-allowed;">中文版本</span>
```

Replace with the active `<a>`:
```html
<a href="../pages-zh/<slug>" style="font-size:15px;color:rgba(255,255,255,.7);">中文版本</a>
```

> The visible difference: opacity bumps from `.15` (effectively invisible) to `.7` (a normal muted footer link), and `cursor:not-allowed` disappears so the pointer changes on hover.

#### Path conventions by EN page location

| EN page file location | `<a href="...">` for spots 2/3/4 |
|---|---|
| `pages/<slug>.html` | `../pages-zh/<slug>` |
| `pages/articles/<slug>.html` | `../../pages-zh/articles/<slug>` |
| `locations/<slug>.html` | `../locations-zh/<slug>` |
| Root `index.html` | `index-zh` (no `../`) |

#### Bulk script (PowerShell — for batch activation when many ZH pages ship at once)

When you've shipped many ZH pages in one go (e.g. all 13 instructors May 18, all 12 courses May 19), don't hand-edit 13×4 = 52 spots. Use this Python pattern (Git Bash also works):

```python
import os, shutil

SLUGS = ['cecily', 'calvin', 'kate', 'jescelyn', 'tina', 'verginia', 'cheng',
         'aliona', 'teresa', 'jiang', 'mindy', 'leonard', 'loy']

for slug in SLUGS:
    path = f'pages/{slug}.html'
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Spot 1: head hreflang
    canonical = f'<link rel="canonical" href="https://liberalmusicschool.com/pages/{slug}"/>'
    if canonical in content and 'hreflang="zh-CN"' not in content:
        content = content.replace(canonical, canonical + '\n' +
            f'  <link rel="alternate" hreflang="en" href="https://liberalmusicschool.com/pages/{slug}"/>\n' +
            f'  <link rel="alternate" hreflang="zh-CN" href="https://liberalmusicschool.com/pages-zh/{slug}"/>')

    # Spot 2: desktop nav
    content = content.replace(
        '<span class="nav-lang" style="opacity:0.35;cursor:not-allowed;pointer-events:none;">中文</span>',
        f'<a class="nav-lang" href="../pages-zh/{slug}">中文</a>')

    # Spot 3: mobile drawer (use unique context to avoid matching other Book-Trial buttons)
    old_drawer = '  </div>\n    <a href="trial" class="btn btn-cta">Book Trial Class</a>\n  </nav>'
    new_drawer = (f'  </div>\n'
                  f'    <a href="../pages-zh/{slug}" style="background:var(--s2);text-align:center;font-weight:700;color:var(--muted);font-size:15px;margin-top:8px;">中文 · Chinese Version</a>\n'
                  f'    <a href="trial" class="btn btn-cta">Book Trial Class</a>\n'
                  f'  </nav>')
    if old_drawer in content and '中文 · Chinese Version' not in content:
        content = content.replace(old_drawer, new_drawer)

    # Spot 4: footer
    content = content.replace(
        '<span style="font-size:15px;color:rgba(255,255,255,.15);cursor:not-allowed;">中文版本</span>',
        f'<a href="../pages-zh/{slug}" style="font-size:15px;color:rgba(255,255,255,.7);">中文版本</a>')

    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)
```

The script is **idempotent** — checking `'hreflang="zh-CN"' not in content` and `'中文 · Chinese Version' not in content` before inserting means it's safe to re-run if a partial activation already happened.

#### Verification markers

After activation, each EN page should have **4 occurrences** of `pages-zh/<slug>` (or `locations-zh/<slug>`):
1. `hreflang="zh-CN" href=".../pages-zh/<slug>"` in head
2. `class="nav-lang" href="../pages-zh/<slug>"` in desktop nav
3. `href="../pages-zh/<slug>" style="background:var(--s2)..."` in mobile drawer
4. `href="../pages-zh/<slug>" style="font-size:15px;color:rgba(255,255,255,.7)..."` in footer

And **0 occurrences** of either:
- `opacity:0.35;cursor:not-allowed;pointer-events:none;">中文</span>` (disabled desktop state)
- `cursor:not-allowed;">中文版本</span>` (disabled footer state)

PowerShell one-liner for a batch:
```powershell
foreach ($slug in @('cecily','calvin','kate','jescelyn','tina','verginia','cheng','aliona','teresa','jiang','mindy','leonard','loy')) {
  $c = (Get-Content "pages/$slug.html" -Raw)
  $expected = ([regex]::Matches($c, [regex]::Escape("pages-zh/$slug"))).Count
  $stale = ([regex]::Matches($c, 'cursor:not-allowed;">中文')).Count
  $ok = if ($expected -ge 4 -and $stale -eq 0) { '✓' } else { '✗' }
  Write-Host "$ok $slug · paths=$expected · stale=$stale"
}
```

#### When NOT to apply this pattern

The EN-side 中文 toggle stays **disabled-grey** in these cases:

- **The ZH counterpart doesn't exist yet** — clicking 中文 would 404. Leave the disabled `<span>` in place until you ship the ZH page; then activate in the same commit per §14.14 step 16.
  - *Exception:* on a page in active build-out (e.g. the May 19 2026 course-page batch), it's acceptable to pre-activate all 12 EN course toggles to the future ZH slugs even though 10 of them temporarily 404 — this preserves the bidirectional pairing convention and the activation snaps into working order the moment each ZH page lands. Document this temporary state in the commit message ("ZH PENDING — toggles point to future ZH slugs").
- **The page has no ZH counterpart planned** (legacy redirect targets, internal-only tools). Leave disabled.

#### Historical context

Before May 19 2026, every EN page in the repo (40+ files) had the disabled-grey `<span>` regardless of whether its ZH counterpart existed. The ZH side was correctly wired (per-page EN counterpart), but the EN→ZH direction was a dead end on every page. This was [HOW-TO-START.md pending item #10](../HOW-TO-START.md). The May 19 2026 sweep resolved this for:
- All 13 EN instructor pages (`pages/cecily.html` through `pages/loy.html`)
- All 12 EN course-detail pages (`pages/ballet-course.html` through `pages/aural-training.html`)
- *Remaining pending:* 4 EN location pages (`locations/tengah.html`, etc.) — same pattern applies, just swap `pages/` → `locations/` and `pages-zh/` → `locations-zh/`.

---
