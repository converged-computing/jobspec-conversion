#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=./out/array_%A_%a.out
#SBATCH --error=./err/array_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=4
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=a100,ntasks-per-node=4
#SBATCH --array=0-4

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
nvidia-smi
CONDA_PATH=$(conda info | grep -i 'base environment' | awk '{print $4}')
source $CONDA_PATH/etc/profile.d/conda.sh
conda activate py310
A=(test-{a..z})
S=(167114966692745 167114966696777 167114966696765 167114966700910 167114966701334 167114966700691 167114966700678 167114966698619 167114966698985 167114966698629)
S=(166619173361423 166619173361420 166619173361348 166619173357645 166619173357650)
CUBLAS_WORKSPACE_CONFIG=:16:8 torchrun --nnodes=1 --nproc-per-node=4 ../train_pelican_classifier.py --datadir=../data/v0 --num-workers=2 --cuda --nobj=80 --nobj-avg=49 --num-epoch=35 --num-valid=60000 --batch-size=64 --prefix="${A[$SLURM_ARRAY_TASK_ID]}" --optim=adamw --lr-decay-type=warm --activation=leakyrelu --factorize --masked --scale=1 --lr-init=0.0025 --lr-final=1e-6 --drop-rate=0.025 --drop-rate-out=0.025 --weight-decay=0.005 --reproducible --no-fix-data --no-summarize #--seed="${S[$SLURM_ARRAY_TASK_ID]}" 
