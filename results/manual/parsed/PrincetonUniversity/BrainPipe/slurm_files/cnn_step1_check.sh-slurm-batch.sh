#!/bin/bash
#SBATCH --output=logs/cnn_step1_check_%j.out
#SBATCH --error=logs/cnn_step1_check_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000
#SBATCH --time=00:10:00

echo "In the directory: `pwd` "
echo "As the user: `whoami` "
echo "on host: `hostname` "
cat /proc/$$/status | grep Cpus_allowed_list
module load anacondapy/2020.11
. activate brainpipe
echo "Experiment name:" "`pwd`"
echo "Array Index: $SLURM_ARRAY_TASK_ID"
python cell_detect.py 11 0 "`pwd`" 
