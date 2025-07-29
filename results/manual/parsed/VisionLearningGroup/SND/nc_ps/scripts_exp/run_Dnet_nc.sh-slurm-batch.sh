#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu-L
#SBATCH --constraint=gpu6

d=$(date)
echo $d nvidia-smi
nvidia-smi
hostn=$(hostname -s)
cd /home/grad3/keisaito/domain_adaptation/neighbor_density/base
source activate pytorch
python $2  --config configs/dnet-train-config_CDA.yaml --source ./txt/source_dreal125_cls.txt --target ./txt/target_dclipart125_cls.txt --gpu $1 --hp 1.0 2.0 1.5 0.5 --use_neptune
