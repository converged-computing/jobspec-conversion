#!/bin/bash
#FLUX: --job-name=dask
#FLUX: -n=3
#FLUX: -t=60
#FLUX: --priority=16

module load Singularity
module unload XALT
srun singularity run -B $PWD $SIFPATH/dask-mpi_latest.sif dask_example.py
