#!/bin/bash

# Fånga upp avbrytningssignaler
trap "" SIGINT SIGTERM SIGTSTP

# Inaktivera tangentbordets avbrottskombinationer
stty -echo
stty intr ""
stty susp ""
stty quit ""

# Starta en timer för att avsluta efter 10 sekunder
SECONDS=0
MAX_RUNTIME=30

# Visa hackat-meddelande vid start
function show_hacked_message {
    clear
    
    # Hämta skärmstorlek
    local rows=$(tput lines)
    local cols=$(tput cols)
    
    # Centrera texten
    local message="DU HAR BLIVIT HACKAD!"
    local msg_length=${#message}
    
    # Gör texten stor i ASCII-art stil och blinka den några gånger
    for blink in {1..5}; do
        if [ $((blink % 2)) -eq 1 ]; then
            # Visa texten
            tput bold
            tput setaf 1  # Röd text
            
            # Rita ut stor text centrerat
            tput cup $((rows/2 - 4)) $(((cols-60)/2))
            echo "██████  ██    ██    ██   ██  █████  ██████  "
            tput cup $((rows/2 - 3)) $(((cols-60)/2))
            echo "██   ██ ██    ██    ██   ██ ██   ██ ██   ██ "
            tput cup $((rows/2 - 2)) $(((cols-60)/2))
            echo "██   ██ ██    ██    ███████ ███████ ██████  "
            tput cup $((rows/2 - 1)) $(((cols-60)/2))
            echo "██   ██ ██    ██    ██   ██ ██   ██ ██   ██ "
            tput cup $((rows/2)) $(((cols-60)/2))
            echo "██████   ██████     ██   ██ ██   ██ ██   ██ "
            
            tput cup $((rows/2 + 2)) $(((cols-60)/2))
            echo "██████  ██      ██ ██    ██ ██ ████████ "
            tput cup $((rows/2 + 3)) $(((cols-60)/2))
            echo "██   ██ ██      ██ ██    ██ ██    ██    "
            tput cup $((rows/2 + 4)) $(((cols-60)/2))
            echo "██████  ██      ██ ██    ██ ██    ██    "
            tput cup $((rows/2 + 5)) $(((cols-60)/2))
            echo "██   ██ ██      ██  ██  ██  ██    ██    "
            tput cup $((rows/2 + 6)) $(((cols-60)/2))
            echo "██████  ███████ ██   ████   ██    ██    "
            
            tput cup $((rows/2 + 9)) $(((cols-40)/2))
            echo " ██   ██  █████   ██████ ██   ██  █████  ██████  "
            tput cup $((rows/2 + 10)) $(((cols-40)/2))
            echo " ██   ██ ██   ██ ██      ██  ██  ██   ██ ██   ██ "
            tput cup $((rows/2 + 11)) $(((cols-40)/2))
            echo " ███████ ███████ ██      █████   ███████ ██   ██ "
            tput cup $((rows/2 + 12)) $(((cols-40)/2))
            echo " ██   ██ ██   ██ ██      ██  ██  ██   ██ ██   ██ "
            tput cup $((rows/2 + 13)) $(((cols-40)/2))
            echo " ██   ██ ██   ██  ██████ ██   ██ ██   ██ ██████  "
        else
            # Dölj texten (rensa skärmen)
            clear
        fi
        
        # Vänta en kort stund
        sleep 0.5
    done
    
    # Visa texten en sista gång
    tput bold
    tput setaf 1  # Röd text
    
    # Rita ut stor text centrerat
    tput cup $((rows/2 - 4)) $(((cols-60)/2))
    echo "██████  ██    ██    ██   ██  █████  ██████  "
    tput cup $((rows/2 - 3)) $(((cols-60)/2))
    echo "██   ██ ██    ██    ██   ██ ██   ██ ██   ██ "
    tput cup $((rows/2 - 2)) $(((cols-60)/2))
    echo "██   ██ ██    ██    ███████ ███████ ██████  "
    tput cup $((rows/2 - 1)) $(((cols-60)/2))
    echo "██   ██ ██    ██    ██   ██ ██   ██ ██   ██ "
    tput cup $((rows/2)) $(((cols-60)/2))
    echo "██████   ██████     ██   ██ ██   ██ ██   ██ "
    
    tput cup $((rows/2 + 2)) $(((cols-60)/2))
    echo "██████  ██      ██ ██    ██ ██ ████████ "
    tput cup $((rows/2 + 3)) $(((cols-60)/2))
    echo "██   ██ ██      ██ ██    ██ ██    ██    "
    tput cup $((rows/2 + 4)) $(((cols-60)/2))
    echo "██████  ██      ██ ██    ██ ██    ██    "
    tput cup $((rows/2 + 5)) $(((cols-60)/2))
    echo "██   ██ ██      ██  ██  ██  ██    ██    "
    tput cup $((rows/2 + 6)) $(((cols-60)/2))
    echo "██████  ███████ ██   ████   ██    ██    "
    
    tput cup $((rows/2 + 9)) $(((cols-40)/2))
    echo " ██   ██  █████   ██████ ██   ██  █████  ██████  "
    tput cup $((rows/2 + 10)) $(((cols-40)/2))
    echo " ██   ██ ██   ██ ██      ██  ██  ██   ██ ██   ██ "
    tput cup $((rows/2 + 11)) $(((cols-40)/2))
    echo " ███████ ███████ ██      █████   ███████ ██   ██ "
    tput cup $((rows/2 + 12)) $(((cols-40)/2))
    echo " ██   ██ ██   ██ ██      ██  ██  ██   ██ ██   ██ "
    tput cup $((rows/2 + 13)) $(((cols-40)/2))
    echo " ██   ██ ██   ██  ██████ ██   ██ ██   ██ ██████  "
    
    # Visa meddelande i ytterligare 2 sekunder innan nästa fas
    sleep 2
    
    # Återställ färgen
    tput sgr0
    
    # Rensa skärmen innan animationen startar
    clear
}

# Återställ terminalinställningar när skriptet avslutas
function cleanup {
    # Visa "April April" över hela skärmen
    clear
    
    # Hämta skärmstorlek
    local rows=$(tput lines)
    local cols=$(tput cols)
    
    # Centrera texten
    local message="APRIL APRIL!"
    local msg_length=${#message}
    
    # Vänta en kort stund först
    sleep 0.5
    
    # Gör texten stor i ASCII-art stil
    tput bold
    tput setaf 1  # Röd text
    
    # Rita ut stor text centrerat
    tput cup $((rows/2 - 4)) $(((cols-60)/2))
    echo " █████  ██████  ██████  ██ ██      "
    tput cup $((rows/2 - 3)) $(((cols-60)/2))
    echo "██   ██ ██   ██ ██   ██ ██ ██      "
    tput cup $((rows/2 - 2)) $(((cols-60)/2))
    echo "███████ ██████  ██████  ██ ██      "
    tput cup $((rows/2 - 1)) $(((cols-60)/2))
    echo "██   ██ ██      ██   ██ ██ ██      "
    tput cup $((rows/2)) $(((cols-60)/2))
    echo "██   ██ ██      ██   ██ ██ ███████ "
    
    tput cup $((rows/2 + 2)) $(((cols-60)/2))
    echo " █████  ██████  ██████  ██ ██      "
    tput cup $((rows/2 + 3)) $(((cols-60)/2))
    echo "██   ██ ██   ██ ██   ██ ██ ██      "
    tput cup $((rows/2 + 4)) $(((cols-60)/2))
    echo "███████ ██████  ██████  ██ ██      "
    tput cup $((rows/2 + 5)) $(((cols-60)/2))
    echo "██   ██ ██      ██   ██ ██ ██      "
    tput cup $((rows/2 + 6)) $(((cols-60)/2))
    echo "██   ██ ██      ██   ██ ██ ███████ "
    
    # Återställ färgen
    tput sgr0
    
    # Visa meddelande om att skriptet avslutats
    tput cup $((rows-2)) 0
    echo "Animation avslutad efter $SECONDS sekunder."
    
    # Återställ terminalen
    stty echo
    stty sane
    tput cnorm
    
    exit
}

# Se till att rensa upp även om något går fel
trap cleanup EXIT

# Göm markören
tput civis

# Funktion för att rita dödskallen i olika stadier
function draw_skull {
    local stage=$1
    
    # Flytta till övre vänstra hörnet
    tput cup 0 0
    
    case $stage in
        1)
            echo "       .-.       "
            echo "      (o.o)      "
            echo "       |_|       "
            echo "      /|\|\      "
            echo "     / | | \     "
            echo "       | |       "
            echo "       | |       "
            echo "      _| |_      "
            echo "                 "
            echo "     Ha...       "
            ;;
        2)
            echo "       .-.       "
            echo "      (o.o)      "
            echo "       \_/       "
            echo "      /|\|\      "
            echo "     / | | \     "
            echo "       | |       "
            echo "       | |       "
            echo "      _| |_      "
            echo "                 "
            echo "     Ha Ha!      "
            ;;
        3)
            echo "       .-.       "
            echo "      (x.x)      "
            echo "       |_|       "
            echo "      /|\|\      "
            echo "     / | | \     "
            echo "       | |       "
            echo "       | |       "
            echo "      _| |_      "
            echo "                 "
            echo "    HAA HAA!     "
            ;;
        4)
            echo "       .-.       "
            echo "      (o.o)      "
            echo "       \_/       "
            echo "      /|\|\      "
            echo "     / | | \     "
            echo "       | |       "
            echo "       | |       "
            echo "      _| |_      "
            echo "                 "
            echo "   HAHAHA!!!     "
            ;;
    esac
}

# Dela upp skärmen i två tydliga sektioner
function draw_separator {
    local rows=$(tput lines)
    for ((i=0; i<rows; i++)); do
        tput cup $i 20
        echo "|"
    done
}

# Simulera radering av filer från /etc (utan att faktiskt radera)
function fake_delete_files {
    local offset=${1:-0}
    
    # Beräkna kolumnposition för fildelen (starta efter separator)
    local col=22
    local row=0
    
    # Hämta lista på filer i /etc med offset
    local files=$(ls /etc | tail -n +$offset | head -5)
    
    # Om ingen fil hittades (t.ex. om offset är för stort), använd de första 5
    if [ -z "$files" ]; then
        files=$(ls /etc | head -5)
    fi
    
    for file in $files; do
        # Positionera markören i fildelen
        tput cup $row $col
        
        # Rensa resten av raden först för att förhindra överlagring
        tput el
        
        # Visa "radering" av filen med begränsad längd för att undvika radbrytning
        local message="Raderar: /etc/$file"
        if [ ${#message} -gt 35 ]; then
            message="${message:0:32}..."
        fi
        echo -n "$message "
        
        # Öka radnummer för nästa utskrift
        row=$((row + 1))
        
        # Börja om från toppen om vi når slutet av skärmen
        if [ $row -gt $(($(tput lines) - 2)) ]; then
            row=0
        fi
    done
    
    # Separata loop för att visa "KLAR" status med fördröjning
    row=0
    for file in $files; do
        tput cup $row $((col + 36))  # Position efter filnamnet
        echo "KLAR"
        row=$((row + 1))
        
        # Börja om från toppen om vi når slutet av skärmen
        if [ $row -gt $(($(tput lines) - 2)) ]; then
            row=0
        fi
    done
}

# Huvudprogram - Visa hackad meddelande först
show_hacked_message

# Animera dödskallen
draw_separator  # Rita sidoseparatorn en gång i början

start_time=$SECONDS
while [ $SECONDS -lt $MAX_RUNTIME ]; do
    for i in {1..4}; do
        # Rita dödskallen i sitt nuvarande stadium
        draw_skull $i
        
        # Visa filer som raderas
        # Använd olika listor för varje stadium för variation
        offset=$((i * 5))
        fake_delete_files $offset
        
        # Kort paus för animationen
        sleep 0.3
        
        # Avsluta om tiden överskridits
        if [ $SECONDS -ge $MAX_RUNTIME ]; then
            break
        fi
    done
done
