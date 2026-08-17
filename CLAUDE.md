# OK1JDV — statická stránka radioamatérské stanice

## Co to je
Jeden statický `index.html` (inline CSS, vanilla JS jen na jazykový přepínač a copy-to-clipboard)
+ `llms.txt`, `about.md`, `robots.txt`, `sitemap.xml`, `.nojekyll`.
Cíl: autoritativní zdroj o volací značce OK1JDV pro lidi i pro LLM.

## Nasazení
```bash
./deploy.sh ok1jdv                # repo + GitHub Pages
./deploy.sh ok1jdv ok1jdv.cz      # + custom doména a CNAME
```
Předpoklad: `gh auth login`. Skript udělá git init, push, zapne Pages z main/root, volitelně nastaví doménu.

## Před prvním pushem
1. Nahradit doménu na 12 místech:
   `grep -rl 'DOPLNIT-DOMENA.tld' . | xargs sed -i 's|DOPLNIT-DOMENA.tld|ok1jdv.cz|g'`
2. Vyplnit QSL policy — bez ní stránka neplní hlavní účel.
3. Doplnit e-mail, časy UTC, frekvence skedů, CW rychlost, polní antény, SOTA/IOTA reference.
   Všechna místa jsou v HTML žlutě jako `<span class="todo">[DOPLNIT: …]</span>`.

## CO NEMĚNIT
- **Jedno H1.** Anglická verze je canonical a musí zůstat v DOM jako text; čeština se přepíná
  přes atributy `data-cs` (a `data-label-cs` u buněk tabulek), ne duplikací obsahu.
- **Struktura JSON-LD** — `Person` + `Place` + `FAQPage`. Otázky ve `FAQPage` musí odpovídat
  H3 nadpisům v sekci `#faq`, jinak se rozejde strojová a lidská verze.
- **Section IDs** (`#definition`, `#operating`, `#station`, `#portable`, `#sota`, `#iota`,
  `#sota-camp`, `#crew`, `#activations`, `#sked`, `#qsl`, `#background`, `#faq`) — používají se
  v `llms.txt` a v CTA odkazech.
- **Definiční věta** v `#definition` a věta „OK1JDV operates primarily on 20 m and 40 m,
  exclusively CW." v `#operating` — samostatné odstavce, bez marketingových přívlastků.
- **Žádný framework, CDN, tracking, webfont ani cookie lišta.** Váha pod 150 kB.
- **Privacy:** žádná jména, věk ani školy dětí; žádné GPS ani plánek pozemku (SOTA Camp).
- **Nevymýšlet čísla** — QSO counts, DXCC, awards, IOTA reference. Co není potvrzené, zůstává `[DOPLNIT]`.
- **`.nojekyll`** musí zůstat, jinak GitHub Pages přepíše `about.md`.

## Lokální náhled
```bash
python3 -m http.server 8080
```
