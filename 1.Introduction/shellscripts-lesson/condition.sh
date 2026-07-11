#!/bin/bash

username="$1" 

if [ -z $username ]; then 
    echo " ⚠️ Username cannot be empty!! " 
    exit 1 # close the program / script 
fi 


echo "Hello : ${username^^}" #^^ will convert name to uppercase
echo -n "Please input your age: " # -n remove newline 
read age

echo "Your age is : ${age}"
if [[ $age -ge 18 ]]; then 
    echo " ✅ You are elligible for the scholarship "
else 
    echo " ❌ You are too young for the scholarship" 
fi 

echo -e "\n C-Style condition " 
if (( $age >= 18 )); then 
    echo " ✅ You are an adult " 
else 
    echo " ❌ you are not an adult" 
fi 