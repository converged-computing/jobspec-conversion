#!/bin/bash
#SBATCH --job-name=whi
#SBATCH --output=whi_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100GB
#SBATCH --time=2-00:00:00
#SBATCH --array=0
#SBATCH --exclude=hpc1,hpc2,hpc3,hpc4,hpc5,hpc6,hpc7,hpc8,hpc9,vine3,vine4,vine6,vine11,vine12,lion17,rose7,rose8,rose9

module purge
module load cuda-10.0
source /home/eo41/venv/bin/activate
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_whitebox.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/imagenet/' --model-name 'moco_v2' 
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_whitebox.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/imagenet/' --model-name 'resnet50'
echo "Done"
