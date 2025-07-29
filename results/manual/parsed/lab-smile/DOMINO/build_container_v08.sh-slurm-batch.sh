#!/bin/bash
#SBATCH --job-name=build_container
#SBATCH --output=%x.%j.out
#SBATCH --mail-user=skylastolte4444@ufl.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30gb
#SBATCH --time=08:00:00

date;hostname;pwd
module load singularity
singularity build --sandbox /red/nvidia-ai/SkylarStolte/monaicore08/ docker://projectmonai/monai:0.8.1
singularity exec --nv /red/nvidia-ai/SkylarStolte/monaicore08 nsys status -e
