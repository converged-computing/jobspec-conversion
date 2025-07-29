#!/bin/bash
#SBATCH --output=/scratch/zmd/logs/cnn_preprocess_%j.out
#SBATCH --error=/scratch/zmd/logs/cnn_preprocess_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=all

echo "In the directory: `pwd` "
echo "As the user: `whoami` "
echo "on host: `hostname` "
cat /proc/$$/status | grep Cpus_allowed_list
cat /proc/meminfo
module load anacondapy/5.3.1
. activate lightsheet
echo "Experiment name:" "$1"
echo "Storage directory:" "$2"
OUT0=$(sbatch slurm_scripts/cnn_step0.sh "$1" "$2") 
echo $OUT0
OUT1=$(sbatch --dependency=afterany:${OUT0##* } --array=0-130 slurm_scripts/cnn_step1.sh "$1" "$2") 
echo $OUT1
OUT2=$(sbatch --dependency=afterany:${OUT1##* } slurm_scripts/cnn_step1_check.sh "$1" "$2") 
echo $OUT2
