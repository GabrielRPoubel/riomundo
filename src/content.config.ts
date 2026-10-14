import { defineCollection, z } from 'astro:content';

// Textos de "Nossa opinião" — criados pelo editor (editor.html) ou à mão.
// Cada arquivo .md nesta pasta vira um card na homepage + uma página /coluna/<slug>.
const colunas = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    excerpt: z.string(),
    genero: z.string(),
    editoria: z.string(),
    author: z.string().default('Redação Rio Mundo'),
    pubDate: z.coerce.date(),
    readTime: z.string().default('5 min'),
    imagem: z.string().optional(),
  }),
});

export const collections = { colunas };
