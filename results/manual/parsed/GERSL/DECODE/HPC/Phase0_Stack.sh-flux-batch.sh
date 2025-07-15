#!/bin/bash
#FLUX: --job-name=astute-motorcycle-5797
#FLUX: --queue=priority
#FLUX: --priority=16

echo $SLURMD_NODENAME  # display the node name
module load matlab
cd /home/xiy19029/DECODE_v2_Share/
matlab -nodisplay -nosplash -singleCompThread -r "batchDECODE_Phase0_Stack($SLURM_ARRAY_TASK_ID, $SLURM_ARRAY_TASK_MAX);exit"; 
echo 'Finished Matlab Code at '
