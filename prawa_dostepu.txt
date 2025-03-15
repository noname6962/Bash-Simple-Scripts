#!/bin/bash

# SPRAWDZENIE CZY ZOSTALY PODANE CONAJMNIEJ 2 PARAMETRY
if [ "$#" -lt 2 ]; then
    echo "przyklad uzycia: $0 <numerycznie_prawa_dostepu> <_plik_albo_folder1> <plik_albo_folder2> ..."
    exit 1
fi

# sprawdzenie czy pierwszy argument to numerycznie podane prawa dostepu
if ! [[ "$1" =~ ^[0-7]{3}$ ]]; then
    echo "Error: pierwszy argument to numerycznie podane prawa dostepu skladajace sie z 3 cyft (np. 755)."
    exit 1
fi

# pobranie praw dostepu i przypisanie wszystkim plikom/folderom
permissions="$1"
shift  # usuniecie praw dostepu z listy

for plik_lub_folder in "$@"; do
    # sprawdzenie czy plik/folder juz istnieje
    if [ ! -e "$plik_lub_folder" ]; then
        echo "Error: '$plik_lub_folder' nie istnieje."
        continue
    fi

    # sprawdzenie czy mamy prawo do modifikowania praw dostepu tego pliku/folderu
    if [ ! -w "$plik_lub_folder" ]; then
        echo "Error: niewystarczajace prawa do modifikacji '$plik_lub_folder'."
        continue
    fi

    # ustawienie uprawnien
    chmod "$permissions" "$plik_lub_folder"
    echo "prawa dostepu '$plik_lub_folder' ustawione na $permissions."
done

exit 0