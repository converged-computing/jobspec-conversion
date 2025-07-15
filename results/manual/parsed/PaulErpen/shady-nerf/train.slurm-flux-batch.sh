#!/bin/bash
#FLUX: --job-name=paul-erpenstein-thesis
#FLUX: --queue=pDLVC
#FLUX: -t=3600
#FLUX: --priority=16

echo "================ ================ ================ ================"
echo "$(date)|$(hostname)|$(pwd)|$(id)"
echo "================ ================ ================ ================"
nvidia-smi
nvidia-smi -L
python3 --version
echo "================ ================ ================ ================"
python3 -m pip install --user -e ./shady-nerf/lodnelf-module
srun --gres=gpu:1 python3 -m lodnelf.train.train_cmd --run_name "experiment_alpha_depth_2" --config "SimpleRedCarModel" --model_save_dir "models/experiment_alpha_depth_2" --data_dir "data"
wait
