import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import sitemap from '@astrojs/sitemap';

// Portal Rio Mundo — https://x.com/rionomundo
export default defineConfig({
  site: 'https://rionomundo.com.br',
  // No GitHub Pages (projeto em /riomundo/) o workflow define SITE_BASE.
  // Local e no domínio próprio, vale '/'.
  base: process.env.SITE_BASE ?? '/',
  integrations: [sitemap()],
  vite: {
    plugins: [tailwindcss()],
  },
});
