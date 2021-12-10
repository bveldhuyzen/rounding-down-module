#!/bin/bash
#Rounds any number down to the nearest (multiple of) specified decimal(s).
#
#github.com/bveldhuyzen
#2021
#
#
#To be configured before use is marked with ###
#
#Furthermore, the script works as followed:
#
#1. The numerical value (any number) that is to be rounded down is obtained; this is called the FULL_NUMBER // see line 25-26
#2. The numerical value (decimal(s)) to which [1] has to be rounded down to is obtained; the module will round down to the nearest (multiple of) this specified numerical value (decimal(s)) // see line 36-37
#3. Of the numerical value [1] is obtained its integer, for which a new variable is created
#4. Of the numerical value [1] are obtained the decimals, for which a new variable is created
#5. A multiplication factor is generated; how many times does [2] fit into [4]
#6. The numerical value to round down to at [2] is multiplied by the multiplication factor of [5], resulting in a new decimal numerical value that is rounded down to [2]. 
#7. The numerical value at [6] is now rounded down to the nearest (multiple of) specified decimals at [2]. And so we can add up: INTEGER + NEW_DECIMALS = ROUNDED_NUMBER
#
#All steps/significances are logged into temporary text files for validation purposes

#[1]
###echo the number that has to be rounded down at line 25
#e.g. 10, 10.01, 10.10, 1050.11493759834, or whatever
echo "0.4687576465476" > full_number_1.txt
FULL_NUMBER=$(<full_number_1.txt)

#you may also # line 25 and 26, and have the script obtain the numerical value from another source, e.g. another file (but the file can only contain one numerical value), e.g.

#FULL_NUMBER=$(<your_file.txt)

#[2]
###echo the decimals to which the module has to round down to at line 36
#e.g. 0.05 will make the module round down to the nearest (multiple of) 0.05.
#e.g. 1.890024 will then be rounded down to 1.85
echo "0.020" > round_to_this.txt
ROUND_TO_THIS=$(<round_to_this.txt)

#[3]
#rounding down to integer
echo $FULL_NUMBER | awk '{print int($0)}' > integer.txt
INTEGER=$(<integer.txt)

#[4]
#leftover decimals
calc -d "$FULL_NUMBER - $INTEGER" > leftover_decimals.txt
DECIMALS=$(<leftover_decimals.txt)

#[5]
#generating multiplication factor
calc -d "$DECIMALS / $ROUND_TO_THIS" > MULTIPLICATION_FACTOR.txt
MULTIPLICATION_FACTOR=$(<MULTIPLICATION_FACTOR.txt)

echo $MULTIPLICATION_FACTOR | awk '{print int($0)}' > MULTIPLICATION_FACTOR_total.txt
MULTIPLICATION_FACTOR_TOTAL=$(<MULTIPLICATION_FACTOR_total.txt)

#[6]
#rounding of some sort  
calc -d "$MULTIPLICATION_FACTOR_TOTAL * $ROUND_TO_THIS" > new_decimals.txt
NEW_DECIMALS=$(<new_decimals.txt)

#[7]
#new rounded number
calc -d "$INTEGER + $NEW_DECIMALS" > rounded_number.txt
cat rounded_number.txt
ROUNDED_NUMBER=$(<rounded_number.txt)

#you may for example store the rounded number in a file of choice to create a list, e.g.
#
#touch LIST_DATE.txt
#echo "$ROUNDED_NUMBER" >> LIST_DATE.txt
#
#read -p 'pause'

rm full_number_1.txt round_to_this.txt integer.txt leftover_decimals.txt MULTIPLICATION_FACTOR.txt MULTIPLICATION_FACTOR_total.txt new_decimals.txt rounded_number.txt


#V
