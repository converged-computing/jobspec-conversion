#!/bin/bash
#SBATCH --job-name=bench2
#SBATCH --account=snic2021-1-38
#SBATCH --mail-user=anton.jansen@scilifelab.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=32

ml PDC/21.09 
ml all-spack-modules/0.16.3
ml CMake/3.21.2
source ${PWD}/bin/GMXRC
srun gmx_mpi mdrun -deffnm MD -npme 0 -g GLIC_2n_64_4_DLBNO.log -resetstep 20000 -ntomp 4 -dlb yes -pin on -pinstride 2
