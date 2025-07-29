#!/bin/bash
#SBATCH --job-name=LAMMPS
#SBATCH --account=hpcnow
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:30:00

module load lammps
cd $SCRATCH_DIR
cp -pr /sNow/test/LAMMPS/* .
srun lmp_mpi -var x 10 -var y 40 -var z 40 -in in.lj
cp -pr $SCRATCH_DIR $HOME/OUT/lammps/
