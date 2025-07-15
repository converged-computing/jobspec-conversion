#!/bin/bash
#FLUX: --job-name=nerdy-train-4832
#FLUX: --priority=16

image=python-2.12-numpy-1.13.img
src=/scratch/singularity-images/${image}
dest=/tmp/${image} # this should be on /tmp
lock=/scratch/${USER}/mylock.$(hostname) # each node should have its own lock
bash smart-tmp-copy.sh ${src} ${dest} ${lock}
module load GCC Singularity # Load default GCC and Singularity
singularity run ${dest} vectorization.py # Run image tests
