#!/bin/bash
#SBATCH --job-name=build_container
#SBATCH --output=container_build.%j.out
#SBATCH --mail-user=magitz@ufl.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=01:00:00

date;hostname;pwd
module load singularity
echo "Building singularity container based on NGC PyTorch docker image the current directory."
singularity build --sandbox pyt21.07/ docker://nvcr.io/nvidia/pytorch:21.07-py3
echo "Adding UFRC filesystem paths to container"
singularity exec pyt21.07 mkdir -p /blue /orange /scratch/local
echo "Installing MONAI in the container." 
singularity exec --writable pyt21.07 pip3 install monai==0.6
ehco "Installing dependencies required by the MONAI tutorial scripts"
singularity exec --writable pyt21.07 pip3 install -r https://raw.githubusercontent.com/Project-MONAI/MONAI/dev/requirements-dev.txt
echo "Finshed building the container."
date
