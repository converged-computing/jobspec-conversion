#!/bin/bash
#FLUX: --job-name=GradientBoostingRegressor
#FLUX: -c=4
#FLUX: -t=86710
#FLUX: --priority=16

 #for i in "${!SPECIES[@]}"; do sbatch GBR.sh "${SPECIES[i]}" "${TRAIT[i]}"; done
SPECIES=$1
TRAIT=$2
mkdir GBR_results #generate the directory where the results will go.
python_success=true
for TRAIT in $(seq 1 $TRAIT); do
   for CV in {1..5}; do
      for FOLD in {1..2}; do
         echo "Running with arguments: $SPECIES, TRAIT=$TRAIT, CV=$CV, FOLD=$FOLD"
         python GBR_na.py "$SPECIES" "$TRAIT" "$CV" "$FOLD" # To execute your Python script. It can be modified to run for testing estimators or number of samples
         python_exit_status=$? # Capture the exit status of the Python script
         if [ $python_exit_status -ne 0 ]; then
            python_success=false
            echo "Python script execution failed."
            break 3  # Exit the outer loop if Python script fails
         fi
      done
   done
done
if $python_success; then
   echo "Python Script execution completed."
fi
