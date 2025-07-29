#!/bin/bash
#SBATCH --job-name=liq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=00:59:00

module purge
module load anaconda3/2021.11
conda activate /tigress/yifanl/usr/licensed/anaconda3/2021.11/envs/dp-v2.2.7
if [ -f "frozen_model_compressed.pb" ]; then
  rm frozen_model_compressed.pb
fi
if [ -f "../train/frozen_model_compressed.pb" ]; then
  ln -s ../train/frozen_model_compressed.pb frozen_model_compressed.pb
else
  ln -s ../model/frozen_model_compressed.pb frozen_model_compressed.pb
fi
lmp -in in.lammps
