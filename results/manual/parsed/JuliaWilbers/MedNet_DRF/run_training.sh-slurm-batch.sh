#!/bin/bash
#SBATCH --output=/trinity/home/jwilbers/MedNet/output/out_%j.log
#SBATCH --error=/trinity/home/jwilbers/MedNet/error/err_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=14G
#SBATCH --time=2-00:00:00

module purge
module load Python/3.7.2-GCCcore-8.2.0
source "/trinity/home/jwilbers/MedNet/MedicalNet/venv_mednet_2/bin/activate"
python train.py --gpu_id 0 --batch_size 1 --num_workers 1 --model_depth 10 --pretrain_path pretrain/resnet_10.pth 
