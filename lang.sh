#!/bin/bash

usage()
{
cat << EOF
usage: $0 [-c] <column index> [-i] <input file location> [-o] <output type> [-s] <separator> 

This script converts csv to language files.

OPTIONS:
   -i      Input file location (tab separated csv), default: lang.csv
   -o      Output file type (json, php, android, ios)
   -c      Column index of language (e.g. 2)
   -s      IFS (Internal field separator), default: tab
EOF
}

INPUT="lang.csv"
OUTPUT="json"
COLINDEX=1
SEPARATOR='	'

while getopts “hi:o:c:s:” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         i)
             INPUT=$OPTARG
             ;;
         o)
             OUTPUT=$OPTARG
             ;;
         c)
             COLINDEX=$OPTARG
             ;;
         s)
             SEPARATOR=$OPTARG
             ;;
     esac
done

while IFS=$SEPARATOR read key col1 col2 col3 col4 col5 col6 col7
do
    case "$COLINDEX" in
    "1")
        col=$col1
        ;;
    "2")
        col=$col2
        ;;
    "3")
        col=$col3
        ;;
    "4")
        col=$col4
        ;;
    "5")
        col=$col5
        ;;
    "6")
        col=$col6
        ;;
    *)
        col=$col1
        ;;
    esac
    case "$OUTPUT" in
    "php")
        echo "\"$key\" => \"$col\","
        ;;
    "android")
        echo "<string name=\"$key\">$col</string>"
        ;;
    "ios")
        echo "$key = \"$col\";"
        ;;
    *)
        echo "\"$key\": \"$col\","
        ;;
    esac
done < $INPUT