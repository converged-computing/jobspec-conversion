#!/bin/bash
#FLUX: --job-name="sleepy"
#FLUX: -n=10
#FLUX: -t=18900
#FLUX: --priority=16

module load R-intel
cd /vlsci/VR0212/shared/NicheMapR_Working/projects/sleepy/
for i in `seq 1 $SLURM_NTASKS`
do
    srun --nodes=1 --ntasks=1 --cpus-per-task=1 R --no-save --args $(($SLURM_ARRAY_TASK_ID*$SLURM_NTASKS+$i)) 0 < sleepy_soilmoist.R &
done
wait
