#!/bin/bash
#SBATCH --job-name=compile
#SBATCH --output=VuserII_belenos.eo%j
#SBATCH --error=VUserII_belenos.eo%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

export VER_USER='                     ######## Your own USER Directory'

export VER_USER=                     ######## Your own USER Directory
set -x
pwd
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-${VER_USER}-MPIAUTO-O2
time make user -j 2
time make -j 1 installuser
