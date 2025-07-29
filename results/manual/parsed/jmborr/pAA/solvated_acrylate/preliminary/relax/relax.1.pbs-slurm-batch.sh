#!/bin/bash
#SBATCH --job-name=r1
#SBATCH --output=r1.o%j
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=regular
#SBATCH --licenses=SCRATCH

prefix='relax'
currindex=1
source $MODULESHOME/init/bash
module load lammps/
lmp=lmp_edison
echo "LAMMPS executable is $lmp"
cd $PBS_O_WORKDIR
srun -np 196  $lmp -in $prefix.$currindex.in # Do not use "<" in place of "-in"
