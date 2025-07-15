#!/bin/bash
#FLUX: --job-name=pusheena-muffin-4773
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=240000
#FLUX: --priority=16

module load any/python/3.8.3-conda
conda activate controlnet
nvidia-smi
gcc --version
P_PATH=/gpfs/space/home/zaliznyi/miniconda3/envs/controlnet/bin/python
$P_PATH tutorial_train.py --dataset laion --max_time 00:3:00:00 --experiment_name laion_conv_fixed_time_1 --resume_path control_lite_conv_ini.ckpt --model_config cldm_lite_conv.yaml --learning_rate 1e-4 --logger_dir /gpfs/space/home/zaliznyi/wandb
