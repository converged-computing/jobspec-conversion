#!/bin/bash
#SBATCH --job-name=ncclimo_tst
#SBATCH --account=acme
#SBATCH --output=ncclimo_tst%j
#SBATCH --error=ncclimo_tst%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=debug
#SBATCH --licenses=cscratch1,SCRATCH,project

export OMP_NUM_THREADS='1'
export PATH='/global/homes/z/zender/bin_${NERSC_HOST}:${PATH}'

cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
export OMP_NUM_THREADS=1
module use /global/project/projectdirs/acme/software/modulefiles/all
module load python/anaconda-2.7-acme
export PATH=/global/homes/z/zender/bin_${NERSC_HOST}:${PATH}
srun -n 1 -N 1 python ncclimo_tst.py
