#!/bin/bash
#SBATCH --job-name=Pump
#SBATCH --output=cluster.out
#SBATCH --error=cluster.err
#SBATCH --mail-user=mohamed.hassan@kit.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=multiple
#SBATCH --constraint=ntasks-per-node=20

export KMP_AFFINITY='compact,1,0'

export KMP_AFFINITY=compact,1,0
module load compiler/intel/19.1
module load mpi/openmpi/4.0
mpirun --bind-to core --map-by core -report-bindings lmp_mpi -in $(pwd)/flow.LAMMPS -v fc 1 -v mflowrate_imposed 5.052639870676383e-20
