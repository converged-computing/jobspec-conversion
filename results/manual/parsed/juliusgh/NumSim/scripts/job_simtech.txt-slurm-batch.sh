#!/bin/bash
#SBATCH --job-name=st
#SBATCH --output=result_st.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=1

export CPATH='/scratch-nfs/maierbn/openmpi/install-3.1/include'
export PATH='/scratch-nfs/maierbn/openmpi/install-3.1/bin:$PATH'

module use /usr/local.nfs/sgs/modulefiles
module load gcc/10.2
module load openmpi/3.1.6-gcc-10.2
module load vtk/9.0.1
module load cmake/3.18.2
export CPATH=/scratch-nfs/maierbn/openmpi/install-3.1/include
export PATH=/scratch-nfs/maierbn/openmpi/install-3.1/bin:$PATH
mkdir -p out_simtech
cd out_simtech
srun -n 1 ../build/src/numsim ../parameters/simtech_big.txt
