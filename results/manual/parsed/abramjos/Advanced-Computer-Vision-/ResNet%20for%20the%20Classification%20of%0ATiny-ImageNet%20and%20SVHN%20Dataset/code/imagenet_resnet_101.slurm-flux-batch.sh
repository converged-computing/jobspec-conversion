#!/bin/bash
#FLUX: --job-name=IN_RES101
#FLUX: -c=16
#FLUX: -t=388740
#FLUX: --priority=16

date
echo "Slurm nodes: $SLURM_JOB_NODELIST"
NUM_GPUS=`echo $GPU_DEVICE_ORDINAL | tr ',' '\n' | wc -l`
echo "You were assigned $NUM_GPUS gpu(s)"
module load anaconda
source activate pyt
echo
echo " Started Training"
echo "=================================================================================================="
echo "Training 500.."
python imagenet.py --length 500 --epoch 5000 --model_name resnet_101 --log-interval 100
echo "Training 350.."
python imagenet.py --length 350 --epoch 5000 --model_name resnet_101 --log-interval 100
echo "Training 150.."
python imagenet.py --length 150 --epoch 5000 --model_name resnet_101 --log-interval 100
echo "=================================================================================================="
echo "Training Complete"
echo "Ending script..."
date
