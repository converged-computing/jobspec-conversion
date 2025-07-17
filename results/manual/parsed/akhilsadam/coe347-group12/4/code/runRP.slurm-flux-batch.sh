#!/bin/bash
#FLUX: --job-name=of
#FLUX: -N=4
#FLUX: -n=48
#FLUX: --queue=skx-dev
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='192'

pwd
date
echo "[+] RUN : MODULE LOAD." 
export OMP_NUM_THREADS=192
module purge
module load intel/18.0.2  libfabric/1.7.0  impi/18.0.2 
module load python3
module load openfoam/7.0
module load ooops
set_io_param 0 high
module list
echo "[+] RUN : SLURM RUN." 
sh runRP.sh
date
