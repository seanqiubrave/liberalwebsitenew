# Liberal Music & Arts — Header & Footer Reference Guide
> Source of truth: `index.html` (master) · Last updated: April 27, 2026  
> Apply this guide to **every** page. No deviations.

---

## ⚠️ PATH RULES (CRITICAL)

| File location | Logo src | Asset prefix | Link prefix |
|---|---|---|---|
| Root (`index.html`, `index-zh.html`) | `assets/logo.webp` | `assets/` | `pages/` |
| Subfolder (`pages/*.html`) | `../assets/logo.webp` | `../assets/` | *(relative, no prefix)* |
| Subfolder (`locations/*.html`) | `../assets/logo.webp` | `../assets/` | *(relative, no prefix; `pages/` items: `../pages/<file>`)* |
| Sub-subfolder (`pages/articles/*.html`) | `../../assets/logo.webp` | `../../assets/` | `../<file>` |

> All examples below use `pages/` subfolder paths (`../assets/`).  
> For root pages, remove the `../` prefix throughout.  
> For `locations/*.html`, asset paths are identical to `pages/*.html` (also one level deep from root) — but page links work a bit differently: dropdown items link to `/locations/<branch>` (absolute) and footer privacy/terms links use `../pages/privacy` (one up, then into pages).

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

        <!-- Contact ▾ dropdown (added May 17 2026) -->
        <li class="nav-item-dropdown">
          <a href="contact.html" class="dropdown-trigger">Contact <span class="arrow">▾</span></a>
          <div class="dropdown-menu">
            <a href="/locations/jurong-west" class="dropdown-item">Jurong West</a>
            <a href="/locations/bukit-batok" class="dropdown-item">Bukit Batok (Le Quest)</a>
            <a href="/locations/tampines" class="dropdown-item">Tampines</a>
            <a href="/locations/tengah" class="dropdown-item">Tengah (HQ) <span class="badge-new">New</span></a>
          </div>
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

  <!-- Contact dropdown — in mobile drawer it's flat (always expanded, no toggle) -->
  <div class="nav-item-dropdown">
    <a href="contact.html" class="dropdown-trigger">Contact</a>
    <a href="/locations/jurong-west" class="dropdown-item">Jurong West</a>
    <a href="/locations/bukit-batok" class="dropdown-item">Bukit Batok (Le Quest)</a>
    <a href="/locations/tampines" class="dropdown-item">Tampines</a>
    <a href="/locations/tengah" class="dropdown-item">Tengah (HQ) <span class="badge-new">New</span></a>
  </div>

  <a href="trial.html" class="btn btn-cta">Book Trial Class</a>
</nav>
```

> **Active page:** Add `class="active"` to the `<a>` matching the current page.  
> **Instructor profile pages** (cecily.html, calvin.html, etc.): set `class="active"` on the **Instructors** nav link — they are sub-pages of Instructors.  
> **`<main>` padding-top:** Always `padding-top:108px` (36px bar + 72px nav).

---

---

## 4.5. NAVBAR DROPDOWN CSS (Contact ▾ — added May 17 2026)

The Contact dropdown is implemented as a `<li class="nav-item-dropdown">` inside `.nav-links`. Hover-opens on desktop (≥1025px), renders flat in the mobile drawer (≤1024px). Paste the block below into your `<style>` after the existing nav rules.

```css
/* ── Navbar Dropdown Extension (Contact ▾ menu) ── */
/* Breakpoints aligned to site's actual nav-collapse at 1024px */

/* 1. Desktop hover dropdown (nav-links is visible at >=1025px) */
@media (min-width: 1025px) {
  .nav-links .nav-item-dropdown { position: relative; display: inline-block; }
  .nav-links .dropdown-trigger .arrow {
    font-size: 11px; margin-left: 3px; display: inline-block;
    transition: transform .25s var(--sp); transform-origin: center;
  }
  .nav-links .nav-item-dropdown:hover .dropdown-trigger .arrow { transform: rotate(-180deg); }
  .nav-links .dropdown-menu {
    position: absolute; top: 100%; left: 50%; transform: translateX(-50%) translateY(-8px);
    min-width: 240px; background: var(--w); border: 1px solid #EEF2F8;
    border-radius: 14px; box-shadow: 0 18px 52px rgba(31,42,68,.12); padding: 8px;
    opacity: 0; visibility: hidden; transition: opacity .2s, transform .2s, visibility .2s;
    z-index: 1000;
  }
  .nav-links .nav-item-dropdown:hover .dropdown-menu {
    opacity: 1; visibility: visible; transform: translateX(-50%) translateY(0);
  }
  .nav-links .dropdown-item {
    display: flex; align-items: center; justify-content: space-between;
    padding: 11px 14px; border-radius: 9px; font-weight: 700; font-size: 14.5px;
    color: var(--ink); text-decoration: none; transition: background .15s, padding-left .18s var(--sp);
  }
  .nav-links .dropdown-item:hover { background: var(--or-lt); color: var(--or); padding-left: 18px; }
}

/* 2. Mobile drawer (always expanded, vertical) at <=1024px */
@media (max-width: 1024px) {
  .nav-drawer .nav-item-dropdown { display: flex; flex-direction: column; gap: 2px; }
  .nav-drawer .nav-item-dropdown .dropdown-trigger { font-weight: 700; }
  .nav-drawer .nav-item-dropdown .dropdown-item {
    display: flex; align-items: center; justify-content: space-between;
    padding: 8px 14px 8px 28px; border-radius: var(--r);
    font-weight: 600; font-size: 15px; color: var(--body);
    text-decoration: none; transition: background var(--t);
  }
  .nav-drawer .nav-item-dropdown .dropdown-item:hover { background: var(--or-lt); color: var(--or); }
}

/* 3. NEW badge chip (works in both desktop dropdown and mobile drawer) */
.badge-new {
  display: inline-block; padding: 2px 7px; background: var(--or); color: #fff;
  border-radius: 5px; font-size: 9px; font-weight: 800; letter-spacing: .5px;
  text-transform: uppercase; vertical-align: 2px; margin-left: 6px;
  font-family: 'Nunito', sans-serif;
}
```

> **Breakpoint coupling:** the dropdown CSS uses **1025px / 1024px** boundaries (not 900px / 901px) to align with the **Nest Hub nav-collapse fix** (see Section 3 breakpoint notes). All pages with the dropdown must also have the nav-collapse at 1024px, otherwise the dropdown will render in a half-broken state at 901–1024px.

> **(HQ) suffix + NEW badge** are reserved for the **Tengah** dropdown item. Tengah opened as the Flagship HQ in 2026 and replaces Jurong West as the headquarters reference. JW is now described as "established cornerstone" in copy.

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

> Source of truth: `index-zh.html` (root). Last updated: May 5, 2026.
> 
> **Pattern:** the English markup in Sections 1–8 above is the structural canonical. For Chinese pages, keep the markup, CSS classes, asset paths, IDs, and JSON-LD schemas identical — only swap the visible strings per the tables below. This keeps a single structural source of truth and avoids drift between EN and ZH.

### 14.1 `<html>` lang attribute and head meta

| Attribute | English page | Chinese page |
|---|---|---|
| `<html lang>` | `en` | `zh-CN` |
| `<title>` | `… \| Liberal Music & Arts School` | `… \| 博雅音乐艺术学校` |
| `<meta name="description">` | English copy | Localized Chinese copy |
| `<link rel="canonical">` | `https://liberalmusicschool.com/[slug]` | `https://liberalmusicschool.com/[slug]-zh` |

**Brand name:** Liberal Music & Arts School → 博雅音乐艺术学校.

### 14.2 Path conventions for Chinese pages

| File location | Logo src | Asset prefix | Link to root EN | Link to other ZH pages |
|---|---|---|---|---|
| Root (`index-zh.html`) | `assets/logo.webp` | `assets/` | `index` | `pages/[slug]` *(falls back to EN until pages-zh/ exists)* |
| Subfolder (`pages-zh/*.html`) *(planned)* | `../assets/logo.webp` | `../assets/` | `../index` | `[slug]-zh` |

> **Current state (May 2026):** only `index-zh.html` exists. Internal nav links from `index-zh.html` (e.g. About, Courses) point to `pages/about`, `pages/courses` — i.e. the English pages. Once a `pages-zh/about.html` is built, swap that single href to `pages-zh/about` and so on.

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

### 14.5 Language toggle — direction reverses on Chinese pages

```html
<!-- On English pages → toggle says 中文, links to Chinese -->
<a class="nav-lang" href="index-zh">中文</a>

<!-- On Chinese pages → toggle says EN, links back to English -->
<a class="nav-lang" href="index" style="text-decoration:none;color:var(--ink);font-weight:700;">EN</a>
```

The same reversal applies in the footer bottom bar (`中文版本` ↔ `English`) and the mobile drawer (where the toggle sits as a low-opacity row above the CTA button).

### 14.6 Mobile drawer — Chinese version

```html
<nav class="nav-drawer" id="navDrawer" aria-label="Mobile navigation">
  <a href="index-zh">首页</a>
  <a href="pages/about">关于我们</a>
  <a href="pages/courses">课程</a>
  <a href="pages/instructors">导师</a>
  <a href="pages/review">评价</a>
  <a href="pages/blog">博客</a>
  <a href="pages/contact">联系我们</a>
  <a href="index" style="opacity:.7;">EN</a>
  <a href="pages/trial" class="btn btn-cta">预约试课</a>
</nav>
```

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

- **JSON-LD schemas** (`@type`, `name`, address fields, etc.) — search engines and AI scrapers index these primarily in English. Translating them loses AEO coverage and risks "duplicate object" warnings in Google Search Console.
- **Brand names:** Liberal Music & Arts School, Coloury Art By Liberal, Le Quest, ABRSM, Trinity College London, RAD, MRT station English names.
- **CSS class names, IDs, ARIA labels, asset filenames, `data-*` attributes** — purely structural.
- **Postal addresses** (e.g. `127A Plantation Crescent, #01-381 Singapore 691127`) — keep raw so users can paste into Google Maps.
- **WhatsApp numbers and `wa.me` links** — same numbers, same links, only the row label is localized.

### 14.14 Building a new Chinese page — checklist

When you're ready to build out `pages-zh/about.html`, `pages-zh/courses.html`, etc., follow this delta from the English template:

1. Copy the English page (e.g. `pages/about.html`) → save as `pages-zh/about.html`.
2. Change `<html lang="en">` → `<html lang="zh-CN">`.
3. Update `<title>`, `<meta name="description">`, `<link rel="canonical">` per Section 14.1.
4. Update logo path: `../assets/` → `../assets/` (same — both are one level deep).
5. Swap announcement bar string per Section 14.3.
6. Swap nav link labels per Section 14.4. **Update href to point to ZH counterparts** — e.g. `href="about"` → `href="about-zh"` only once `about-zh.html` exists; otherwise leave the href pointing at the English page as a fallback.
7. Flip language toggle: `<a href="../index-zh">中文</a>` → `<a href="../index" style="...">EN</a>`.
8. Mobile drawer: localize labels, flip the language toggle, keep all hrefs in sync with step 6.
9. Footer: localize column headings (Section 14.7), brand paragraph (14.8), all 5 location headings + meta lines (14.9), bottom bar (14.10).
10. WhatsApp FAB: localize panel headline, intro, and the 5 row labels (Section 14.11). Numbers and `wa.me` links must NOT change.
11. Page body content: localize section headings, lead paragraphs, FAQ Q&As, CTAs. Keep brand terms in English per Section 14.13.
12. JSON-LD: keep verbatim from English page.

### 14.15 Verification markers (use in PowerShell verify-before-push)

When pushing Chinese-page edits, use distinctive Chinese strings as verification markers — they cannot collide with English-page content:

| Edit type | Suggested marker |
|---|---|
| Footer locations update | `每日1点-9点` |
| Brand paragraph rewrite | `博雅音乐艺术学校致力于培养孩子的创造力` |
| FAQ rewrite | `加速学习路径` (or another distinctive ZH phrase) |
| WhatsApp panel rewrite | `选择就近分校` |

---
