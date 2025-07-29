#!/bin/bash
#SBATCH --job-name=reindex_GC_trees
#SBATCH --output=./results/reindex_GC_trees.%j.o
#SBATCH --mail-user=ivan.g.raikov@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=32
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=regular
#SBATCH --constraint=haswell
#SBATCH --licenses=SCRATCH

export PYTHONPATH='$HOME/.local/cori/2.7-anaconda/lib/python2.7/site-packages:$PYTHONPATH'

module unload darshan
module load cray-hdf5-parallel/1.8.16
module load python/2.7-anaconda
set -x
export PYTHONPATH=$HOME/model:/opt/python/lib/python2.7/site-packages:$PYTHONPATH
export PYTHONPATH=$HOME/bin/nrn/lib/python:$PYTHONPATH
export PYTHONPATH=$HOME/.local/cori/2.7-anaconda/lib/python2.7/site-packages:$PYTHONPATH
srun -n 1024 python ./scripts/reindex_trees.py \
    --population=GC \
    --forest-path=$SCRATCH/dentate/Full_Scale_Control/DGC_forest_extended_compressed_20180224.h5 \
    --output-path=$SCRATCH/dentate/Full_Scale_Control/DGC_forest_reindex_20180224.h5 \
    --index-path=$SCRATCH/dentate/Full_Scale_Control/dentate_GC_coords_20180224.h5 \
    --io-size=24 -v
