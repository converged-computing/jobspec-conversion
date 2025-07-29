#!/bin/bash
#SBATCH --job-name=ina
#SBATCH --output=ina_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=16GB
#SBATCH --time=06:00:00
#SBATCH --array=0
#SBATCH --exclude=hpc1,hpc2,hpc3,hpc4,hpc5,hpc6,hpc7,hpc8,hpc9,vine3,vine4,vine6,vine11,vine12,lion17,rose7,rose8,rose9

module purge
module load cuda-10.0
source /home/eo41/venv/bin/activate
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_imageneta.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/imagenet_a/' --model-name 'moco_v2'
python -u /misc/vlgscratch4/LakeGroup/emin/oos_benchmarks/evaluate_imageneta.py '/misc/vlgscratch4/LakeGroup/emin/robust_vision/imagenet_a/' --model-name 'resnet50'
echo "Done"
