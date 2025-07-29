#!/bin/bash
#SBATCH --job-name=seg
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

echo "----------------- Environment ------------------"
module purge
module load EasyBuild/2023a
module load CUDA/12.2.0
module list
micromamba activate CropMAE
cd ~/CropMAE
date
python3 -m downstreams.propagation.start \
    results \
    399 \
    $1
