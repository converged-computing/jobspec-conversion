#!/bin/bash
#FLUX: --job-name=pathgan
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load cuda/10.0.130/intel-19.0.3.199
source activate $WORKDIR/miniconda3/envs/pytorch
python main.py ${SLURM_JOBID} ./config/config_camelyon.yml
python main.py ${SLURM_JOBID} ./config/config_crc.yml
