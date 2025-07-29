#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64gb
#SBATCH --time=08:00:00

date;hostname;pwd
module load singularity
singularity build --sandbox /blue/vendor-nvidia/hju/monaicore0.9.1 docker://projectmonai/monai:0.9.1
singularity exec --writable /blue/vendor-nvidia/hju/monaicore0.9.1 pip3 install -r https://raw.githubusercontent.com/Project-MONAI/MONAI/dev/requirements-dev.txt
