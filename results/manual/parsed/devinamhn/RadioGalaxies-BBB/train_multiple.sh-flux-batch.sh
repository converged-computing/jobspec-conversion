#!/bin/bash
#FLUX: --job-name=vi_ensemble
#FLUX: -c=17
#FLUX: -t=1380
#FLUX: --priority=16

pwd;
nvidia-smi
echo ">>>start task array $SLURM_ARRAY_TASK_ID"
echo "Running on:"
hostname
source /share/nas2/dmohan/bbb/RadioGalaxies-BBB/venv/bin/activate 
echo ">>>training"
python /share/nas2/dmohan/bbb/RadioGalaxies-BBB/bbb_ensemble.py $SLURM_ARRAY_TASK_ID
