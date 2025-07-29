#!/bin/bash
#SBATCH --job-name=download
#SBATCH --output=/srv/beegfs/scratch/groups/dpnc/atlas/BIB/implicitBIBae/jobs/slurm-%A-%x_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=04:00:00
#SBATCH --chdir=/home/users/k/kleins/atlas/BIB/implicitBIBae

export XDG_RUNTIME_DIR=''

export XDG_RUNTIME_DIR=""
module load GCCcore/8.2.0 Singularity/3.4.0-Go-1.12
srun singularity exec --nv /srv/beegfs/scratch/groups/dpnc/atlas/BIB/implicitBIBae/container/pytorch.sif\
	python3 /srv/beegfs/scratch/groups/dpnc/atlas/BIB/implicitBIBae/data/data_loaders.py --download 1
