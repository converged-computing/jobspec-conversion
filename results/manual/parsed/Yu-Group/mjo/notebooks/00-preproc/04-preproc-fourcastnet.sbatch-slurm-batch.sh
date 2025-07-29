#!/bin/bash
#SBATCH --job-name=preproc-fourcastnet
#SBATCH --account=m4134
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --mail-user=$EMAIL
#SBATCH --mail-type=begin,end,fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --qos=flex
#SBATCH --constraint=haswell

export N_WORKERS='32'
export N_THREADS_PER='2'
export HDF5_USE_FILE_LOCKING='FALSE'

export N_WORKERS=32
export N_THREADS_PER=2
export HDF5_USE_FILE_LOCKING='FALSE'
SCRIPT_DIR=$PWD
cd $SCRATCH
mkdir -p $SCRATCH/tmp
mkdir -p $SCRATCH/data/era5/fourcastnet
lfs setstripe -c 8 $SCRATCH/data/era5/fourcastnet
module load python
source activate mjonet-preproc
python -u $SCRIPT_DIR/04-preproc-fourcastnet.py
