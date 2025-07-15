#!/bin/bash
#FLUX: --job-name=evasive-poo-2011
#FLUX: -t=10800
#FLUX: --urgency=16

source /etc/profile
module load py-numpy/1.24.3/gcc-13.1.0
module load py-mpi4py/3.1.4/gcc-12.3.0-openmpi
module load intel-oneapi-compilers/2023.1.0/gcc-11.4.0
module load valgrind/3.20.0/gcc-12.3.0-openmpi
cd ~/tmp
echo "============= TITLE OF MY BATCH ================="
python3 check_cache_losses.py
echo "===================== END ======================="
