#!/bin/bash
#FLUX: --job-name=butterscotch-latke-1094
#FLUX: --priority=16

export OMP_NUM_THREADS='272'

pwd
date
echo "[+] RUN : MODULE LOAD." 
export OMP_NUM_THREADS=272
module purge
module load intel/18.0.2  libfabric/1.7.0  impi/18.0.2 
module load python3
module load openfoam/7.0
module list
echo "[+] RUN : SLURM RUN." 
sh runTACC.sh
date
