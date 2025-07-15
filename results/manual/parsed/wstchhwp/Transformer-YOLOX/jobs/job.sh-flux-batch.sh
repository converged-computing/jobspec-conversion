#!/bin/bash
#FLUX: --job-name=gpujob
#FLUX: --queue=gpu
#FLUX: --priority=16

export YOLOX_DATADIR='~/scratch/'

export YOLOX_DATADIR=~/scratch/
module load lang/python/anaconda/3.8.8-2021.05-torch
module load lang/gcc/9.3.0
cd "${SLURM_SUBMIT_DIR}"
cd ../..
source work-env/bin/activate
cd yolox-pytorch
python train.py gpus='0,1,2,3' backbone="SwinTiny-s" num_epochs=20 exp_id="GPUNodetest2" use_amp=True val_intervals=2 data_num_workers=6 batch_size=128
sleep 60
