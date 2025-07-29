#!/bin/bash
#SBATCH --job-name=gpc_lammps.001
#SBATCH --output=stdout/gpc_lammps.001.%J.out
#SBATCH --error=stdout/gpc_lammps.001.%J.err
#SBATCH --nodes=154
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1024
#SBATCH --time=06:00:00

module load PrgEnv-cray
module load cray-mpich
module load perftools-base perftools
srun --exclusive -N 77 -n 770 \
     /home/users/msrinivasa/develop/GPCNET/network_load_test > gpc.out &
sleep 10
srun --exclusive -N 77 -n 308 \
     /home/users/msrinivasa/develop/lammps/build/lmp+trace \
     -i /home/users/msrinivasa/develop/lammps/examples/DIFFUSE/in.msd.2d > lammps.out
wait
