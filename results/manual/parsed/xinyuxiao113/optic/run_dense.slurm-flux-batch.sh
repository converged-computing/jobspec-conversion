#!/bin/bash
#FLUX: --job-name=delicious-peanut-5369
#FLUX: --urgency=16

module load spack
module add cuda-11.4.2-gcc-11.2.0-rxy4qhm            # 载入 CUDA 9.0 模块
module add cudnn-8.2.4.15-11.4-gcc-11.2.0-a6q32ad
module add gcc/11.2.0  
module add anaconda           # 载入 anaconda 模块
source ~/.bashrc
conda activate commplax
python train_meta_model.py --method dense --step 3 --save_path loading/dense_step3
python train_meta_model.py --method dense --step 4 --save_path loading/dense_step4
python train_meta_model.py --method dense --step 5 --save_path loading/dense_step5
