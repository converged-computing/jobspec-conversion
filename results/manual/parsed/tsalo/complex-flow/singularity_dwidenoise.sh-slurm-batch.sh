#!/bin/bash
#SBATCH --job-name=dwi
#SBATCH --account=iacc_nbc
#SBATCH --output=dwi_out
#SBATCH --error=dwi_err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

export NPROCS='`echo $LSB_HOSTS | wc -w`'
export OMP_NUM_THREADS='$NPROCS'

export NPROCS=`echo $LSB_HOSTS | wc -w`
export OMP_NUM_THREADS=$NPROCS
. $MODULESHOME/../global/profile.modules
module load singularity-3
source /home/data/nbc/nbclab-env/py3_environment
python test_dwidenoise.py
