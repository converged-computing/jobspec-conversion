#!/bin/bash
#FLUX: --job-name=moolicious-avocado-2465
#FLUX: --queue=thinkstation-p340
#FLUX: --priority=16

source /etc/profile.d/modules.sh
module load students_env/1.0
srun python /mnt/nfs/efernandez/projects/DDPM_model/main_rayleigh.py
