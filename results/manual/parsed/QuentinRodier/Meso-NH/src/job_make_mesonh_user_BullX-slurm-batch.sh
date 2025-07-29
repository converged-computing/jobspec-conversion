#!/bin/bash
#SBATCH --job-name=compile
#SBATCH --output=VUserII.eo%j
#SBATCH --error=VUserII.eo%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=9600
#SBATCH --time=02:05:00
#SBATCH --constraint=ntasks-per-node=1

export VER_USER='                ########## Your own USER Directory'

export VER_USER=                ########## Your own USER Directory
set -x
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-${VER_USER}-MPIINTEL-O3
time gmake user
time gmake -j 1 installuser
