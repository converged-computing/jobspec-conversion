#!/bin/bash
#SBATCH --account=nn9272k
#SBATCH --mail-user=anjohan@uio.no
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3600M

source /cluster/bin/jobsetup
module load intel/2018.1
module load intelmpi.intel
lammps=$(find ~ -name lmp 2> /dev/null)
mpirun $lammps $@
