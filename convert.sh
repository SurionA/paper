#!/usr/bin/env bash
# Convertit un PDF en Markdown via MinerU, par tranches de pages pour éviter
# le timeout serveur et la saturation mémoire des gros documents (92 pages ici).
#
# Journalise chaque tranche traitée pour suivre l'avancement, puis fusionne.
#
# Usage:
#   ./convert.sh paper.pdf                  # tout le document
#   CHUNK=6 ./convert.sh paper.pdf          # tranches de 6 pages (plus visibles)
#   PDF=autre.pdf CHUNK=4 ./convert.sh
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"
VENV="$DIR/.venv"
MINERU="$VENV/bin/mineru"
PDF="${PDF:-${1:-$DIR/paper.pdf}}"
CHUNK="${CHUNK:-12}"
OUT="$DIR/out"

[ -f "$PDF" ] || { echo "PDF introuvable: $PDF"; exit 1; }
[ -x "$MINERU" ] || { echo "venv absent -> lance d'abord: ./setup.sh"; exit 1; }

TOTAL="$(pdfinfo "$PDF" 2>/dev/null | awk '/^Pages/{print $2}')"
TOTAL="${TOTAL:-92}"
[ "$TOTAL" -gt 0 ] 2>/dev/null || TOTAL=92
STEM="$(basename "$PDF" .pdf)"

rm -rf "$OUT";  mkdir -p "$OUT"
start=0; n=0
while [ "$start" -lt "$TOTAL" ]; do
  end=$((start + CHUNK)); [ "$end" -gt "$TOTAL" ] && end=$TOTAL
  printf -v tag "%02d" "$n"
  chk="$OUT/$tag"
  mkdir -p "$chk"

  t0="$(date +%s)"
  echo "----- tranche $tag : pages [$start, $end) -----"
  "$MINERU" -p "$PDF" -o "$chk" -b pipeline -m ocr -s "$start" -e "$end" 2>&1 \
    | grep -viE "Fetching|it/s|Predict:" > "$chk/run.log" || true
  dt="$(( $(date +%s) - t0 ))"

  if grep -qiE "failed|timed out|error" "$chk/run.log"; then
    echo "!! échec de la tranche $tag, log: $chk/run.log"; exit 1
  fi
  [ -f "$chk/$STEM/ocr/$STEM.md" ] || { echo "!! pas de sortie pour la tranche $tag"; exit 1; }
  printf '   [✓ pages %d–%d | %d min %02d s]\n' \
    "$start" "$((end-1))" "$((dt/60))" "$((dt%60))"

  start=$end; n=$((n+1))
done

echo "===== fusion ====="
FINAL="$OUT/$STEM.md"
: > "$FINAL"
first=1
for f in "$OUT"/[0-9][0-9]/"$STEM"/ocr/"$STEM".md; do
  [ -f "$f" ] || { echo "manquant: $f"; exit 1; }
  # saute le bloc titre/abstract de la 1re tranche si dupliqué ailleurs (rare) -> concat simple
  cat "$f" >> "$FINAL"
  printf "\n\n" >> "$FINAL"
done
rm -f "$FINAL.orig"

echo "Résultat: $FINAL ($(wc -l < "$FINAL") lignes)"
