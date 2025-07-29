#!/bin/bash
#FLUX: --job-name=104
#FLUX: -c=2
#FLUX: --queue=bigmem
#FLUX: -t=72000
#FLUX: --urgency=16

module load MATLAB/2017b
srun matlab -nodesktop -nosplash -r EEGlab_102_Pre_Batch_v3 $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_JOB_ID
