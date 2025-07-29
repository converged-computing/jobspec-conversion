#!/bin/bash
#SBATCH --job-name=count_euro
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=yichia3@illinois.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=12

. /projects/dali/spack/share/spack/setup-env.sh
spack env activate dali
python3 count.py
