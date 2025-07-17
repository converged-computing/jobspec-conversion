#!/bin/bash
#FLUX: --job-name=singularity
#FLUX: --queue=smallmem
#FLUX: --urgency=16

module load singularity
if [ ! "tensorflow_gpu.sif" ]
  then
  echo "Deleting old files"
  rm -f tensorflow_gpu.sif
  fi
singularity build --fakeroot tensorflow_gpu.sif singularity/Singularity.PyTensorflow
