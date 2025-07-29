#!/bin/bash
#FLUX: --job-name=PyThinFilm_Example
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export GMX_MAXBACKUP='-1'

module load PrgEnv-cray
module load rocm craype-accel-amd-gfx90a
module load gcc/12.1.0
module load gromacs-amd-gfx90a/2022.3.amd1_174
module load hpc-python-collection/2022.11-py3.9.15
unset OMP_NUM_THREADS
export GMX_MAXBACKUP=-1
pytf GPU_solvent_evaporation.yml
