#!/bin/bash
#FLUX: --job-name=arid-lemur-7342
#FLUX: --queue=thinkstation-p340
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load students_env/1.0
srun python /mnt/nfs/efernandez/projects/DDPM_model/main_rayleigh.py
