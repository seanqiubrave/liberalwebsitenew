# Liberal Music & Arts — Header & Footer Reference Guide
> Source of truth: `index.html` (master) · Last updated: April 2026  
> Apply this guide to **every** page. No deviations.

---

## ⚠️ PATH RULES (CRITICAL)

| File location | Logo src | Asset prefix | Link prefix |
|---|---|---|---|
| Root (`index.html`, `index-zh.html`) | `assets/logo.webp` | `assets/` | `pages/` |
| Subfolder (`pages/*.html`) | `../assets/logo.webp` | `../assets/` | *(relative, no prefix)* |

> All examples below use `pages/` subfolder paths (`../assets/`).  
> For root pages, remove the `../` prefix throughout.

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

      <!-- Nav order: Home | About | Courses | Instructors | Review | Blog | Contact — NEVER change -->
      <ul class="nav-links">
        <li><a href="../index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="courses.html">Courses</a></li>
        <li><a href="instructors.html">Instructors</a></li>
        <li><a href="testimonial.html">Review</a></li>
        <li><a href="blog.html">Blog</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>

      <div class="nav-end">
        <a href="../index-zh.html" class="nav-lang">中文</a>
        <!-- Book Trial button — exact padding/size must match -->
        <a href="trial.html" class="btn btn-cta" style="padding:10px 22px;font-size:14px;">Book Trial Class</a>
      </div>

      <button class="nav-ham" id="navHam" aria-label="Menu" aria-expanded="false">
        <span></span><span></span><span></span>
      </button>
    </div>
  </div>
</nav>

<!-- MOBILE DRAWER -->
<nav class="nav-drawer" id="navDrawer" aria-label="Mobile navigation">
  <a href="../index.html">Home</a>
  <a href="about.html">About</a>
  <a href="courses.html">Courses</a>
  <a href="instructors.html">Instructors</a>
  <a href="testimonial.html">Review</a>
  <a href="blog.html">Blog</a>
  <a href="contact.html">Contact</a>
  <a href="trial.html" class="btn btn-cta">Book Trial Class</a>
</nav>
```

> **Active page:** Add `class="active"` to the `<a>` matching the current page.  
> **`<main>` padding-top:** Always `padding-top:108px` (36px bar + 72px nav).

---

## 5. FOOTER CSS

Copy verbatim into every page `<style>`:

```css
/* ── Footer ── */
.footer{background:#1F2A44;margin:0;border-top:none;padding:80px 0 0}
.foot-grid{display:grid;grid-template-columns:1.8fr 1fr 1.7fr;gap:60px;padding-bottom:60px;border-bottom:1px solid rgba(255,255,255,.08);margin-bottom:0}
.foot-brand img{height:56px;width:auto;margin-bottom:22px;display:block}
.foot-brand p{font-size:15px;line-height:1.82;color:#fff;max-width:300px;margin-bottom:8px}
.foot-soc{display:flex;gap:9px;margin-top:24px}
.foot-soc a{width:36px;height:36px;border-radius:0;background:transparent;border:none;display:flex;align-items:center;justify-content:center;overflow:hidden;padding:0;transition:opacity .18s,transform .18s var(--sp)}
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
.foot-loc.soon{background:rgba(255,102,0,.10);border-color:rgba(255,102,0,.25)}
.foot-loc.soon .foot-loc-text strong{color:var(--or)}
.foot-loc.soon .foot-loc-text span{color:rgba(255,150,50,.7);font-weight:700}
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
        <p>Liberal Music &amp; Arts School nurtures creativity, confidence, and a lifelong love of music and the arts in children aged 4–16. Expert teachers, holistic learning, and real results — trusted by over 500 Singapore families since 2014.</p>
        <div class="foot-soc">
          <a href="#" aria-label="Instagram">
            <img src="../assets/Instagram.webp" alt="Instagram" style="width:26px;height:26px;object-fit:contain;filter:brightness(0) invert(1);display:block;"/>
          </a>
          <a href="#" aria-label="Facebook">
            <img src="../assets/facebook.webp" alt="Facebook" style="width:22px;height:22px;object-fit:contain;filter:brightness(0) invert(1);"/>
          </a>
          <a href="#" aria-label="YouTube">
            <img src="../assets/youtube.webp" alt="YouTube" style="width:22px;height:22px;object-fit:contain;filter:brightness(0) invert(1);"/>
          </a>
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
          <li><a href="testimonial.html">Review</a></li>
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
            </div>
          </div>

          <div class="foot-loc soon">
            <span class="foot-loc-pin">✦</span>
            <div class="foot-loc-text">
              <strong>Jurong Point Music School</strong>
              <span>Opening Soon — Register Interest</span>
            </div>
          </div>

        </div>
      </div>

    </div>

    <!-- Bottom bar -->
    <div class="foot-btm">
      <p>© 2025 Liberal Music &amp; Arts School. All rights reserved.</p>
      <div class="foot-btm-links">
        <span style="font-size:12px;color:rgba(255,255,255,.22);font-family:'Nunito',sans-serif;font-weight:700;letter-spacing:.5px;">v1.0.1</span>
        <a href="#">Privacy Policy</a>
        <a href="#">Terms of Use</a>
        <a href="../index-zh.html">中文版本</a>
      </div>
    </div>
  </div>
</footer>
```

---

## 7. WHATSAPP FAB + MOBILE STICKY BAR CSS

```css
/* WA FAB */
.wa{position:fixed;bottom:28px;right:28px;z-index:900;pointer-events:none}
.wa-fab{pointer-events:all;width:58px;height:58px;border-radius:50%;background:#25D366;color:#fff;display:flex;align-items:center;justify-content:center;font-size:36px;box-shadow:0 8px 28px rgba(37,211,102,.42);transition:transform var(--t) var(--sp),box-shadow var(--t);cursor:pointer}
.wa-fab:hover{transform:scale(1.12);box-shadow:0 14px 40px rgba(37,211,102,.54)}
.wa-panel{pointer-events:all;position:absolute;bottom:68px;right:0;background:var(--w);border-radius:var(--r-l);box-shadow:var(--sh-l);width:290px;padding:22px;border:1px solid #EEF2F8;opacity:0;transform:scale(.88) translateY(10px);transform-origin:bottom right;pointer-events:none;transition:opacity var(--t) var(--sp),transform var(--t) var(--sp)}
.wa-panel.on{opacity:1;transform:scale(1) translateY(0);pointer-events:all}
.wa-panel h4{font-family:'Nunito',sans-serif;font-size:24.5px;font-weight:900;color:var(--ink);margin-bottom:4px}
.wa-panel p{font-size:22.5px;color:var(--muted);margin-bottom:14px}
.wa-row{display:flex;align-items:center;justify-content:space-between;padding:11px 14px;border-radius:12px;background:var(--s2);border:1.5px solid #EEF2F8;margin-bottom:8px;font-family:'Nunito',sans-serif;font-weight:700;font-size:23.5px;color:var(--ink);transition:all var(--t);text-decoration:none}
.wa-row:hover{border-color:#25D366;background:#E8FFF1;color:#1a8a45}
.wa-row span{font-size:21.5px;font-weight:500;color:var(--muted)}
.wa-row:hover span{color:#1a8a45}

/* Mobile sticky bar */
.mob-bar{display:none;position:fixed;bottom:0;left:0;right:0;z-index:800;background:var(--w);padding:12px 20px 16px;box-shadow:0 -4px 20px rgba(31,42,68,.09);border-top:1px solid #EEF2F8}
.mob-bar .btn-cta{width:100%;justify-content:center;font-size:18px;padding:15px}

@media(max-width:900px){
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
    <a href="https://wa.me/6596277582" target="_blank" rel="noopener" class="wa-row">
      🌸 Jurong West / JP <span>9627 7582</span>
    </a>
  </div>
  <button class="wa-fab" id="waFab" aria-label="Open WhatsApp">💬</button>
</div>

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

## 11. QUICK CHECKLIST

Before finalising any page, verify:

- [ ] `Nunito + Quicksand` fonts imported in `<head>`
- [ ] `:root` CSS variables present and unmodified
- [ ] Announcement bar: `#f56c22`, SVG icon, correct trial link
- [ ] `<nav>` top: `36px` (shifted down by announcement bar)
- [ ] `<main>` padding-top: `108px`
- [ ] Nav logo height: `42px`, using `logo.webp` (never base64)
- [ ] Nav links font-size: `18px`, font-weight: `600`
- [ ] Nav link order: **Home | About | Courses | Instructors | Review | Blog | Contact**
- [ ] Active page has `class="active"` on its nav link
- [ ] 中文 button: `nav-lang` class, `font-size:15.5px`
- [ ] Book Trial button: `class="btn btn-cta"` + `style="padding:10px 22px;font-size:14px;"`
- [ ] Mobile drawer font-size: `25.5px`
- [ ] Footer background: `#1F2A44`
- [ ] Footer logo: `logofooter.webp`, height `56px`
- [ ] Footer description text: `color:#fff` (solid white), `font-size:15px`
- [ ] Social icons: `Instagram.webp` (26px), `facebook.webp`, `youtube.webp`, `xiaohongshu.webp` (22px each) — `filter:brightness(0) invert(1)`, no borders, no rounded box
- [ ] No `.foot-contact` email/phone block in footer (removed)
- [ ] All 5 locations listed with full names: "Tengah Music School", "Tampines Music School", etc.
- [ ] Location pin icons: `address.webp` with `filter:brightness(0) invert(1);opacity:.7` (except Jurong Point which uses `✦`)
- [ ] Nav links in footer: `font-size:15px`, `color:#fff` — no "✦ Free Trial Class" item
- [ ] Bottom bar includes `v1.0.1` version tag
- [ ] WA FAB present, all 3 WhatsApp numbers correct
- [ ] Mobile sticky bar present with trial link
- [ ] All asset paths use `../assets/` for `pages/` files, `assets/` for root files

---

## 12. WHATSAPP NUMBERS (never change)

| Branch | Number | wa.me link |
|---|---|---|
| Tengah | +65 8922 2848 | `https://wa.me/6589222848` |
| Tampines | +65 8892 1198 | `https://wa.me/6588921198` |
| Jurong West / Le Quest / Jurong Point | +65 9627 7582 | `https://wa.me/6596277582` |
