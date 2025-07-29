#!/bin/bash
#FLUX: --job-name=torchlight
#FLUX: -c=8
#FLUX: --queue=boost_usr_prod
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load gcc
module load cuda
module load openmpi
source $HOME/.bashrc
conda activate /leonardo_work/ICT23_SMR3872/shared-env/Gabenv
srun python myscript.py
