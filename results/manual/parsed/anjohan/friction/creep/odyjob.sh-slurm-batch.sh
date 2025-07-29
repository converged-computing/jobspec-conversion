#!/bin/bash
#SBATCH --mail-user=andersjohansson@g.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8000
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

export FLUX='1'

module restore cuda114
module list
date
nvidia-smi
hostname
lscpu
lmp=../lammps/a100build/lmp
if nvidia-smi | grep -q V100
then
    lmp=../lammps/v100build/lmp
fi
export FLUX=1
make GEOMETRY=$3 ITERATIONS=100 INDENTS=$2 TEMPS=$1 lmpcmd="$lmp -sf kk -k on g 1 -pk kokkos newton on neigh half binsize 7.5" data/restart.creep_T${1}_I${2}_100_${3}
