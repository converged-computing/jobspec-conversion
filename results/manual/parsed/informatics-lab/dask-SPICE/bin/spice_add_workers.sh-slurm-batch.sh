#!/bin/bash
#SBATCH --output=/scratch/dkillick/SPICE/dask/job-%N-%j.log
#SBATCH --error=/scratch/dkillick/SPICE/dask/job-%N-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=200000
#SBATCH --time=01:00:00
#SBATCH --qos=normal

module load scitools
HOST=${1}
PORT=${2}
NWORKERS=48
dask-worker --nprocs ${NWORKERS} --nthreads 1 "${HOST}:${PORT}"
