#!/bin/bash
#FLUX: --job-name=placid-caramel-6980
#FLUX: --urgency=16

export LAMMPS_EXEC='mpirun -np $SLURM_NTASKS ~/p2015120004/apps/clammps/build/lmp_mpi'

module load vmd
module load openmpi
polymatic_autogenerate.sh 
cp -r ../polymatic/scripts .
export LAMMPS_EXEC="mpirun -np $SLURM_NTASKS ~/p2015120004/apps/clammps/build/lmp_mpi"
python3 ../polymatic/polym_loop.py --controlled
