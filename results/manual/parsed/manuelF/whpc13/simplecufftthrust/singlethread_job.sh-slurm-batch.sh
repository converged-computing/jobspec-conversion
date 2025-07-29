#!/bin/bash
#SBATCH --job-name=fft1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

. /etc/profile
module load cuda/5.0
echo "=== FFTW single thread ==="
time srun ./simple_fftw
echo
wait
