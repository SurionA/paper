#!/usr/bin/env bash
# Met en place le venv Python 3.12 et installe MinerU (backend pipeline, CPU/GPU).
# Usage: ./setup.sh
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

if [ -x .venv/bin/mineru ]; then
  echo "venv déjà prêt (.venv). Rien à faire. Lance: ./convert.sh"
  exit 0
fi

if command -v uv >/dev/null 2>&1; then
  echo "==> création du venv avec uv (python 3.12)"
  uv venv .venv -p 3.12
  echo "==> installation de mineru[pipeline] + six"
  uv pip install --python .venv/bin/python "mineru[pipeline]" six
elif command -v python3.12 >/dev/null 2>&1; then
  echo "==> création du venv avec python3.12"
  python3.12 -m venv .venv
  .venv/bin/python -m pip install --upgrade pip
  .venv/bin/python -m pip install "mineru[pipeline]" six
else
  echo "ERREUR: besoin de 'uv' ou d'un python 3.12 sur le système." >&2
  echo "Astuce: sur les machines récentes, 'uv' s'installe en une commande." >&2
  exit 1
fi

echo
echo "==> vérification"
.venv/bin/mineru --version
echo
echo "Prêt. Lance la conversion avec: ./convert.sh"
echo "Note: les modèles sont téléchargés au premier run (~limites disque)."
