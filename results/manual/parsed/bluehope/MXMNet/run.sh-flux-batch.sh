#!/bin/bash
#FLUX: --job-name=tart-kerfuffle-2771
#FLUX: -t=171000
#FLUX: --urgency=16

source /home01/$USER/.bashrc
module purge
module load singularity/3.9.7
module load htop nvtop
module load gcc/10.2.0
module load cuda/10.2
module list
conda activate mxmnet
cd /scratch/$USER/workspace/MXMNet
echo "START"
srun python main.py
echo "DONE"
