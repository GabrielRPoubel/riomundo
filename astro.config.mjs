import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import sitemap from '@astrojs/sitemap';

// Portal Rio Mundo — https://x.com/rionomundo
export default defineConfig({
  site: 'https://rionomundo.com.br',
  integrations: [sitemap()],
  vite: {
    plugins: [tailwindcss()],
  },
});
