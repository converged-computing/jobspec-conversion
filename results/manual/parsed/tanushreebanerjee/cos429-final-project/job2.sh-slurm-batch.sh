#!/bin/bash
#FLUX: --job-name=cv2
#FLUX: -c=8
#FLUX: -t=3600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/scratch/gpfs/blou/.conda/envs/cos429/lib/'

module purge
module load anaconda3/2021.5
conda activate cos429
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/scratch/gpfs/blou/.conda/envs/cos429/lib/
python test2.py
