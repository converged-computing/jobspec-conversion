#!/bin/bash
#SBATCH --job-name=ior
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --exclusive

export MODULEPATH='/nopt/nrel/apps/220525b/level01/modules/lmod/linux-centos7-x86_64/gcc/12.1.0'

module purge
export MODULEPATH=/nopt/nrel/apps/220525b/level01/modules/lmod/linux-centos7-x86_64/gcc/12.1.0
module load openmpi
module use /nopt/nrel/apps/220525b/level03b/modules/lmod/linux-centos7-x86_64/openmpi/4.1.3-qqhopcc/gcc/12.1.0
module load ior
srun --mpi=pmi2 -n 2 ior > openmpi_hdf4_ior
module unload ior
module unload openmpi
module unuse /nopt/nrel/apps/220525b/level03b/modules/lmod/linux-centos7-x86_64/openmpi/4.1.3-qqhopcc/gcc/12.1.0
module use /nopt/nrel/apps/220525b/level03b/modules/lmod/linux-centos7-x86_64/intel-oneapi-mpi/2021.6.0-r7lacq7/gcc/12.1.0
module load intel-oneapi-mpi
module load ior
srun --mpi=pmi2 -n 2 ior > intel_hdf4_ior
module unload ior
module unload intel-oneapi-mpi
module unuse /nopt/nrel/apps/220525b/level03b/modules/lmod/linux-centos7-x86_64/intel-oneapi-mpi/2021.6.0-r7lacq7/gcc/12.1.0
