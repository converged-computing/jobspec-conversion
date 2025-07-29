#!/bin/bash
#SBATCH --job-name=$1-$2-$3
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16000
#SBATCH --constraint=ntasks-per-node=64

export LD_LIBRARY_PATH='/home/dbt1c21/packages/oneTBB-2019/build/linux_intel64_gcc_cc11.1.0_libc2.17_kernel3.10.0_release'

export LD_LIBRARY_PATH=/home/dbt1c21/packages/oneTBB-2019/build/linux_intel64_gcc_cc11.1.0_libc2.17_kernel3.10.0_release
module load gcc/11.1.0
/home/dbt1c21/projects/poets-dpd/scripts/run_dmpci_in_poets_dpd.sh $1 $2 $3
