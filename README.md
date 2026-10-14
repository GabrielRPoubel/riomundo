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

## Publicar podcast
1. Coloque o MP3 em `public/audio/ep01.mp3`
2. Em `src/pages/index.astro`, troque `file: '#'` por `file: '/audio/ep01.mp3'`

## Publicar artigo/coluna (editor)
1. Abra `editor.html` no navegador (duplo clique)
2. Preencha título, gênero, editoria, resumo e escreva o texto (botões N/I/Título/Citação/Lista/Link)
3. Clique **Publicar no site** e salve o `.md` em `src/content/colunas/`
   (se o navegador não permitir salvar direto, use **Baixar .md** e mova o arquivo)
4. Rode `visualizar.bat` — o card entra em “Nossa opinião” e a página `/coluna/<slug>` é criada
- Imagens: botão **Imagem** (URL ou upload para `public/imagens/`); campo **capa** para thumbnail do card
- Legenda: escreva na linha abaixo da imagem em *itálico*

## Publicar vídeo
Em `src/pages/index.astro`, troque `id: null` pelo ID do YouTube.

## Visualizar antes do commit
Duplo clique em `visualizar.bat` → abre http://localhost:4321 com o build final.

## Visual
- Marfim: #FAF6ED / #FDFBF6
- Verde: #1A3C34 / #2D5A4C
- Fontes: Fraunces (títulos) + Inter (texto)
