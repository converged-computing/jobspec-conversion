#!/bin/bash
#FLUX: --job-name=swampy-platanos-4003
#FLUX: --queue=debug
#FLUX: -t=3600
#FLUX: --urgency=16

cd /scratch/$USER/
module purge
module use /nopt/nrel/apps/modules/test/modulefiles/
module load conda
module load gcc/7.4.0
module load cudnn/8.0.5/cuda-10.2
sleep 3
source activate py38tf24
sleep 5
python3 TFbenchmark.py
