#!/bin/bash
#SBATCH --job-name=singularity
#SBATCH --output=outputs/singularity-%A.out
#SBATCH --error=outputs/singularity-%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12G

module load singularity
if [ ! "tensorflow_gpu.sif" ]
  then
  echo "Deleting old files"
  rm -f tensorflow_gpu.sif
  fi
singularity build --fakeroot tensorflow_gpu.sif singularity/Singularity.PyTensorflow
