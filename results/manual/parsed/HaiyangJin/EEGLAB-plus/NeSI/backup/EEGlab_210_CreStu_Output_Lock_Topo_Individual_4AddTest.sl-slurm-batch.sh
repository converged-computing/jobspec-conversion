#!/bin/bash
#FLUX: --job-name=210_Iscr
#FLUX: --queue=bigmem
#FLUX: -t=1800
#FLUX: --urgency=16

module load MATLAB/2017b
srun matlab -nodesktop -nosplash -r EEGlab_210_CreStu_Output_Lock_Topo_v3 $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_JOB_ID
