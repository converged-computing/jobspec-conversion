#!/bin/bash
#SBATCH --output=job_%J.log
#SBATCH --error=job_%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=amd,ntasks-per-node=32

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load contrib/dls-spectroscopy/quantum-espresso/6.5-intel-18.0.3
mpirun -np ${SLURM_NTASKS} pw.x -inp iro2.pwi > iro2.pwo
