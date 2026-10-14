// Fonte única de verdade para dados exibidos em Base.astro + index.astro.
// "Em voga" e "Últimas atualizações" derivam dos artigos reais (src/content/colunas).
// Podcasts e entrevistas usam fillers honestos até haver MP3 / ID do YouTube.

export const SITE_URL = 'https://rionomundo.com.br';

export const editorias: Array<[string, string]> = [
  ['Nossa opinião', '/#selecao'],
  ['Podcasts', '/#podcasts'],
  ['Entrevistas', '/#entrevistas'],
  ['Em voga', '/#mais-lidas'],
  ['Últimas atualizações', '/#em-continuo'],
];

export const ticker = [
  { destaque: 'Nossa opinião', texto: 'Os textos mais recentes do Rio Mundo', href: '/#selecao' },
  { destaque: 'Podcast', texto: 'Estreia em breve — acompanhe no X', href: '/#podcasts' },
  { destaque: 'Entrevistas', texto: 'Conversas longas em produção', href: '/#entrevistas' },
];
