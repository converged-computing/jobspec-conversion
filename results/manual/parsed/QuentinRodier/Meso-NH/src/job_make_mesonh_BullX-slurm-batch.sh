#!/bin/bash
#SBATCH --job-name=compile
#SBATCH --output=MasterI.eo%j
#SBATCH --error=MasterI.eo%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=9600
#SBATCH --time=04:05:00
#SBATCH --constraint=ntasks-per-node=1

set -x
pwd
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-MPIINTEL-O3
time gmake -j 4
time gmake -j 1 installmaster
