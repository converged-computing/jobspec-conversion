#!/bin/bash
#FLUX: --job-name=array_test_rnd
#FLUX: --queue=test
#FLUX: -t=30
#FLUX: --urgency=16

module load matlab
iseed=$(($SLURM_ARRAY_JOB_ID+$SLURM_ARRAY_TASK_ID))
echo "iseed = $iseed"
srun -c $SLURM_CPUS_PER_TASK matlab -nosplash -nodesktop -nodisplay -r "rnd_test(10, -2, 2, $iseed); exit"
