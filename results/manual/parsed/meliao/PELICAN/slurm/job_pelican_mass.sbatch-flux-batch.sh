#!/bin/bash
#FLUX: --job-name=mass_1b
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
nvidia-smi
CONDA_PATH=$(conda info | grep -i 'base environment' | awk '{print $4}')
source $CONDA_PATH/etc/profile.d/conda.sh
conda activate py39
A=(mass_1b-{a..z})
CUBLAS_WORKSPACE_CONFIG=:16:8 python3 ../train_pelican_mass.py --datadir=../data/btW_1b --prefix="${A[$SLURM_ARRAY_TASK_ID]}" --target=truth_Pmu_2 --num-epoch=80 --batch-size=100 --num-train=60000 --num-valid=20000 --nobj=80 --lr-decay-type=warm --config1=M --config2=M --activation=leakyrelu --factorize --masked --lr-init=0.0025 --lr-final=5e-7 --scale=1. --drop-rate=0.05 --drop-rate-out=0.05 --weight-decay=0.01 --reproducible --no-fix-data
