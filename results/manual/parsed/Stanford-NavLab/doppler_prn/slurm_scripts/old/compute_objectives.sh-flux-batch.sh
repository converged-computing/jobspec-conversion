#!/bin/bash
#FLUX: --job-name=compute_objectives
#FLUX: -c=32
#FLUX: --queue=normal
#FLUX: -t=21600
#FLUX: --urgency=16

export SLURM_SUBMIT_DIR='/home/groups/gracegao/prn_codes/doppler_prn'

module load python/3.9
export SLURM_SUBMIT_DIR=/home/groups/gracegao/prn_codes/doppler_prn
cd $SLURM_SUBMIT_DIR
lscpu
mkdir results
python3 compute_objectives.py
