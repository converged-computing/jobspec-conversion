#!/bin/bash
#SBATCH --job-name=final
#SBATCH --account=amath
#SBATCH --output=slurm.out
#SBATCH --error=slurm.err
#SBATCH --mail-user=eunkich@uw.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=5G
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=6

module load cuda
rm *.csv
source build_oblas_cublas.sh;
source build_mem_swaps.sh;
source build_file_swaps.sh;
source build_cpu_gpu_bw.sh;
source build_fftw.sh;
source build_cufft.sh;
rm *.o x*
