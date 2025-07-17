#!/bin/bash
#FLUX: --job-name=hostname
#FLUX: --queue=allgpu
#FLUX: -t=86400
#FLUX: --urgency=16

unset LD_PRELOAD
source /etc/profile.d/modules.sh
module purge
module load maxwell gcc/9.3
module load anaconda3/5.2
. conda-init
conda activate jetnet
path=JetNet_NF
python -u /home/$USER/$path/LitJetNet/LitNF/main.py
