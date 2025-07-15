#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
nvidia-smi
CONDA_PATH=$(conda info | grep -i 'base environment' | awk '{print $4}')
source $CONDA_PATH/etc/profile.d/conda.sh
conda activate py310
A=(test-{a..z})
S=(167114966692745 167114966696777 167114966696765 167114966700910 167114966701334 167114966700691 167114966700678 167114966698619 167114966698985 167114966698629)
S=(166619173361423 166619173361420 166619173361348 166619173357645 166619173357650)
CUBLAS_WORKSPACE_CONFIG=:16:8 torchrun --nnodes=1 --nproc-per-node=4 ../train_pelican_classifier.py --datadir=../data/v0 --num-workers=2 --cuda --nobj=80 --nobj-avg=49 --num-epoch=35 --num-valid=60000 --batch-size=64 --prefix="${A[$SLURM_ARRAY_TASK_ID]}" --optim=adamw --lr-decay-type=warm --activation=leakyrelu --factorize --masked --scale=1 --lr-init=0.0025 --lr-final=1e-6 --drop-rate=0.025 --drop-rate-out=0.025 --weight-decay=0.005 --reproducible --no-fix-data --no-summarize #--seed="${S[$SLURM_ARRAY_TASK_ID]}" 
