# Rio Mundo — Portal jornalístico

Notícias sobre o Rio e o mundo pela ótica de uma esquerda não identitária.
Ref: https://x.com/rionomundo

## Stack (decidida)
- Astro 5 + TypeScript + Tailwind CSS v4
- Conteúdo inicial estático em `src/pages/index.astro`
- Player nativo `<audio>` + botão `download` para podcasts MP3
- Vídeos via embed YouTube (trocar `id` por ID real)

## Rodar
```powershell
& "C:\Program Files\nodejs\npm.cmd" install
& "C:\Program Files\nodejs\npm.cmd" run dev
```

## Publicar tudo (fluxo simples)
1. Salve `.md` em `Para publicar\Textos\`, imagens em `Para publicar\Imagens\`, `.mp3` em `Para publicar\Audios\`
   (cada pasta tem um guia `.txt`)
2. **Quer ver o artigo no site antes?** Duplo clique em `previa.bat` — abre o
   artigo renderizado em http://localhost:4321 sem publicar nada.
3. Duplo clique em `publicar.bat` — ele move só o que é novo, **ignora arquivos
   repetidos sem alteração**, confere o build, commita e envia ao GitHub.
   Se nada mudou, ele avisa e não faz nada.

## Publicar podcast
1. Solte o MP3 em `Para publicar\Audios\` e rode `publicar.bat`
2. Em `src/data/site.ts`, ligue o player (troque `file: null` por `file: '/audio/ep01.mp3'`)
   e rode `publicar.bat` de novo

## Publicar artigo/coluna (editor)
1. Abra `editor.html` no navegador (duplo clique)
2. Preencha título, gênero, editoria, resumo e escreva o texto (botões N/I/Título/Citação/Lista/Link)
3. Clique **Publicar no site** e salve o `.md` em `Para publicar\Textos\`
   (se o navegador não permitir salvar direto, use **Baixar .md** e mova o arquivo)
4. Rode `publicar.bat` — o card entra em “Nossa opinião” e a página `/coluna/<slug>` é criada
- Imagens: botão **Imagem** (URL ou solte o arquivo em `Para publicar\Imagens/`); campo **capa** para thumbnail do card (`/imagens/nome-do-arquivo`)
- Legenda: escreva na linha abaixo da imagem em *itálico*

## Gerir categorias, autores e suspensões
1. Abra `gerir.html` no navegador (duplo clique, use Chrome ou Edge)
2. Clique **Conectar pasta do projeto** e selecione a pasta principal
3. No painel: **Transferir** move artigos entre editorias/gêneros/autores
   (quando um valor zera, ele some — é assim que se apaga uma categoria);
   **Suspender** esconde do site sem apagar (vale após rebuild)
4. Na lista de artigos dá para trocar editoria/gênero/autor e apagar artigos
5. Confira no `previa.bat` e publique com `publicar.bat`

## Publicar vídeo
Em `src/data/site.ts`, troque `id: null` pelo ID do YouTube.

## Dados centralizados
`src/data/site.ts` é a fonte única para `editorias, ticker` — usado por `Base.astro` e `index.astro`.
(“Em voga” e “Últimas atualizações” derivam dos artigos reais em `src/content/colunas/`.)

## Visualizar antes do commit
- Rascunho ainda em `Para publicar\`: duplo clique em `previa.bat` → abre o
  artigo renderizado em http://localhost:4321 sem publicar nada.
- Site já publicado: duplo clique em `visualizar.bat` → abre o build final.

## Visual
- Marfim: #FAF6ED / #FDFBF6 / #F1E9D7
- Verde: #052E16 / #065F2C / #007A33 (texto pequeno usa 900 para contraste AA)
- Fontes: Libre Franklin (títulos) + Inter (texto)
