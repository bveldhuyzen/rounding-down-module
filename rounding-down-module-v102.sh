#!/bin/bash
#Rounds any number down to the nearest (multiple of) specified decimal(s).
#v1.02
#github.com/bveldhuyzen
#2021
#
#
#To be configured before use.
#
#The script works as followed:
#
#1. The number (from list) that is to be rounded down becomes a variable; this is called the FULL_NUMBER // see line 22
#2. The decimals to which [1] has to be rounded down to are obtained; the module will round down to the nearest (multiple of) these specified decimals // see line 25
#3. A multiplication factor is generated; how many times does [2] fit into [1]
#4. In case the multiplication factor is not a whole number, the multiplication factor will be its integer
#5. The numerical value to round down to at [2] is multiplied by the multiplication factor of [3], resulting in a new numerical value that is rounded down to [2]
#6. ROUNDED_NUMBER is then logged into a text file
#
#
#All steps/significances are logged into temporary text files for validation purposes

echo "12.23" > full_number_1.txt
FULL_NUMBER=$(<full_number_1.txt)

echo "0.75" > round_to_this.txt
ROUND_TO_THIS=$(<round_to_this.txt)

calc -d "$FULL_NUMBER / $ROUND_TO_THIS" > MPF.txt
MPF=$(<MPF.txt)

echo $MPF | awk '{print int($0)}' > MULTIPLICATION_FACTOR_total.txt
MULTIPLICATION_FACTOR_TOTAL=$(<MULTIPLICATION_FACTOR_total.txt)

calc -d "$MULTIPLICATION_FACTOR_TOTAL * $ROUND_TO_THIS" > rounded_down_number.txt
ROUNDED_DOWN_NUMBER=$(<rounded_down_number.txt)

bash -c "[ -d LIST_DATE_TEST.txt ] && rm LIST_DATE_TEST.txt"
touch LIST_DATE_TEST.txt
echo "$ROUNDED_DOWN_NUMBER" >> LIST_DATE_TEST.txt
#
#read -p 'pause'

rm full_number_1.txt round_to_this.txt MPF.txt MULTIPLICATION_FACTOR_total.txt rounded_down_number.txt


#V
