#!/bin/bash
# give instructions for madmax

pool_contract_address=
farmer_public_key=

echo "What is your temp directory?"
read temp_dir

echo "What is your final directory?"
read final_dir

echo "How many threads?" 
read threads

echo "Here is available space"
df -h $final_dir --output=size,avail,pcent,target

# find out how much space is available
space_left=$(df $final_dir --output=avail | awk 'END {print $1}')
size_of_plot=102
# echo "one plot equals" $size_of_plot"G" 

# convert to GB
space_left_gb=$(($space_left / 1024 / 1024))
number_of_plots=$(($space_left_gb / $size_of_plot))

echo "Approximate plots left: "$number_of_plots

echo "./chia_plot" \
-n $(($number_of_plots - 1)) \
-r $threads \
-t $temp_dir \
-d $final_dir \
-f $farmer_public_key \
-c $pool_contract_address

echo "Does this look right?"
read answer

if [ $answer = "y" ]; then
  cd ~/chia-plotter/build
  screen ./chia_plot \
  -n $(($number_of_plots - 1)) \
  -r $threads \
  -t $temp_dir \
  -d $final_dir \
  -f $farmer_public_key \
  -c $pool_contract_address
fi
