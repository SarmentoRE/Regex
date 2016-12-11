#! /bin/bash

file=${1}
re1="\b[0-9]+[A-Za-z]+[0-9A-Za-z]*\b|\b[A-Za-z]+[0-9]+[0-9A-Za-z]*\b"
alphanumerical=0
re2="\b[0-9]+\b"
numerical=0


printf "Number of lines in the file: "
wc -l $1

printf "\nNumber of words in the file: "
wc -w $1

printf "\nThe most repeated word is: "
tr '[:space:]' '[\n*]' < $1 | sort | uniq -c | sort | tail -1

printf "\nThe least reapeated word is: "
tr '[:space:]' '[\n*]' < $1 | sort | uniq -c | sort | head -1

printf "\nThe number of words that start and end with d/D: "
grep -o '\b[dD][\da-zA-Z]*[dD]\b' $1 | wc -w

printf "\nThe number of words that start with A/a: "
grep -o '\b[aA]' $1 | wc -w

#printf "\nThe number of numeric words: "
#grep -o '\b[\d]+\b' $1 | wc -w 

#printf "\nThe number of alphanumeric words: "
#grep -o '\b[0-9]+[A-Za-z]+[0-9A-Za-z]*\b|\b[A-Za-z]+[0-9]+[A-Za-z0-9]*\b' $1 | wc -w

while read -r line
do
    words=${line}
    for word in $words
    do
        if [[ $word =~ $re1 ]]; then
            alphanumerical=$((alphanumerical+1))
        fi
        if [[ $word =~ $re2 ]]; then
            numerical=$((numerical+1))
        fi
    done
done < ${file}

printf "\n The number of numeric words: %d" "$numerical"
printf "\n The number of alphanumerical words:  %d" "$alphanumerical"
