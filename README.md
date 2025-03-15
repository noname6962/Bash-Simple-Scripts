# Bash Simple Scripts

A collection of simple yet useful Bash scripts designed to automate everyday tasks and improve efficiency.

## Features
- Various Bash scripts for different automation tasks
- Well-structured and easy-to-read code
- Lightweight and easy to execute
- Suitable for beginners and experienced users alike

## Prerequisites
To use these scripts, you need:
- A Unix-based operating system (Linux/macOS)
- Bash shell (typically pre-installed on most Unix systems)
- Basic understanding of command-line operations

## Installation
1. Clone this repository:
   ```sh
   git clone https://github.com/noname6962/Bash-Simple-Scripts.git
2. Navigate to the cloned directory:
   ```sh
   cd Bash-Simple-Scripts
3. Make scripts executable (if required):
   ```sh
   chmod +x script_name.sh
4. Run the script:
   ```sh
   ./script_name.sh

# rozdziel_pliki.sh
Splits an input file into two separate files based on line numbers (odd/even lines).
## Usage
   ```sh
   ./rozdziel_pliki.sh <plikIN> <plik1> <plik2>
```
- plikIN: Input file to be split
- plik1: Output file for odd-numbered lines
- plik2: Output file for even-numbered lines

# user_konta.sh
Creates new user accounts, ensuring unique usernames and enforcing a password change upon first login.
## Usage
   ```sh
   ./user_konta.sh <nazwa_uzytkownika1> <nazwa_uzytkownika2> ...
```

# prawa_dostepu.sh
sets permissions for multiple files at once
## Usage
   ```sh
   ./prawa_dostepu.sh <numerycznie_prawa_dostepu> <_plik_albo_folder1> <plik_albo_folder2> ...
```

# wyczysc_dowiazania.sh
erases symlinks
## Usage
   ```sh
   ./wyczysc_dowiazania.sh <nazwa_katalogu> <output/log_file>
