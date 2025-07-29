#!/bin/bash
#SBATCH --job-name=enduro_SL
#SBATCH --output=output_file_enduro.out
#SBATCH --error=error_file_enduro.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

echo "---------------------------"
echo "Job started on" `date`
source ~/.bashrc ##source conda 
conda config --env --add channels conda-forge 
python SL_python.py
echo "---------------------------"
echo "Job ended on" `date`
