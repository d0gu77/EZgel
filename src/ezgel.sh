#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "${YELLOW} EZ         _${RESET}"
echo -e "${YELLOW}  __ _  ___| |${RESET}"
echo -e "${YELLOW} / _  |/ _ \ |${RESET}"
echo -e "${YELLOW}| (_| |  __/ |${RESET}"
echo -e "${YELLOW} \__  |\___|_|${RESET}"
echo -e "${YELLOW} |___/${RESET}"
echo -e "${GREEN}Welcome To EZgel${RESET}"

echo -e "${YELLOW}Which action do you want to perform? :${RESET}"
echo -e "1 - Install Package"
echo -e "2 - Remove Package"
echo -e "3 - Search Package"
read -rp "Enter your choice (1/2/3): " choice

case $choice in
    1) 
        echo -e "${YELLOW}Enter the name of the package you want to install:${RESET}"
        read -r package
        echo -e "${YELLOW}Searching for the package: ${package}...${RESET}"
        search_result=$(gel search "$package" 2>/dev/null)
        if echo "$search_result" | grep -q "$package"; then
            echo -e "${GREEN}Package found! Installing ${package}...${RESET}"
            gel install "$package"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}Package installed successfully.${RESET}"
            else
                echo -e "${RED}An error occurred. The package could not be installed.${RESET}"
            fi
        else
            echo -e "${RED}Error: Package ${package} not found.${RESET}"
        fi
        ;;
    2) 
        echo -e "${YELLOW}Enter the name of the package you want to remove:${RESET}"
        read -r package
        echo -e "${YELLOW}Checking for the package: ${package}...${RESET}"
        installed_result=$(gel list 2>/dev/null | grep "$package")
        if [ -n "$installed_result" ]; then
            echo -e "${GREEN}Package found! Removing ${package}...${RESET}"
            gel remove "$package"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}Package removed successfully.${RESET}"
            else
                echo -e "${RED}An error occurred. The package could not be removed.${RESET}"
            fi
        else
            echo -e "${RED}Error: Package ${package} is not installed.${RESET}"
        fi
        ;;
    3) 
        echo -e "${YELLOW}Enter the name of the package you want to search for:${RESET}"
        read -r package
        echo -e "${YELLOW}Searching for the package: ${package}...${RESET}"
        gel search "$package"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Package search completed.${RESET}"
        else
            echo -e "${RED}An error occurred. Package search failed.${RESET}"
        fi
        ;;
    *) 
        echo -e "${RED}Error: Invalid choice.${RESET}"
        ;;
esac
