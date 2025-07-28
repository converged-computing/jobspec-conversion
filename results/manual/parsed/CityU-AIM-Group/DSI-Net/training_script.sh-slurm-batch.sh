#!/bin/bash
#FLUX: --job-name=training
#FLUX: -c=2
#FLUX: --queue=gpu_1d2g
#FLUX: --urgency=16

echo "Submitted from:"$SLURM_SUBMIT_DIR" on node:"$SLURM_SUBMIT_HOST
echo "Running on node "$SLURM_JOB_NODELIST 
echo "Allocate Gpu Units:"$CUDA_VISIBLE_DEVICES
nvidia-smi
python train_DSI_Net.py --gpus 0 --K 100 --alpha 0.05 --image_list 'data/WCE/WCE_Dataset_image_list.pkl'
