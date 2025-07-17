#!/bin/bash
#FLUX: --job-name=CR61-test
#FLUX: -n=8
#FLUX: --queue=short,comp
#FLUX: -t=600
#FLUX: --urgency=16

export LAMMPS_EXEC='mpirun -np $SLURM_NTASKS ~/p2015120004/apps/clammps/build/lmp_mpi'

module load vmd
module load openmpi
polymatic_autogenerate.sh 
cp -r ../polymatic/scripts .
export LAMMPS_EXEC="mpirun -np $SLURM_NTASKS ~/p2015120004/apps/clammps/build/lmp_mpi"
python3 ../polymatic/polym_loop.py --controlled
