#!/bin/bash
#SBATCH --job-name=spack-install
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00

module load python/3.8.1
source ~/spack/share/spack/setup-env.sh
source ~/spack/share/spack/setup-env.sh
spack load tcl
echo $PATH
