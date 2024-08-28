#!/bin/bash

# Pfad zum Ordner mit den PDF-Dateien als erstes Argument
PDF_FOLDER="$1"

# Pfad zur statischen PDF, die angehängt werden soll als zweites Argument
STATIC_PDF="$2"

# Pfad zum Ausgabeordner als drittes Argument
OUTPUT_FOLDER="$3"

echo "PDF-Ordner: $PDF_FOLDER"
echo "Statische PDF: $STATIC_PDF"
echo "Ausgabeordner: $OUTPUT_FOLDER"

# Ausgabeordner erstellen, falls er nicht existiert
mkdir -p "$OUTPUT_FOLDER"

# Überprüfen, ob die statische PDF existiert
if [[ ! -f "$STATIC_PDF" ]]; then
    echo "Die statische PDF $STATIC_PDF existiert nicht."
    exit 1
fi

# Durchlaufe alle PDF-Dateien im Ordner
for PDF_FILE in "$PDF_FOLDER"/*.pdf; do
    # Überprüfen, ob es sich um eine Datei handelt
    if [[ -f "$PDF_FILE" ]]; then
        # Erstelle den Dateinamen für die Ausgabe im neuen Ordner
        OUTPUT_FILE="$OUTPUT_FOLDER/$(basename "${PDF_FILE%.pdf}_merged.pdf")"

        # Füge die statische PDF an die aktuelle PDF an
        # pdftk "$PDF_FILE" "$STATIC_PDF" cat output "$OUTPUT_FILE"

        qpdf --empty --pages "$PDF_FILE" "$STATIC_PDF" -- "$OUTPUT_FILE"

        echo "Statische Seite zu $PDF_FILE hinzugefügt und in $OUTPUT_FILE gespeichert."
    fi
done