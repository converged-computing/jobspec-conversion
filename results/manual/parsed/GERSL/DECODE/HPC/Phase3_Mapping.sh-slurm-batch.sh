#!/bin/bash
#FLUX: --job-name=joyous-cat-6236
#FLUX: --queue=priority
#FLUX: --urgency=16

echo $SLURMD_NODENAME  # display the node name
module load matlab
cd /home/xiy19029/DECODE_v2_Share/
matlab -nodisplay -nosplash -singleCompThread -r "batchDECODE_Phase3_Mapping($SLURM_ARRAY_TASK_ID, $SLURM_ARRAY_TASK_MAX);exit"; 
echo 'Finished Matlab Code at '
