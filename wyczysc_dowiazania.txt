#!/bin/bash

# sprawdzenie czy dokladnie 2 argumenty zostaly podane
if [ "$#" -ne 2 ]; then
    echo "poprawne uzycie: $0 <nazwa_katalogu> <output/log_file>"
    exit 1
fi

nazwa_katalogu="$1"
output_file="$2"

# sprawdzenie czy output/log file jest plikiem regularnym
if [ ! -f "$output_file" ]; then
    echo "Error: plik_log '$output_file' nie istnieje lub nie jest plikiem regularnym."
    exit 1
fi

# sprawdzenie czy mamy uprawnienia do czytania i pisania dla output/log file
if [ ! -r "$output_file" ] || [ ! -w "$output_file" ]; then
    echo "Error: niewystarczajace uprawnienia do pisania lub czytania '$output_file'."
    exit 1
fi

# sprawdzenie czy katalog istnieje i czy jest katalogiem
if [ ! -d "$nazwa_katalogu" ]; then
    echo "Error: katalog '$nazwa_katalogu' nie istnieje lub nie jest katalogiem."
    exit 1
fi

# sprawdzenie czy mamy uprawnienia do czytania pisania i wykonywania dla katalogu
if [ ! -r "$nazwa_katalogu" ] || [ ! -w "$nazwa_katalogu" ] || [ ! -x "$nazwa_katalogu" ]; then
    echo "Error: niewystarczajace uprawnienia do czytania pisania lub wykonywania dla '$nazwa_katalogu'."
    exit 1
fi

# sprawdzenie czy dowiazania symboliczne wystepuja w tym katalogu
#-z test sprawdza czy podany string jest pusty
if [ -z "$(find "$nazwa_katalogu" -maxdepth 1 -type l)" ]; then
    echo "brak dowiazan symbolicznych w katalogu '$nazwa_katalogu'."
    exit 0
fi

for link in "$nazwa_katalogu"/*; do
    if [ -L "$link" ]; then
        # wyswietlenie nazwy dowiazania i pytnie o usuniecie
        echo "znaleziono symboliczne dowiazanie: $link"
        read -p "chcesz usunac to dowiazanie? (p/f): " odpowiedz

        # sprawdzenie odpowiedzi uzytkownika
        case "$odpowiedz" in
            [Pp]|[Pp][Rr][Aa][Ww][Dd][Aa])
                # usuniecie dowiazania
                rm "$link"
                echo "dowiazanie '$link' zostao usuniete." >> "$output_file"
                ;;
            *)
                echo "dowizanie '$link' niezostalo usuniete."
                ;;
        esac
    fi
done

exit 0