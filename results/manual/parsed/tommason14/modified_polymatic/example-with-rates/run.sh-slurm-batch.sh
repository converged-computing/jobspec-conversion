#!/bin/bash
#SBATCH --job-name=CR61-test
#SBATCH --output=polymerisation.out
#SBATCH --error=polymerisation.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

export LAMMPS_EXEC='mpirun -np $SLURM_NTASKS ~/p2015120004/apps/clammps/build/lmp_mpi'

module load vmd
module load openmpi
polymatic_autogenerate.sh 
cp -r ../polymatic/scripts .
export LAMMPS_EXEC="mpirun -np $SLURM_NTASKS ~/p2015120004/apps/clammps/build/lmp_mpi"
python3 ../polymatic/polym_loop.py --controlled
