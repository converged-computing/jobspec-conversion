#!/bin/bash
#SBATCH --account=<project>
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00

APPTAINER_IMAGE_PATH=/nobackup/projects/${SLURM_JOB_ACCOUNT}/${USER}/aarch64/pytorch-transformers-wikitext2-benchmark/transformers-benchmark-24.02.sif 
echo "HOSTNAME=${HOSTNAME}"
nvidia-smi
nproc
apptainer run -c -e --bind $(pwd):/mnt --bind ${TMPDIR}:/tmp --env "HF_HOME=/mnt/hf_home/${SLURM_JOB_ID}" --env "TMPDIR=/tmp/${SLURM_JOB_ID}" --nv ${APPTAINER_IMAGE_PATH}
