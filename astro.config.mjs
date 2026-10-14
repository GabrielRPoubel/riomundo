import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

// Portal Rio Mundo — https://x.com/rionomundo
export default defineConfig({
  site: 'https://rionomundo.example.com',
  vite: {
    plugins: [tailwindcss()],
  },
});
