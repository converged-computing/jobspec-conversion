#!/bin/bash
#SBATCH --job-name=swirl_001
#SBATCH --output=swirl_001.o%j
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

srun --mpi=pmix_v2 swirl \
     --user:cuda=T \
     --cudaclaw:mthlim="1" \
     --cudaclaw:order="2 2" \
     --clawpack46:mthlim="1" \
     --clawpack46:order="1 0" \
     --nout=100
