#!/usr/bin/env bash
# OK1JDV — publikace stránky na GitHub Pages
# Předpoklad: nainstalované gh CLI a přihlášení (gh auth login)
set -euo pipefail

REPO="${1:-ok1jdv}"          # název repa, default: ok1jdv
DOMAIN="${2:-}"              # volitelně: ok1jdv.cz  (nastaví custom doménu + CNAME)

# 1) inicializace repa
git init -b main
git add -A
git commit -m "OK1JDV station page: static site, llms.txt, about.md, robots.txt"

# 2) vytvoření repa na GitHubu a push
gh repo create "$REPO" --public --source=. --remote=origin --push

# 3) zapnutí GitHub Pages z větve main, root
OWNER=$(gh api user --jq .login)
gh api -X POST "repos/$OWNER/$REPO/pages" \
  -f "source[branch]=main" -f "source[path]=/" || \
gh api -X PUT "repos/$OWNER/$REPO/pages" \
  -f "source[branch]=main" -f "source[path]=/"

# 4) volitelně custom doména
if [ -n "$DOMAIN" ]; then
  echo "$DOMAIN" > CNAME
  git add CNAME && git commit -m "Add custom domain" && git push
  gh api -X PUT "repos/$OWNER/$REPO/pages" -f "cname=$DOMAIN" -F "https_enforced=true"
  echo "DNS: nastav u registrátora ALIAS/ANAME @ -> $OWNER.github.io  (nebo A záznamy na 185.199.108-111.153)"
fi

gh api "repos/$OWNER/$REPO/pages" --jq '.html_url'
