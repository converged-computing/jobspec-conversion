#!/bin/bash
#SBATCH --job-name=testMPI
#SBATCH --output=output.txt
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=normal

export PATH='$PATH:/home/omnia-share/openmpi-4.1.5'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/omnia-share/openmpi-4.1.5/lib'

pwd; hostname; date
source /home/omnia-share/setenv_AOCC.sh
export PATH=$PATH:/home/omnia-share/openmpi-4.1.5
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/omnia-share/openmpi-4.1.5/lib
cd /home/omnia-share/amd-zen-hpl-2023_07_18
mpirun -np 2 --mca orte_keep_fqdn_hostnames 1 ./xhpl
date
