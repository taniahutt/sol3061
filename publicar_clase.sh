#!/bin/zsh
# Prepara una clase para publicarla en el sitio, SIN notas de presentador.
# Uso: ./publicar_clase.sh C1
# Genera publicadas/C1_clase.html (archivo único, con imágenes incluidas).
# No sube nada: después hay que enlazarla en index.qmd y hacer commit/push.
set -e
cd "$(dirname "$0")"
clase="$1"
[[ -z "$clase" ]] && { echo "Uso: ./publicar_clase.sh C1"; exit 1; }
qmd="clases/${clase}_clase.qmd"
[[ -f "$qmd" ]] || { echo "No existe $qmd"; exit 1; }

mkdir -p publicadas
QUARTO_STRIP_NOTES=1 quarto render "$qmd" --to revealjs -M embed-resources:true
cp "_site/clases/${clase}_clase.html" "publicadas/${clase}_clase.html"

if grep -q 'class="notes"' "publicadas/${clase}_clase.html"; then
  echo "ERROR: el archivo todavía contiene notas de presentador. No publicar."
  rm "publicadas/${clase}_clase.html"; exit 1
fi

# Volver a generar la versión local normal (con notas) para presentar
quarto render "$qmd" --to revealjs >/dev/null
echo "Listo: publicadas/${clase}_clase.html (sin notas)."
echo "Para publicar: enlazarla en index.qmd como publicadas/${clase}_clase.html, luego git add publicadas index.qmd, commit y push."
