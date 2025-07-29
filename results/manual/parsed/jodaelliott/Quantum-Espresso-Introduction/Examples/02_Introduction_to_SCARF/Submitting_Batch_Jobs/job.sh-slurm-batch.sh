#!/bin/bash
#SBATCH --output=job_%J.log
#SBATCH --error=job_%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=scarf
#SBATCH --constraint=amd,ntasks-per-node=32

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load contrib/dls-spectroscopy/quantum-espresso/7.3.1-GCC-12.2.0
mpirun -np ${SLURM_NTASKS} pw.x -inp c60_scf.pwi > c60_scf.pwo
