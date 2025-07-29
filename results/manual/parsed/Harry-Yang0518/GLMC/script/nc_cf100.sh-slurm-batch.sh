#!/bin/bash
#SBATCH --job-name=lt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu
#SBATCH --mem=80GB
#SBATCH --time=2-00:00:00

LOSS=$1
BS=$2
SEED=$3
ext3_path=/scratch/$USER/overlay-25GB-500K.ext3
sif_path=/scratch/lg154/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif
singularity exec --nv \
--overlay ${ext3_path}:ro \
--overlay /scratch/lg154/sseg/dataset/tiny-imagenet-200.sqf:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
python main_nc.py --dataset cifar100 -a resnet50 --epochs 600 --scheduler ms --norm gn --coarse \
  --loss ${LOSS} --eps 0.05 --batch_size ${BS} --seed 202${SEED} --store_name gn_coarse_${LOSS}_b${BS}_s${SEED}
"
