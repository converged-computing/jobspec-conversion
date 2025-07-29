#!/bin/bash
#SBATCH --job-name=OMC_U_zzz
#SBATCH --account=su006-040
#SBATCH --mail-user=rated.beta@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3850
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=128

export OMP_NUM_THREADS='1'
export LD_LIBRARY_PATH='/sulis/easybuild/software/imkl/2019.5.281-gompi-2019b/mkl/lib/intel64:$LD_LIBRARY_PATH'

module purge
module load intel/2019b
export OMP_NUM_THREADS=1
export LD_LIBRARY_PATH=/sulis/easybuild/software/imkl/2019.5.281-gompi-2019b/mkl/lib/intel64:$LD_LIBRARY_PATH
./RunOMCparts1and2
