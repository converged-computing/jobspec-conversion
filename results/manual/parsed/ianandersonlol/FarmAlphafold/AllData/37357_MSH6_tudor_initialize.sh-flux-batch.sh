#!/bin/bash
#FLUX: --job-name=frigid-kerfuffle-6022
#FLUX: --queue=gpu-a100-h
#FLUX: --priority=16

set -e
set -u
module load spack/singularity/3.8.3
singularity instance start --nv -B /home/icanders/alphafoldDownload /home/icanders/alphafold_singularity/alphafold.sif bash
singularity exec instance://bash ~/37357_MSH6_tudor.sh
