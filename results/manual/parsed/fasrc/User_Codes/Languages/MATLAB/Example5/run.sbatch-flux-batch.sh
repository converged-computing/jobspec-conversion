#!/bin/bash
#FLUX: --job-name=stinky-signal-4477
#FLUX: --priority=16

module load matlab
iseed=$(($SLURM_ARRAY_JOB_ID+$SLURM_ARRAY_TASK_ID))
echo "iseed = $iseed"
srun -c $SLURM_CPUS_PER_TASK matlab -nosplash -nodesktop -nodisplay -r "rnd_test(10, -2, 2, $iseed); exit"
