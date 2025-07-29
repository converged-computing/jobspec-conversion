#!/bin/bash
#SBATCH --job-name=filip70-2
#SBATCH --account=trocks
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3000M
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=16

source /cluster/bin/jobsetup
module load intel
module load intelmpi.intel
module load python2
mpirun -n 64 /work/users/henriasv/filip/lammps/src/lmp_intel_cpu_intelmpi -in inputScripts/system.run.70000v200
