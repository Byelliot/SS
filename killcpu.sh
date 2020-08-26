top -b1 -n1 | sed '1,5d' | awk '{if($9>=98.00)print}' | awk '{print $1}' | xargs kill -9 {}
