import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import sitemap from '@astrojs/sitemap';

// Prefixo sem barra final: '' no domínio/local, '/riomundo' no Pages.
// Reescreve URLs absolutas do Markdown (imagens, links, definições)
// para respeitar o base do deploy.
const _base = process.env.SITE_BASE ?? '/';
const _prefix = _base.endsWith('/') ? _base.slice(0, -1) : _base;
function _comBase(u) {
  if (typeof u !== 'string' || !u.startsWith('/') || u.startsWith('//')) return u;
  if (_prefix === '' || u === _prefix || u.startsWith(_prefix + '/')) return u;
  return _prefix + u;
}
function _visitar(node, fn) {
  fn(node);
  const filhas = node?.children;
  if (Array.isArray(filhas)) for (const f of filhas) _visitar(f, fn);
}
// Remark: ![alt](/imagens/x.jpg), [texto](/slug), [ref]: /url
function remarkBasePaths() {
  return (tree) => {
    _visitar(tree, (n) => {
      if ((n.type === 'image' || n.type === 'link' || n.type === 'definition') && typeof n.url === 'string') {
        n.url = _comBase(n.url);
      }
    });
  };
}
// Rehype: <img src="/..."> / <a href="/..."> escritos como HTML cru no .md
function rehypeBasePaths() {
  return (tree) => {
    const ver = (n) => {
      if (n.type === 'element') {
        const p = n.properties ?? {};
        if (n.tagName === 'img' && typeof p.src === 'string') p.src = _comBase(p.src);
        if ((n.tagName === 'a' || n.tagName === 'link') && typeof p.href === 'string') p.href = _comBase(p.href);
        if (typeof p.srcset === 'string' && p.srcset.includes('/')) {
          p.srcset = p.srcset.split(',').map((parte) => {
            const [u, ...resto] = parte.trim().split(/\s+/);
            return [_comBase(u), ...resto].join(' ');
          }).join(', ');
        }
      }
      const filhas = n?.children;
      if (Array.isArray(filhas)) for (const f of filhas) ver(f);
    };
    ver(tree);
  };
}

// Portal Rio Mundo — https://x.com/rionomundo
export default defineConfig({
  site: 'https://rionomundo.com.br',
  // No GitHub Pages (projeto em /riomundo/) o workflow define SITE_BASE.
  // Local e no domínio próprio, vale '/'.
  base: process.env.SITE_BASE ?? '/',
  markdown: {
    remarkPlugins: [remarkBasePaths],
    rehypePlugins: [rehypeBasePaths],
  },
  integrations: [sitemap()],
  vite: {
    plugins: [tailwindcss()],
  },
});
