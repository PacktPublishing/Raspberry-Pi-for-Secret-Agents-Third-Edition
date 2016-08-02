#!/bin/bash
# Raspberry Pi for Secret Agents - 3rd Ed
# Matthew Poole - http://cubiksoundz.com

# Adapted from Mohammad Nilforooshan's blog at
# https://sites.google.com/site/mannprofile/home/bashposts/string2morse

#read the input parameter
sText=$1

#replace all spaces with an underscore
sText=$(echo ${sText//' '/_})

#get the string length
nLen=$(echo ${#sText})

#add each character to an array
aText=()
for i in $(seq 0 $(($nLen - 1)))
do
   aText+=(${sText:$i:1})
done

#build the character encoder
#spaces are encoded as ~
declare -A asEncode
asEncode=([_]='~'     \
        [A]='.-'     \
        [B]='-...'   \
        [C]='-.-.'   \
        [D]='-..'    \
        [E]='.'      \
        [F]='..-.'   \
        [G]='--.'    \
        [H]='....'   \
        [I]='..'     \
        [J]='.---'   \
        [K]='-.-'    \
        [L]='.-..'   \
        [M]='--'     \
        [N]='-.'     \
        [O]='---'    \
        [P]='.--.'   \
        [Q]='--.-'   \
        [R]='.-.'    \
        [S]='...'    \
        [T]='-'      \
        [U]='..-'    \
        [V]='...-'   \
        [W]='.--'    \
        [X]='-..-'   \
        [Y]='-.--'   \
        [Z]='--..'   \
        [a]='.-'     \
        [b]='-...'   \
        [c]='-.-.'   \
        [d]='-..'    \
        [e]='.'      \
        [f]='..-.'   \
        [g]='--.'    \
        [h]='....'   \
        [i]='..'     \
        [j]='.---'   \
        [k]='-.-'    \
        [l]='.-..'   \
        [m]='--'     \
        [n]='-.'     \
        [o]='---'    \
        [p]='.--.'   \
        [q]='--.-'   \
        [r]='.-.'    \
        [s]='...'    \
        [t]='-'      \
        [u]='..-'    \
        [v]='...-'   \
        [w]='.--'    \
        [x]='-..-'   \
        [y]='-.--'   \
        [z]='--..'   \
        [0]='-----'  \
        [1]='.----'  \
        [2]='..---'  \
        [3]='...--'  \
        [4]='....-'  \
        [5]='.....'  \
        [6]='-....'  \
        [7]='--...'  \
        [8]='---..'  \
        [9]='----.'  \
        [.]='.-.-.-' \
        [,]='--..--' \
        [:]='---...' \
        [?]='..--..' \
        [-]='-....-' \
        [/]='-..-.'  \
        [=]='-...-'  \
        ["'"]='.----.')

#encode the text for outputing
sOutput=""
for i in $(seq 0 $((`echo ${#aText[@]}`-1)))
do
   sOutput=$(echo $sOutput ${asEncode[`echo ${aText[$i]}`]})
done
#restore spaces and output encoded text
echo $sOutput | tr '~' ' '
