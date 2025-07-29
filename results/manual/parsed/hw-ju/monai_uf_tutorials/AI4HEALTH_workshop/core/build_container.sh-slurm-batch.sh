#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=60gb
#SBATCH --time=08:00:00

date;hostname;pwd
module load singularity
singularity build --sandbox /blue/vendor-nvidia/hju/workshop_monaicore1.0.1 docker://projectmonai/monai:1.0.1
singularity exec --writable /blue/vendor-nvidia/hju/workshop_monaicore1.0.1 pip install -r https://raw.githubusercontent.com/Project-MONAI/MONAI/dev/requirements-dev.txt
