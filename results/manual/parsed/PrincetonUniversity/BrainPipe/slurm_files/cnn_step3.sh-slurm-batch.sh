#!/bin/bash
#SBATCH --output=logs/array_jobs/cnn_step3_job%a_%j.out
#SBATCH --error=logs/array_jobs/cnn_step3_job%a_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=100000
#SBATCH --time=01:40:00
#SBATCH --partition=all

echo "In the directory: `pwd` "
echo "As the user: `whoami` "
echo "on host: `hostname` "
cat /proc/$$/status | grep Cpus_allowed_list
module load anacondapy/2020.11
. activate brainpipe
echo "Experiment name:" "`pwd`"
echo "Array Index: $SLURM_ARRAY_TASK_ID"
python cell_detect.py 3 ${SLURM_ARRAY_TASK_ID} "`pwd`" 
