#!/bin/bash
#FLUX: --job-name=SU_LOUO8
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

module restore mymodules
module load tensorflow/cuda-8.0/r1.0
echo "Using GPU Device:"
echo $CUDA_VISIBLE_DEVICES
python /home-4/tkim60@jhu.edu/scratch/dev/jigsaws/train_jigsaws.py --gpu=$CUDA_VISIBLE_DEVICES > /home-4/tkim60@jhu.edu/scratch/dev/jigsaws/LOUO8_SU_$SLURM_JOBID.log
echo "Finished with job $SLURM_JOBID"
