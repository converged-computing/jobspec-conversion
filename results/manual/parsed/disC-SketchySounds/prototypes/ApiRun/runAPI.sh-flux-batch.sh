#!/bin/bash
#FLUX: --job-name=sd-usage
#FLUX: -c=8
#FLUX: --queue=p0
#FLUX: -t=28800
#FLUX: --urgency=16

export PIP_CACHE_DIR='$CACHE_DIR'
export TRANSFORMERS_CACHE='$CACHE_DIR'
export HF_HOME='$CACHE_DIR'
export LD_LIBRARY_PATH='/nfs/tools/spack/v0.21.0/opt/spack/linux-ubuntu20.04-zen2/gcc-9.4.0/cuda-11.8.0-y3u5n3kohg7mgnff4loe6t2pz6awb7ck/lib64/:$LD_LIBRARY_PATH'
export PATH='/nfs/tools/spack/v0.21.0/opt/spack/linux-ubuntu20.04-zen2/gcc-9.4.0/cuda-11.8.0-y3u5n3kohg7mgnff4loe6t2pz6awb7ck/bin/:$PATH'

echo "=================================================================="
echo "Starting Batch Job at $(date)"
echo "Job submitted to partition ${SLURM_JOB_PARTITION} on ${SLURM_CLUSTER_NAME}"
echo "Job name: ${SLURM_JOB_NAME}, Job ID: ${SLURM_JOB_ID}"
echo "Requested ${SLURM_CPUS_ON_NODE} CPUs on compute node $(hostname)"
echo "Working directory: $(pwd)"
echo "=================================================================="
CACHE_DIR=/nfs/scratch/students/$USER/.cache
export PIP_CACHE_DIR=$CACHE_DIR
export TRANSFORMERS_CACHE=$CACHE_DIR
export HF_HOME=$CACHE_DIR
mkdir -p "$CACHE_DIR"
export LD_LIBRARY_PATH=/nfs/tools/spack/v0.21.0/opt/spack/linux-ubuntu20.04-zen2/gcc-9.4.0/cuda-11.8.0-y3u5n3kohg7mgnff4loe6t2pz6awb7ck/lib64/:$LD_LIBRARY_PATH
export PATH=/nfs/tools/spack/v0.21.0/opt/spack/linux-ubuntu20.04-zen2/gcc-9.4.0/cuda-11.8.0-y3u5n3kohg7mgnff4loe6t2pz6awb7ck/bin/:$PATH
module purge
module load cuda/cuda-11.8.0
source /nfs/scratch/students/$(whoami)/venv39/bin/activate
cd /home/$(whoami)/api
srun python /home/$(whoami)/api/Controller.py
