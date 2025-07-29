#!/bin/bash
#SBATCH --job-name=cuFFS
#SBATCH --account=mwaeor
#SBATCH --output=cuffs-%A.out
#SBATCH --error=cuffs-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=256GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

source /pawsey/mwa/software/python3/build_base.sh
module load cuda
module load hdf5
module load cfitsio
module use /astro/mwaeor/achokshi/software/modulefiles
module load cuFFS
CUFFS_IN=$1
time rmsynthesis $CUFFS_IN
rm $CUFFS_IN
