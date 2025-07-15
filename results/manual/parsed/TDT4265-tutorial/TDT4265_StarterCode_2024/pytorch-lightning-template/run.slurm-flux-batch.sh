#!/bin/bash
#FLUX: --job-name="pytorch-lightning-demo"
#FLUX: -c=16
#FLUX: --queue=GPUQ
#FLUX: -t=1800
#FLUX: --priority=16

cd ${SLURM_SUBMIT_DIR}/
module purge
module load Anaconda3/2023.09-0
conda activate tdt4265
srun python trainer.py
