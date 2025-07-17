#!/bin/bash
#FLUX: --job-name=stain_transfer
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: --urgency=16

source activate $WORKDIR/miniconda3/envs/pytorch
python main.py ${SLURM_JOBID} ./config/config.yml
