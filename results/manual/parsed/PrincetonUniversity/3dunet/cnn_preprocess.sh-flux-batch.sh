#!/bin/bash
#FLUX: --job-name=bumfuzzled-banana-3231
#FLUX: --urgency=16

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
