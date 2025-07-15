#!/bin/bash
#FLUX: --job-name=dask_job
#FLUX: -c=7
#FLUX: --queue=long1
#FLUX: -t=108000
#FLUX: --urgency=16

source /home/znazari/.bashrc
conda activate Zainab-env
cd $SLURM_SUBMIT_DIR
python parallel_best_proteomic.py > parallel_result.txt
