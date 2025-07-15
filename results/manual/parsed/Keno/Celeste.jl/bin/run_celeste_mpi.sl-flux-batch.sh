#!/bin/bash
#FLUX: --job-name=celeste
#FLUX: -N=2
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export JULIA_NUM_THREADS='32'
export SDSS_ROOT_DIR='/global/projecta/projectdirs/sdss/data/sdss/dr12/boss'
export FIELD_EXTENTS='/project/projectdirs/dasrepo/celeste-sc16/field_extents.fits'
export CELESTE_STAGE_DIR='/global/cscratch1/sd/jregier/celeste'
export USE_DTREE='1'
export I_MPI_PIN_DOMAIN='auto'
export I_MPI_PMI_LIBRARY='/usr/lib64/slurmpmi/libpmi.so'

export OMP_NUM_THREADS=1
export JULIA_NUM_THREADS=32
export SDSS_ROOT_DIR="/global/projecta/projectdirs/sdss/data/sdss/dr12/boss"
export FIELD_EXTENTS="/project/projectdirs/dasrepo/celeste-sc16/field_extents.fits"
export CELESTE_STAGE_DIR=/global/cscratch1/sd/jregier/celeste
export USE_DTREE=1
module load impi
export I_MPI_PIN_DOMAIN=auto
export I_MPI_PMI_LIBRARY=/usr/lib64/slurmpmi/libpmi.so
srun -n 32 $SCRATCH/julia/bin/julia "$HOME/.julia/v0.5/Celeste/bin/infer-box.jl" 200 200.5 38.1 38.35
