#!/bin/bash
#SBATCH --job-name=paul-erpenstein-thesis
#SBATCH --account=dlvc
#SBATCH --output=slurm_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8192mb
#SBATCH --time=01:00:00
#SBATCH --partition=pDLVC

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
