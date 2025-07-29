#!/bin/bash
#SBATCH --output=%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --array=0-20

image=python-2.12-numpy-1.13.img
src=/scratch/singularity-images/${image}
dest=/tmp/${image} # this should be on /tmp
lock=/scratch/${USER}/mylock.$(hostname) # each node should have its own lock
bash smart-tmp-copy.sh ${src} ${dest} ${lock}
module load GCC Singularity # Load default GCC and Singularity
singularity run ${dest} vectorization.py # Run image tests
