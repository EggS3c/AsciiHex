#!/bin/bash

```java
Function to display help
```

```java
display_help() {
echo "Usage: $0"
echo "Enter hex values to convert to ASCII. Type 'done' when finished."
echo "Valid hex values range from 00 to FF (case insensitive)."
echo ""
echo "Examples:"
echo "47 -> G"
echo "6F -> o"
echo "20 -> (space)"
echo "Type 'done' to see the results."
}
```

```java
Function to set text color
```

```java
set_color() {
case $1 in
"red") echo -e "\e[31m" ;;
"green") echo -e "\e[32m" ;;
"yellow") echo -e "\e[33m" ;;
"blue") echo -e "\e[34m" ;;
"magenta") echo -e "\e[35m" ;;
"cyan") echo -e "\e[36m" ;;
"reset") echo -e "\e[0m" ;;
*) echo -e "\e[0m" ;; # default to reset
esac
}
```

```java
Display help if requested
```

```java
if [[ "$1" == "-h" ]]; then
display_help
exit 0
fi
```

```java
Color options
```

```java
valid_colors=("red" "green" "yellow" "blue" "magenta" "cyan")
random_color=${valid_colors[$RANDOM % ${#valid_colors[@]}]}
```

```java
Prompt for color choice
```

```java
echo "Choose a color for the output (red, green, yellow, blue, magenta, cyan):"
read color_choice
if [[ ! " ${valid_colors[*]} " =~ " $color_choice " ]]; then
echo "Nice try! '$color_choice' is not an option, but I'll pick a random color for you! 😊"
color_choice=$random_color
fi
selected_color=$(set_color $color_choice)
reset_color=$(set_color "reset")
```

```java
Initialize arrays
```

```java
hex_values=()
ascii_output=""
```

```java
Input loop
```

```java
while true; do
echo -n "Hex value: "
read hex_value
if [[ "$hex_value" == "done" ]]; then
break
fi
# Validate hex input
if [[ "$hex_value" =~ ^[0-9A-Fa-f]{2}$ ]]; then
hex_values+=("$hex_value")
ascii_output+=$(printf "\\x$hex_value")
else
echo "Invalid hex value. Please enter a valid hex value (00 to FF)."
fi
done
```

```java
Display results
```

```java
echo "==============================="
echo "      Filtered Results"
echo "==============================="
echo -n "| "
for hex in "${hex_values[@]}"; do
char=$(printf "\\x$hex")
echo -n "$char "
done
echo "|"
echo "==============================="
echo -e "${selected_color}Full ASCII Output: $ascii_output${reset_color}"
```
