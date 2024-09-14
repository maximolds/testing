#!/bin/bash

# File to store encoded data
output_file="input.txt"

# Function to encode the input
encode_data() {
	echo -e "${Text_Green}$1${No_Color}:${Text_Yellow}$2${No_Color}:${Text_Blue}$3"
}

# Define color and text formatting codes
Text_Blue='\033[0;34m'
Text_Bold='\033[1m'
Underline='\033[4m'
Text_Green='\033[0;32m'
Text_Yellow='\033[1;33m'
Text_Red='\033[0;31m'
No_Color='\033[0m' # No Color or Reset
Combo_Text="${Text_Blue}${Text_Bold}${Underline}"
Bold_Green="${Text_Green}${Text_Bold}"
Thumbs_up="👍"

# Clear the file if it already exists
>>$output_file

# Function to check the number of people for a given team and shift
check_limit() {

	local team="$1"
	local shift="$2"
	local count

	count=$(grep -i "$team" "$output_file" | grep -i "$shift" | wc -l)
	if [ "$count" -ge 2 ]; then
		echo -e "\n${RED}Limit reached for ${YELLOW}$team ${RED}in ${YELLOW}$shift ${RED}shift."
		return 1
	else
		return 0
	fi

}

# Function to get the total number of people for all teams and shifts
total_count() {

	local total
	total=$(grep -i "$1" "$output_file" | grep -i "$2" | wc -l)
	echo "$total"

}
	echo -e "\n ${Text_Green}To print all inputs, type ${Text_Red}PRINT"


while true; do

	read -p "$(echo -e "\n${Combo_Text}=============================${No_Color}\n${Bold_Green}Enter Name:${No_Color} ")" name
	name=$(echo "$name" | tr '[:lower:]' '[:upper:]')

	if [[ "$name" == "PRINT" ]]; then

		echo -e "\n${Combo_Text}=============================${Text_Yellow}ENCODED DATA${Combo_Text}=============================${No_Color}"
		echo -e "\n${Combo_Text}--- ${Text_Yellow}A1 ${Combo_Text}---${No_Color}"
		cat $output_file | grep -i a1 | grep -i morning | awk -F: '{print $1",", $2",",  "6AM - 3PM"}'
		cat $output_file | grep -i a1 | grep -i mid | awk -F: '{print $1",", $2",",  "2PM - 11PM"}'
		cat $output_file | grep -i a1 | grep -i night | awk -F: '{print $1",", $2",",  "10PM - 7AM"}'

		echo -e "\n${Combo_Text}--- ${Text_Yellow}A2 ${Combo_Text}---${No_Color}"
		cat $output_file | grep -i a2 | grep -i morning | awk -F: '{print $1",", $2",",  "6AM - 3PM"}'
		cat $output_file | grep -i a2 | grep -i mid | awk -F: '{print $1",", $2",",  "2PM - 11PM"}'
		cat $output_file | grep -i a2 | grep -i night | awk -F: '{print $1",", $2",",  "10PM - 7AM"}'

		echo -e "\n${Combo_Text}--- ${Text_Yellow}B1 ${Combo_Text}---${No_Color}"
		cat $output_file | grep -i b1 | grep -i morning | awk -F: '{print $1",", $2",",  "6AM - 3PM"}'
		cat $output_file | grep -i b1 | grep -i mid | awk -F: '{print $1",", $2",",  "2PM - 11PM"}'
		cat $output_file | grep -i b1 | grep -i night | awk -F: '{print $1",", $2",",  "10PM - 7AM"}'

		echo -e "\n${Combo_Text}--- ${Text_Yellow}B2 ${Combo_Text}---${No_Color}"
		cat $output_file | grep -i b2 | grep -i morning | awk -F: '{print $1",", $2",",  "6AM - 3PM"}'
		cat $output_file | grep -i b2 | grep -i mid | awk -F: '{print $1",", $2",",  "2PM - 11PM"}'
		cat $output_file | grep -i b2 | grep -i night | awk -F: '{print $1",", $2",",  "10PM - 7AM"}'

		echo -e "\n${Combo_Text}--- ${Text_Yellow}B3 ${Combo_Text}---${No_Color}"
		cat $output_file | grep -i b3 | grep -i morning | awk -F: '{print $1",", $2",",  "6AM - 3PM"}'
		cat $output_file | grep -i b3 | grep -i mid | awk -F: '{print $1",", $2",",  "2PM - 11PM"}'
		cat $output_file | grep -i b3 | grep -i night | awk -F: '{print $1",", $2",",  "10PM - 7AM"}'

		echo -e "\n${Text_Red}Exiting..."
		exit 0
	fi



	# Validate shift input
	while true; do
		read -p "$(echo -e "\n${Bold_Green}Enter Shift ${Text_Yellow}(MORNING, MID, NIGHT)${No_Color}: ")" shift
		shift=$(echo "$shift" | tr '[:lower:]' '[:upper:]')

		if [[ "$shift" == "MORNING" || "$shift" == "MID" || "$shift" == "NIGHT" ]]; then
			break
		else
			echo -e "\n${Text_Red}INVALID SHIFT! Please enter a valid shift code ${No_Color}(e.g., ${Text_Yellow}MORNING, MID, NIGHT.${No_Color})."
			echo -e "\n${Text_Red}Exiting..."
			exit 1
		fi
	done

	# Validate team input
	while true; do
		read -p "$(echo -e "\n${Bold_Green}Enter Team ${Text_Yellow}(A1,A2,B1.B2,B3)${No_Color}: ")" team
		team=$(echo "$team" | tr '[:lower:]' '[:upper:]')

		if [[ "$team" == "A1" || "$team" == "A2" || "$team" == "B1" || "$team" == "B2" || "$team" == "B3" ]]; then
			echo -e "${Combo_Text}=============================${No_Color}"
			break
		else
			echo -e "\n${Text_Red}INVALID TEAM! PLEASE ENTER A VALID TEAM CODE ${No_Color}(e.g., ${Text_Yellow}A1, B2, etc.${No_Color})."
			echo -e "\n${Text_Red}Exiting..."
			exit 1
		fi
	done

	# Check if adding a new entry exceeds the limit
	if check_limit "$team" "$shift"; then
		# Encode the input and store it in the file
		encoded_data=$(encode_data "$name" "$shift" "$team")
		echo "$encoded_data" >>$output_file

		echo -e "\n${Text_Green}DATA ENCODED AND STORED. ${Thumbs_up}"
	else
		echo -e "\n${Text_Red}CANNOT ADD MORE PEOPLE TO ${Text_Yellow} $team ${Text_Red}IN ${Text_Yellow}$shift ${Text_Red}SHIFT."
		echo -e "\n${Text_Red}Exiting..."
		exit 1
	fi

done
