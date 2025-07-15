#!/bin/bash
#FLUX: --job-name=goodbye-lamp-7745
#FLUX: -t=86400
#FLUX: --urgency=16

export MODULEPATH='/opt/apps/resif/iris/2019b/gpu/modules/all/'
export ANACONDA='/opt/apps/resif/iris/2019b/default/modules/all/lang/Anaconda3/'

cd /home/users/ewobler/satellite-pose-estimation-main/
conda activate torchit
export MODULEPATH=/opt/apps/resif/iris/2019b/default/modules/all/
module load lang/Anaconda3/2020.02
export ANACONDA=/opt/apps/resif/iris/2019b/default/modules/all/lang/Anaconda3/
export MODULEPATH=/opt/apps/resif/iris/2019b/gpu/modules/all/
module load system/CUDA/
python -u run_model.py
