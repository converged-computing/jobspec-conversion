#!/bin/bash
#FLUX: --job-name=dinosaur-general-5778
#FLUX: --queue=seas_gpu
#FLUX: -t=172800
#FLUX: --urgency=16

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
