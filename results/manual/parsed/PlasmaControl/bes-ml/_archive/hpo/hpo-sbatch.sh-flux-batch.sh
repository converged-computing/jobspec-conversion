#!/bin/bash
#FLUX: --job-name=sticky-animal-5371
#FLUX: -c=128
#FLUX: -t=86400
#FLUX: --urgency=16

module load edgeml
module list
source "/scratch/gpfs/dsmith/miniconda/etc/profile.d/conda.sh"
conda activate tf
which conda
which python3
env | egrep "SLURM|HOST"
srun python3 hpo-create.py
