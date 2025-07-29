#!/bin/bash
#SBATCH --job-name=pdot_dataset1
#SBATCH --account=pi-haihaolu
#SBATCH --output=/home/ymeng3/result/result13.txt
#SBATCH --error=/home/ymeng3/result/error13.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=16G

echo "Starting run.sh-13..."
module load julia  # Load Julia module, if available 
julia /home/ymeng3/experiments/code/pdot_code_ans/test/dataset2.jl
if [ $? -eq 0 ]; then
  echo "Julia script completed successfully."
else
  echo "Julia script encountered an error. Check the logs for details."
fi
echo "run.sh-13 completed."
