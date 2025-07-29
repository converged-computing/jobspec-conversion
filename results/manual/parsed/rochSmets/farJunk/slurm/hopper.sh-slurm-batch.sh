#!/bin/bash
#SBATCH --job-name=blAckDog-b1
#SBATCH --account=medium
#SBATCH --output=hopper.%J.log
#SBATCH --error=hopper.%J.err
#SBATCH --mail-user=roch.smets@lpp.polytechnique.fr
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=80
#SBATCH --cpus-per-task=1

module load mvapich2/gcc/64/2.1rc1 cmake/3.5.0 hdf5-mvapich/1.10.5
MYRUN=$HOME/shErpA/blAckDog/run/b1/
MYEXE=$HOME/codeS/hecKle/build-heckle/HECKLE
time mpirun -np $SLURM_NTASKS $MYEXE $MYRUN
