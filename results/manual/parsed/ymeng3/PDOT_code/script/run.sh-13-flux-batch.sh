#!/bin/bash
#FLUX: --job-name=pdot_dataset1
#FLUX: -c=16
#FLUX: --priority=16

echo "Starting run.sh-13..."
module load julia  # Load Julia module, if available 
julia /home/ymeng3/experiments/code/pdot_code_ans/test/dataset2.jl
if [ $? -eq 0 ]; then
  echo "Julia script completed successfully."
else
  echo "Julia script encountered an error. Check the logs for details."
fi
echo "run.sh-13 completed."
