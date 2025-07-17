#!/bin/bash
#FLUX: --job-name=res_v3
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module restore mymodules
echo "Using GPU Device:"
echo $CUDA_VISIBLE_DEVICES
python /home-4/tkim60@jhu.edu/scratch/dev/nturgbd/train.py --gpu=$CUDA_VISIBLE_DEVICES > /home-4/tkim60@jhu.edu/scratch/dev/nturgbd/TKTCN_D0.5_L9_F8_resnet_v3_raw2_$SLURM_JOBID.log
echo "Finished with job $SLURM_JOBID"
