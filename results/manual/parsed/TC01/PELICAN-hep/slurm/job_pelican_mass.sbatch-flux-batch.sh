#!/bin/bash
#FLUX: --job-name=mass_d_1
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
nvidia-smi
CONDA_PATH=$(conda info | grep -i 'base environment' | awk '{print $4}')
source $CONDA_PATH/etc/profile.d/conda.sh
conda activate py310
A=(mass_d_1-{a..z})
CUBLAS_WORKSPACE_CONFIG=:16:8 python3 ../train_pelican_mass.py --datadir=../data/btW_2_mW_d/m6 --prefix=mass_d_1-a --task=eval --target=truth_Pmu_2 --num-epoch=35 --batch-size=128 --num-train=-1 --num-valid=60000 --nobj=48 --nobj-avg=21 --optim=adamw --lr-decay-type=warm --lr-init=0.0025 --lr-final=1e-5 --scale=1 --drop-rate=0.025 --drop-rate-out=0.025 --weight-decay=0.01 --reproducible --no-fix-data --config=M --config-out=M --loadfile=./model/mass_d_1-a_best.pt --testfile=../data/btW_2_mW/m6/events_delphes.h5
