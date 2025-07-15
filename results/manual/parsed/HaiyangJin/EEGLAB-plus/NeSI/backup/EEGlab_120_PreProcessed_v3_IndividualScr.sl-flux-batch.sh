#!/bin/bash
#FLUX: --job-name=120_Iscr
#FLUX: --queue=bigmem
#FLUX: -t=600
#FLUX: --urgency=16

module load MATLAB/2017b
srun matlab -nodesktop -nosplash -r EEGlab_120_PreProcessed_v3 $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_JOB_ID
