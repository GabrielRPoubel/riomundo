// Fonte única de verdade para dados exibidos em Base.astro + index.astro.
// "Em voga" e "Últimas atualizações" derivam dos artigos reais (src/content/colunas).
// Podcasts e entrevistas usam fillers honestos até haver MP3 / ID do YouTube.

import suspensos from './suspensos.json';

export const SITE_URL = 'https://rionomundo.com.br';

export const editorias: Array<[string, string]> = [
  ['Nossa opinião', '/#selecao'],
  ['Podcasts', '/#podcasts'],
  ['Entrevistas', '/#entrevistas'],
  ['Em voga', '/#mais-lidas'],
  ['Últimas atualizações', '/#em-continuo'],
];

// (O ticker do topo agora deriva dos artigos em Base.astro — sem texto fixo.)

// Mesmo algoritmo do editor (editor.html): ~900 letras por minuto, mínimo 1.
// Calculado no build a partir do corpo — o frontmatter nunca mente.
export function tempoLeitura(corpo: string): string {
  const letras = (corpo.match(/[A-Za-zÀ-ÖØ-öø-ÿ]/g) || []).length;
  return Math.max(1, Math.round(letras / 900)) + ' min';
}

// Data curta em pt-BR: 14/10/2026 (lê melhor que "14 de out. de 2026").
export function formatarData(d: Date): string {
  return d.toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit', year: 'numeric', timeZone: 'UTC' });
}

// Suspender sem apagar: valores listados em suspensos.json somem da capa,
// do ticker e das páginas (gerenciado pelo gerir.html).
export interface ItemDoSite {
  data: { editoria: string; genero: string; author: string };
}
export function visivel(e: ItemDoSite): boolean {
  return !suspensos.editorias.includes(e.data.editoria)
    && !suspensos.generos.includes(e.data.genero)
    && !suspensos.autores.includes(e.data.author);
}
