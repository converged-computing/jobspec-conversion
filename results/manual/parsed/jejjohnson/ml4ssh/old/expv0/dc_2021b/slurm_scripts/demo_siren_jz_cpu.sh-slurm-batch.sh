#!/bin/bash
#SBATCH --job-name=dc21b
#SBATCH --account=cli@cpu
#SBATCH --output=/gpfsscratch/rech/cli/uvo53rl/logs/logs/ml4ssh_dc_2021b_%j.log
#SBATCH --error=/gpfsscratch/rech/cli/uvo53rl/logs/errs/ml4ssh_dc_2021b_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=2-00:00:00
#SBATCH --qos=qos_cpu-t4
#SBATCH --constraint=ntasks-per-node=1

export PYTHONPATH='$WORK/projects/ml4ssh:${PYTHONPATH}'
export XLA_PYTHON_CLIENT_PREALLOCATE='false'
export JAX_PLATFORM_NAME='CPU'

module purge
module load git/2.31.1
module load github-cli/1.13.1
module load git-lfs/3.0.2
module load anaconda-py3/2021.05
module load ffmpeg/4.2.2
cd $WORK/projects/ml4ssh
export PYTHONPATH=$WORK/projects/ml4ssh:${PYTHONPATH}
source activate jax_gpu_py39
export XLA_PYTHON_CLIENT_PREALLOCATE=false
export JAX_PLATFORM_NAME=CPU
srun python experiments/dc_2021b/demo_siren.py \
    --wandb-mode offline \
    --log-dir /gpfsscratch/rech/cli/uvo53rl/logs \
    --model siren \
    --n-epochs 2000 \
    --activation sine \
    --batch-size 4096 \
    --learning-rate 1e-4 \
    --julian-time False \
    --train-data-dir /gpfsdswork/projects/rech/cli/uvo53rl/data/data_challenges/ssh_mapping_2021/train \
    --ref-data-dir /gpfsdswork/projects/rech/cli/uvo53rl/data/data_challenges/ssh_mapping_2021/ref \
    --test-data-dir /gpfsdswork/projects/rech/cli/uvo53rl/data/data_challenges/ssh_mapping_2021/test
