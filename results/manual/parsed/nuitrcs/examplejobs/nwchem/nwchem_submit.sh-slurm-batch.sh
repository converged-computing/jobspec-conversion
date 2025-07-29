#!/bin/bash
#FLUX: --job-name=sample_job
#FLUX: -N=2
#FLUX: --queue=short
#FLUX: -t=1200
#FLUX: --urgency=16

module purge all
module load nwchem/7.0.2-openmpi-4.0.5-intel-19.0.5.281 
mpirun -np ${SLURM_NTASKS} nwchem nwch.nw
