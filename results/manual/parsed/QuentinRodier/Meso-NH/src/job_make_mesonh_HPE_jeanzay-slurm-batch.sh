#!/bin/bash
#SBATCH --job-name=compile_MNH
#SBATCH --account=mnh@cpu
#SBATCH --output=Sortie_compile_MasterI.eo%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16

set -x
pwd
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-MPIINTEL-O2
time gmake -j 16
time gmake -j 1 installmaster
