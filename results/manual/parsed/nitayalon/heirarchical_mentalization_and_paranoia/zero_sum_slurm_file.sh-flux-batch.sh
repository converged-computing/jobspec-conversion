#!/bin/bash
#FLUX: --job-name=delicious-noodle-2897
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: --queue=compute
#FLUX: -t=87150
#FLUX: --urgency=16

export SINGULARITY_BIND='/run,/ptmp,/scratch,/tmp,/opt/ohpc,${HOME}'
export CONTAINER_PATH='/ptmp/containers/pytorch_1.10.0-cuda.11.3_latest-2021-12-02-ec95d31ea677.sif'

module purge
module load singularity
export SINGULARITY_BIND="/run,/ptmp,/scratch,/tmp,/opt/ohpc,${HOME}"
export CONTAINER_PATH=/ptmp/containers/pytorch_1.10.0-cuda.11.3_latest-2021-12-02-ec95d31ea677.sif
GAME=G_1
SOFTMAX_TEMP=0.1
DURATION=12
Aleph_Ipomdp=False
DELTA=1.1
echo "Simulating with seed $SLURM_ARRAY_TASK_ID"
time singularity exec ${CONTAINER_PATH} python zero_sum_game/zero_sum_game_task.py  --payout_matrix $GAME --seed $SLURM_ARRAY_TASK_ID --softmax_temp $SOFTMAX_TEMP --duration $DURATION --aleph_ipomdp $Aleph_Ipomdp --strong_typicality_delta $DELTA 
