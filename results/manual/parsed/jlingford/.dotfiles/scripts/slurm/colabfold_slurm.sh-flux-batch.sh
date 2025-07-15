#!/bin/bash
#FLUX: --job-name=colabsing
#FLUX: -c=12
#FLUX: --queue=bdi
#FLUX: -t=300
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/home/jamesl/rp24/scratch_nobackup/jamesl'

cat slurm.sh
echo 'running colabfold:1.5.5-cuda12.2.2'
nvcc --version
nvidia-smi
module purge
module load singularity
export SINGULARITY_CACHEDIR="/home/jamesl/rp24/scratch_nobackup/jamesl"
singularity pull docker://ghcr.io/sokrypton/colabfold:1.5.5-cuda12.2.2
singularity run -B /home/jamesl/rp24/scratch_nobackup/jamesl/cache:/cache \
    colabfold_1.5.5-cuda12.2.2.sif \
    python -m colabfold.download
singularity run --nv \
    colabfold_1.5.5-cuda12.2.2.sif \
    colabfold_batch --help
singularity run --nv \
    -B /home/jamesl/rp24/scratch_nobackup/jamesl:/cache -B $(pwd):/work \
    colabfold_1.5.5-cuda12.2.2.sif \
    colabfold_batch /work/A173.fasta /work/output
