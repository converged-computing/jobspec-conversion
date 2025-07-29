#!/bin/bash
#SBATCH --job-name=colabsing
#SBATCH --account=rp24
#SBATCH --output=log-%j.out
#SBATCH --error=log-%j.err
#SBATCH --mail-user=james.lingford@monash.edu
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_OUT
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:A100:1
#SBATCH --mem=200000
#SBATCH --time=00:05:00
#SBATCH --partition=bdi
#SBATCH --qos=bdiq
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=/home/jamesl/rp24/scratch_nobackup/jamesl/ColabFold
#SBATCH --nodelist=m3u021

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
