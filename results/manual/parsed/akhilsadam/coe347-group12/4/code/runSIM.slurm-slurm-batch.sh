#!/bin/bash
#FLUX: --job-name=of
#FLUX: -n=8
#FLUX: --queue=normal
#FLUX: -t=21600
#FLUX: --urgency=16

export OMP_NUM_THREADS='272'

pwd
date
echo "[+] RUN : MODULE LOAD." 
export OMP_NUM_THREADS=272
module purge
module load intel/18.0.2  libfabric/1.7.0  impi/18.0.2 
module load python3
module load openfoam/7.0
module load ooops
set_io_param 0 high
module list
echo "[+] RUN : SLURM RUN." 
sh runSIM.sh
date
