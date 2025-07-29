#!/bin/bash
#SBATCH --job-name=LAMMPS
#SBATCH --account=uoa99999
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4096
#SBATCH --time=00:30:00

source /etc/profile.d/modules.sh
module load lammps/12Aug13-sandybridge
cd $SCRATCH_DIR
cp -pr /share/test/LAMMPS/* .
srun lmp_mpi -var x 10 -var y 40 -var z 40 -in in.lj
cp -pr $SCRATCH_DIR $HOME/OUT/lammps/
