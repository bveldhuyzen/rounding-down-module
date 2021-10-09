#!bin/bash
#Rounds numbers down to whatever decimals you want
#bveldhuyzen [at] gmail dot com
#2021

#echo the number that has to be rounded down here
#e.g. 10, 10.01, 10.10, 1050.11493759834, or whatever
echo "0.4687576465476" > full_number_1.txt
FULL_NUMBER=$(<full_number_1.txt)

#echo the decimals to which the module has to round down to (floor)
echo "0.020" > round_to_this.txt
ROUND_TO_THIS=$(<round_to_this.txt)

#rounding down to integer
echo $FULL_NUMBER | awk '{print int($0)}' > integer.txt
INTEGER=$(<integer.txt)

#leftover decimals
calc -d "$FULL_NUMBER - $INTEGER" > leftover_decimals.txt
DECIMALS=$(<leftover_decimals.txt)

#steps to take into integer
calc -d "$DECIMALS / $ROUND_TO_THIS" > steps_into_integer.txt
STEPS_INTO_INTEGER=$(<steps_into_integer.txt)

echo $STEPS_INTO_INTEGER | awk '{print int($0)}' > steps_into_integer_total.txt
STEPS_INTO_INTEGER_TOTAL=$(<steps_into_integer_total.txt)

#rounding of some sort
calc -d "$STEPS_INTO_INTEGER_TOTAL * $ROUND_TO_THIS" > new_decimals.txt
NEW_DECIMALS=$(<new_decimals.txt)

#new rounded number
calc -d "$INTEGER + $NEW_DECIMALS" > rounded_number.txt
cat rounded_number.txt

#read -p 'pause'

rm full_number_1.txt round_to_this.txt integer.txt leftover_decimals.txt steps_into_integer.txt steps_into_integer_total.txt new_decimals.txt rounded_number.txt


#V
