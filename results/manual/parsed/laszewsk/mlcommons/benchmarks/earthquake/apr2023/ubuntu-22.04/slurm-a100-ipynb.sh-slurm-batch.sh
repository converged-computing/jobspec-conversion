#!/bin/bash
#FLUX: --job-name=earthquake-a100
#FLUX: --queue=bii-gpu
#FLUX: -t=259200
#FLUX: --urgency=16

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
singularity exec --nv /scratch/$USER/mlcommons/benchmarks/earthquake/apr2023/rivanna/mnist.sif cms gpu watch --gpu=0 --delay=1 --dense > gpu0.log &
allocations
singularity exec --nv /scratch/$USER/mlcommons/benchmarks/earthquake/apr2023/rivanna/mnist.sif bash -c "source ~/ENV3/bin/activate ; \
          papermill /scratch/$USER/mlcommons/benchmarks/earthquake/apr2023/rivanna/FFFFWNPFEARTHQ_newTFTv29-mllog.ipynb \
          FFFFWNPFEARTHQ_newTFTv29-mllog_output.ipynb \
          --no-progress-bar --log-output --execution-timeout=-1 --log-level INFO"
allocations
echo "==================================================="
seff $SLURM_JOB_ID
