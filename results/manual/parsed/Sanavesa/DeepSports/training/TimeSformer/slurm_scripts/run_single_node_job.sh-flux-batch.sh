#!/bin/bash
#FLUX: --job-name=timesformer
#FLUX: -c=80
#FLUX: --queue=partition_of_your_choice
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load cuda/10.0
module load NCCL/2.4.7-1-cuda.10.0
module load cudnn/v7.4-cuda.10.0
source activate timesformer
WORKINGDIR=/path/to/TimeSformer
CURPYTHON=/path/to/python
srun --label ${CURPYTHON} ${WORKINGDIR}/tools/run_net.py --cfg ${WORKINGDIR}/configs/Kinetics/TimeSformer_divST_8x32_224.yaml NUM_GPUS 8 TRAIN.BATCH_SIZE 8
