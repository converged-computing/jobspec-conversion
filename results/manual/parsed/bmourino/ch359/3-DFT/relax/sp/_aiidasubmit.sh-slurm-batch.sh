#!/bin/bash
#SBATCH --job-name=<your-job-name>
#SBATCH --mail-user=<your-email>
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30G
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=36
#SBATCH: --no-requeue

module load intel
module load gcc/11.3.0
module load openmpi/4.1.3
module load cp2k/9.1-mpi-openmp
'srun' '-n' '36' '/ssoft/spack/syrah/v1/opt/spack/linux-rhel8-skylake_avx512/gcc-11.3.0/cp2k-9.1-klrakkis7sb24thlwnxd7slve3qwspxm/bin/cp2k.popt' '-i' 'aiida.inp'  > 'aiida.out' 2>&1
