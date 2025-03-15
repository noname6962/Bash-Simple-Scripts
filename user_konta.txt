#!/bin/bash

# sprawdzenie czy przynajmniej jeden argument zostal podany
if [ "$#" -lt 1 ]; then
    echo "przydklad urzycia: $0 <nazwa_uzytkownika1> <nazwa_uzytkownika2> <nazwa_uzytkownika3> ..."
    exit 1
fi

for username in "$@"; do
    # sprawdzenie czy uzytkownik o tej nazwie juz istnieje
    # &>/dev/null jest upewnieniem ze ouput lub error z id zostanie porzucony
    while id "$username" &>/dev/null; do
        echo "uzytkownik '$username' juz istnieje. tworzenie konta uzytkonika o innej nazwie. Podaj inna nazwe uzytkownika"
        read username
    done

    # tworzenie konta uzytkownika
    sudo useradd -m -s /bin/bash "$username"

    # tworzenie tymczasowego hasla uzytkowniika
    echo "$username:$username" | sudo chpasswd

    # zmuszenie uzytkownika do zmiany hasla przy pierwszym logowaniu
    sudo chage -d 0 "$username"

    echo "konto uzytkownika '$username' zostalo pomyslnie zalozone:"
    echo " - foldr domowy: /home/$username"
    echo " - haslo tymczasowe: $username"
    echo " - Wymagana jest zmiana hasla przy pierwszym logowaniu"
done

exit 0