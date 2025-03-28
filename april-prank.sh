#!/bin/bash

# Configurable variables
BLINK_COUNT=5

# Language settings - change these to switch language
HACK_MESSAGE="DU HAR BLIVIT HACKAD!"
APRIL_MESSAGE="APRIL APRIL!"
DELETING_TEXT="Raderar:"
DONE_TEXT="KLAR"
ANIMATION_ENDED_TEXT="Animation avslutad efter"
SECONDS_TEXT="sekunder."

# Add some example language settings as comments
# Swedish:
# HACK_MESSAGE="DU HAR BLIVIT HACKAD!"
# APRIL_MESSAGE="APRIL APRIL!"
# DELETING_TEXT="Raderar:"
# DONE_TEXT="KLAR"
# ANIMATION_ENDED_TEXT="Animation avslutad efter"
# SECONDS_TEXT="sekunder."

# English:
# HACK_MESSAGE="YOU HAVE BEEN HACKED!"
# APRIL_MESSAGE="APRIL FOOLS!"
# DELETING_TEXT="Deleting:"
# DONE_TEXT="DONE"
# ANIMATION_ENDED_TEXT="Animation ended after"
# SECONDS_TEXT="seconds."

# German:
# HACK_MESSAGE="SIE WURDEN GEHACKT!"
# APRIL_MESSAGE="APRIL APRIL!"
# DELETING_TEXT="Löschen:"
# DONE_TEXT="FERTIG"
# ANIMATION_ENDED_TEXT="Animation beendet nach"
# SECONDS_TEXT="Sekunden."

# Script runtime
MAX_RUNTIME=30

# Catch interruption signals
trap "" SIGINT SIGTERM SIGTSTP

# Disable keyboard interrupt combinations
stty -echo
stty intr ""
stty susp ""
stty quit ""

# Start a timer to terminate after MAX_RUNTIME seconds
SECONDS=0

# Display flashing message at start
function show_blinking_message {
    local message=$1
    clear
    
    # Get screen size
    local rows=$(tput lines)
    local cols=$(tput cols)
    
    # Function to draw any message in ASCII-art style
    # Adapts the frame dynamically to the text length
    function draw_message_text {
        local text=$1
        
        # Calculate frame width based on text length 
        # (add extra space for margins)
        local padding=4  # Extra space on each side of the text
        local border_width=$((${#text} + padding*2))
        
        # Create a row of asterisks with the right length
        local border_line=""
        for ((i=0; i<border_width; i++)); do
            border_line+="*"
        done
        
        # Create an empty row with asterisks only at the edges
        local empty_line="*"
        for ((i=0; i<(border_width-2); i++)); do
            empty_line+=" "
        done
        empty_line+="*"
        
        # Create the row with the text centered
        local text_padding=""
        local padding_each_side=$(( (border_width - ${#text} - 2) / 2 ))
        for ((i=0; i<padding_each_side; i++)); do
            text_padding+=" "
        done
        local text_line="*${text_padding}${text}${text_padding}"
        
        # If the text length + padding is odd, add an extra space
        if [ $(( (border_width - ${#text} - 2) % 2 )) -ne 0 ]; then
            text_line+=" "
        fi
        text_line+="*"
        
        # Calculate starting positions for centering on screen
        local row_start=$((rows/2 - 2))
        local col_start=$((cols/2 - border_width/2))
        
        # Draw the frame and text
        tput cup $row_start $col_start
        echo "$border_line"
        
        tput cup $((row_start+1)) $col_start
        echo "$empty_line"
        
        tput cup $((row_start+2)) $col_start
        echo "$text_line"
        
        tput cup $((row_start+3)) $col_start
        echo "$empty_line"
        
        tput cup $((row_start+4)) $col_start
        echo "$border_line"
    }
    
    # Blink the text exactly the number of times specified in BLINK_COUNT
    # Each blink consists of showing the text and then hiding it
    blinks_completed=0
    show_text=true
    
    while [ $blinks_completed -lt $BLINK_COUNT ]; do
        if $show_text; then
            # Show the text
            tput bold
            tput setaf 1  # Red text
            draw_message_text "$message"
            show_text=false
        else
            # Hide the text
            clear
            show_text=true
            blinks_completed=$((blinks_completed + 1))
        fi
        
        # Wait a short time
        sleep 0.5
    done
    
    # Regardless of whether the last step was to show or hide the text, 
    # show the text one last time before we continue
    tput bold
    tput setaf 1  # Red text
    draw_message_text "$message"
    
    # Show message for an additional 0.5 seconds before next phase
    sleep 0.5
    
    # Reset color
    tput sgr0
    
    # Clear screen before animation starts
    clear
}

# Reset terminal settings when script exits
function cleanup {
    # Show ending message
    clear
    
    # Get screen size
    local rows=$(tput lines)
    local cols=$(tput cols)
    
    # Wait a short time first
    sleep 0.5
    
    # Show the ending message
    tput bold
    tput setaf 1  # Red text
    
    # Center the message
    local msg_length=${#APRIL_MESSAGE}
    local start_col=$(( (cols - msg_length) / 2 ))
    local start_row=$(( rows / 2 ))
    
    tput cup $start_row $start_col
    echo "$APRIL_MESSAGE"
    
    # Reset color
    tput sgr0
    
    # Show message that the script has ended
    tput cup $((rows-2)) 0
    echo "$ANIMATION_ENDED_TEXT $SECONDS $SECONDS_TEXT"
    
    # Reset terminal
    stty echo
    stty sane
    tput cnorm
    
    exit
}

# Make sure to clean up even if something goes wrong
trap cleanup EXIT

# Hide cursor
tput civis

# Function to draw the skull in different stages
function draw_skull {
    local stage=$1
    
    # Move to upper left corner
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

# Split the screen into two distinct sections
function draw_separator {
    local rows=$(tput lines)
    for ((i=0; i<rows; i++)); do
        tput cup $i 20
        echo "|"
    done
}

# Simulate deletion of files from /etc (without actually deleting)
function fake_delete_files {
    local offset=${1:-0}
    
    # Calculate column position for file section (start after separator)
    local col=22
    local row=0
    
    # Get list of files in /etc with offset
    local files=$(ls /etc | tail -n +$offset | head -5)
    
    # If no file was found (e.g., if offset is too large), use the first 5
    if [ -z "$files" ]; then
        files=$(ls /etc | head -5)
    fi
    
    for file in $files; do
        # Position the cursor in the file section
        tput cup $row $col
        
        # Clear the rest of the line first to prevent overlapping
        tput el
        
        # Show "deletion" of the file with limited length to avoid line breaks
        local message="$DELETING_TEXT /etc/$file"
        if [ ${#message} -gt 35 ]; then
            message="${message:0:32}..."
        fi
        echo -n "$message "
        
        # Increase row number for next print
        row=$((row + 1))
        
        # Start over from the top if we reach the end of the screen
        if [ $row -gt $(($(tput lines) - 2)) ]; then
            row=0
        fi
    done
    
    # Separate loop to show "DONE" status with delay
    row=0
    for file in $files; do
        tput cup $row $((col + 36))  # Position after filename
        echo "$DONE_TEXT"
        row=$((row + 1))
        
        # Start over from the top if we reach the end of the screen
        if [ $row -gt $(($(tput lines) - 2)) ]; then
            row=0
        fi
    done
}

# Main program - Show flashing message first
show_blinking_message "$HACK_MESSAGE"

# Animate the skull
draw_separator  # Draw the side separator once at the beginning

start_time=$SECONDS
while [ $SECONDS -lt $MAX_RUNTIME ]; do
    for i in {1..4}; do
        # Draw the skull in its current stage
        draw_skull $i
        
        # Show files being deleted
        # Use different lists for each stage for variation
        offset=$((i * 5))
        fake_delete_files $offset
        
        # Short pause for animation
        sleep 0.3
        
        # Exit if time has been exceeded
        if [ $SECONDS -ge $MAX_RUNTIME ]; then
            break
        fi
    done
done
