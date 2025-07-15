#!/bin/bash
#FLUX: --job-name=tart-noodle-0746
#FLUX: --queue=gpu-a100-h
#FLUX: --urgency=16

set -e
set -u
module load spack/singularity/3.8.3
singularity instance start --nv -B /home/haryu/alphafoldDownload /home/icanders/alphafold_singularity/alphafold.sif bash
singularity exec instance://bash ~/26118_msh6_tudor_phytozome.sh
