#!/bin/bash
#FLUX: --job-name=FAU-FAPS
#FLUX: -t=86400
#FLUX: --urgency=16

unset SLURM_EXPORT_ENV
source /home/hpc/iwfa/iwfa018h/.bashrc
conda activate FAPS
python run.py
