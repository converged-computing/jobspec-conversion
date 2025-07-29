#!/bin/bash
#SBATCH --job-name=Ag-MD
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=4

export lmpexec='pathto/lammps-kokkos-mliap/build/lmp'
export HIPPYNN_USE_CUSTOM_KERNELS='pytorch'
export HIPPYNN_WARN_LOW_DISTANCES='False'

export lmpexec="pathto/lammps-kokkos-mliap/build/lmp"
source exports.bash #configures environment and sets ${lmpexec}
export HIPPYNN_USE_CUSTOM_KERNELS="pytorch"
export HIPPYNN_WARN_LOW_DISTANCES="False"
for i in 2 4 8 12 16 24 32 40 48 56 64 
do
${lmpexec} -var xrep 2 -var yrep 2 -var zrep ${i} -in MD-HO.in -l Strong_Single_${i}.out -k on g 1 -sf kk -pk kokkos neigh full newton on 
done
