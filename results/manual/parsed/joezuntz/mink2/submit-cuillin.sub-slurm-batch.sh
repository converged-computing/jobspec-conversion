#!/bin/bash
#SBATCH --job-name=mink
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=4-00:00:00

export OMP_PROC_BIND='true'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='4'

cd $HOME/mink2
export OMP_PROC_BIND=true
export OMP_PLACES=threads
export OMP_NUM_THREADS=4
if [ ! -f mink-latest.simg ]; then
    singularity pull docker://joezuntz/mink:latest
fi
singularity run  ./mink-latest.simg ./run-cuillin.sh
