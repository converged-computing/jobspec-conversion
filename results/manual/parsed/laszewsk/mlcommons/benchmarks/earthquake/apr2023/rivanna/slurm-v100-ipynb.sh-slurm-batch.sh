#!/bin/bash
#SBATCH --job-name=earthquake-2
#SBATCH --account=comp4gc
#SBATCH --output=%u-%j-v100.out
#SBATCH --error=%u-%j-v100.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64GB
#SBATCH --time=3-00:00:00
#SBATCH --partition=bii-gpu

hostname
echo "SLURM_CPUS_ON_NODE: $SLURM_CPUS_ON_NODE"
echo "SLURM_CPUS_PER_GPU: $SLURM_CPUS_PER_GPU"
echo "SLURM_GPU_BIND: $SLURM_GPU_BIND"
echo "SLURM_JOB_ACCOUNT: $SLURM_JOB_ACCOUNT"
echo "SLURM_JOB_GPUS: $SLURM_JOB_GPUS"
echo "SLURM_JOB_ID: $SLURM_JOB_ID"
echo "SLURM_JOB_PARTITION: $SLURM_JOB_PARTITION"
echo "SLURM_JOB_RESERVATION: $SLURM_JOB_RESERVATION"
echo "SLURM_SUBMIT_HOST: $SLURM_SUBMIT_HOST"
nvidia-smi
echo "Working in $(pwd)"
singularity exec --nv mnist.sif cms gpu watch --gpu=0 --delay=1 --dense > gpu0.log &
allocations
singularity exec --nv mnist.sif bash -c "source ~/ENV3/bin/activate ; \
          papermill FFFFWNPFEARTHQ_newTFTv29.ipynb \
          FFFFWNPFEARTHQ_newTFTv29_output.ipynb \
          --no-progress-bar --log-output --execution-timeout=-1 --log-level INFO"
allocations
echo "==================================================="
seff $SLURM_JOB_ID
