#!/bin/bash
#FLUX: --job-name=Slurm_GridPROTEUS
#FLUX: -c=19
#FLUX: --priority=16

echo "Running slurm dispatcher"
source ~/.bashrc
conda activate proteus
module load julia 
source PROTEUS.env
srun python tools/GridPROTEUS.py 
