#!/bin/bash
#FLUX: --job-name=MSH6_tudor
#FLUX: -c=16
#FLUX: --queue=gpu-a100-h
#FLUX: -t=172800
#FLUX: --urgency=16

set -e
set -u
module load spack/singularity/3.8.3
singularity instance start --nv -B /home/icanders/alphafoldDownload /home/icanders/alphafold_singularity/alphafold.sif bash
singularity exec instance://bash ~/37357_MSH6_tudor.sh
