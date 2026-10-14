import { defineCollection, z } from 'astro:content';

// Textos de "Nossa opinião" — criados pelo editor (editor.html) ou à mão.
// Cada arquivo .md nesta pasta vira um card na homepage + uma página /coluna/<slug>.
const urlSegura = z
  .string()
  .refine(
    (v) => v.startsWith('/') || v.startsWith('https://') || v.startsWith('http://'),
    { message: 'imagem deve começar com / ou https://' },
  );

const colunas = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string().min(8).max(120),
    excerpt: z.string().min(20).max(220),
    genero: z.enum(['Notícia', 'Opinião', 'Extras']),
    editoria: z.enum(['Rio', 'Brasil', 'Mundo', 'Ideias & Debates']),
    author: z.string().default('Redação Rio Mundo'),
    pubDate: z.coerce.date(),
    readTime: z.string().default('5 min'),
    imagem: urlSegura.optional(),
  }),
});

export const collections = { colunas };
