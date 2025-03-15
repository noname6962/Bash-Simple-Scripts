#!/bin/bash

# sprawdzenie czy trzy parametry zostaly podane
if [ "$#" -ne 3 ]; then
    echo "przyklad uzycia: $0 <plikIN> <plik1> <plik2>"
    exit 1
fi

input_file="$1"
output_file1="$2"
output_file2="$3"

# sprawdzenie czy plikIN istnieje i jest plikiem regularnym
if [ ! -f "$input_file" ]; then
    echo "Error: '$input_file' nie istnieje albo nie jest plikiem regularnym."
    exit 1
fi

# sprawdzenie czy psoiadamy uprawnienia do czytania pliku input
if [ ! -r "$input_file" ]; then
    echo "Error: niewystarczajace uprawnienia do czytania z '$input_file'."
    exit 1
fi

# sprawdzenie czy pliki outputowe istnieja i sa plikami regularnymi
for output_file in "$output_file1" "$output_file2"; do
    if [ -e "$output_file" ]; then
        if [ ! -f "$output_file" ]; then
            echo "Error: '$output_file' istnieje ale nie jest plikiem regularnym."
            exit 1
        fi
        # sprawdzenie czy mamy uprawnienia do pisania do plikow outputowych
        if [ ! -w "$output_file" ]; then
            echo "Error: niewystarczajace uprawnienia do pisania do plku '$output_file'."
            exit 1
        fi
    fi
done

# rodzielanie linijek do odpowiednich plikow
awk '{
    if (NR % 2 == 0) {
        print NR " " $0 > ARGV[2]
    } else {
        print NR " " $0 > ARGV[3]
    }
}' "$input_file" "$output_file1" "$output_file2"

echo "plik '$input_file' zostal podzielona do pliku '$output_file1' i '$output_file2' na podstawie numerow lini."

exit 0