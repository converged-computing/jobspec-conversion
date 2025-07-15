#!/bin/bash
#FLUX: --job-name=cal_face
#FLUX: --urgency=16

nvidia-smi
nvidia-smi -q |grep -i serial
source ~/.bashrc
CONDA_BASE=$(conda info --base) ; 
source $CONDA_BASE/etc/profile.d/conda.sh
cd /home/sriniana/projects/flexivit/
conda activate vit
echo -e '\n\n' + "*"{,,,,,,,,,,,,,,,,}
echo $SLURM_JOB_ID $SLURM_JOB_NODELIST
echo $CONDA_DEFAULT_ENV
echo -e "*"{,,,,,,,,,,,,,,,,}
python3 -u flexivit.py
