Design principles
=================

This document gathers design decisions and conventions for this repository. It is adapted from the Google Labs Code `design.md` guidance and tailored for a Laravel + Tailwind + DaisyUI project.

Goals
-----
- Make UI and layout decisions explicit and discoverable.
- Provide a single source for component, theme, and accessibility rules.
- Reduce design/implementation friction for contributors.

Project context
---------------
- Laravel 13 application with Vite + Tailwind (Tailwind v4) build.
- DaisyUI plugin introduced; custom `luxury` theme registered in `tailwind.config.cjs`.
- Primary frontend entry: `resources/css/app.css` + `resources/js/app.js`.
- Main view for the site: `resources/views/landing.blade.php`.

Where to look
--------------
- Tailwind configuration: `tailwind.config.cjs` (contains DaisyUI theme named `luxury`).
- Global styles: `resources/css/app.css`.
- Components and pages: `resources/views/*.blade.php`.

Branding & Theme
----------------
- Theme name: `luxury` (DaisyUI). It uses OKLCH color tokens defined in `tailwind.config.cjs`.
- The site uses DaisyUI semantic color tokens (`primary`, `secondary`, `accent`, `base-100`, `base-200`, `base-300`, etc.). Use these tokens in templates instead of raw hex values to keep design consistent and responsive to theme changes.
- HTML pages that should apply the theme set `data-theme="luxury"` on the `<html>` element (see `resources/views/landing.blade.php`).

Design tokens & utilities
-------------------------
- Prefer DaisyUI tokens and Tailwind utility classes for layout and spacing.
- For custom tokens (fonts, radii), add them to `:root` in `resources/css/app.css` or to `tailwind.config.cjs` `theme.extend` when you need to expose them as utilities.

Component conventions
---------------------
- Use DaisyUI components (for example `btn`, `card`, `hero`, `navbar`) for rapid composition.
- Keep components small and reusable; extract repeating structures into Blade partials (e.g., `resources/views/components/*`) if they will be reused.
- Naming: Blade partials should be kebab-cased and placed under `resources/views/components/` (e.g. `components/site-nav.blade.php`).

Accessibility
-------------
- Use semantic HTML: `nav`, `header`, `main`, `footer`, `section`, `h1..h6`.
- Provide meaningful link text and `aria-*` attributes where needed.
- Ensure color contrast meets WCAG AA where practical. Because the theme uses OKLCH tokens, verify contrast whenUpdating colors.
- Focus states: prefer visible focus rings on interactive elements. Tailwind/DaisyUI generally provides focus styles — keep them or enhance them rather than removing.

Responsive behavior
-------------------
- Layouts should be mobile-first using Tailwind responsive prefixes: `sm:`, `md:`, `lg:`, `xl:`.
- Components should adapt by switching from column to row on larger breakpoints (e.g., `flex-col lg:flex-row`).

Workflow & tooling
------------------
- Install node dependencies: `npm install`.
- Development: `npm run dev` (Vite) — ensures Tailwind and DaisyUI are processed.
- Production build: `npm run build`.
- PHP formatting: run `vendor/bin/pint --format agent` after modifying PHP files.

Adding or changing the theme
----------------------------
1. Update `tailwind.config.cjs` under the `daisyui.themes` array.
2. If you add new tokens, expose them via `theme.extend` or `:root` in `resources/css/app.css`.
3. Rebuild assets: `npm run build` (or `npm run dev` during development).

Component design checklist
--------------------------
Before merging a visual change, verify:
- [ ] Uses semantic tokens (`btn`, `card`, `bg-base-100`, `text-base-content`) where appropriate.
- [ ] Works at mobile and large breakpoints.
- [ ] Has sufficient color contrast for text and interactive elements.
- [ ] Interactive elements have keyboard focus styles.
- [ ] No hard-coded hex colors unless intentionally bypassing tokens.

Extending the system
--------------------
- When a shared UI pattern emerges, add a Blade partial under `resources/views/components/` and document its usage here.
- For new global utilities or tokens, prefer editing `tailwind.config.cjs` so utilities are available to all templates.

Links & references
------------------
- DaisyUI: https://daisyui.com/
- Tailwind CSS: https://tailwindcss.com/
- OKLCH color notes: refer to your design tool or color utility docs for correct usage.
- Laravel views convention: https://laravel.com/docs/views

Maintainers
-----------
- Add a maintainer section or keep `AGENTS.md` for agent-specific rules. This file documents visual design decisions; keep `AGENTS.md` for operational rules.

Changelog
---------
- 2026-06-29: Initial `DESIGN.md` created and linked from `README.md`.