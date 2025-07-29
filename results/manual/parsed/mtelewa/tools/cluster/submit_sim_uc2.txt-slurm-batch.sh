#!/bin/bash
#SBATCH --job-name=Pump
#SBATCH --output=cluster.out
#SBATCH --error=cluster.err
#SBATCH --mail-user=mohamed.hassan@kit.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=single
#SBATCH --constraint=ntasks-per-node=32

export KMP_AFFINITY='compact,1,0'

export KMP_AFFINITY=compact,1,0
module load compiler/intel/19.1
module load mpi/openmpi/4.0
$${rocket_launch}
