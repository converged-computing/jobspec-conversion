#!/bin/bash
#SBATCH --job-name=namd
#SBATCH --account=SNICyyyy-xx-yy
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:2
#SBATCH --time=00:08:00
#SBATCH: --exclusive

ml purge  > /dev/null 2>&1 
ml GCC/9.3.0  CUDA/11.0.2  OpenMPI/4.0.3
ml NAMD/2.14-nompi 
namd2 +p28 +setcpuaffinity +idlepoll +devices $CUDA_VISIBLE_DEVICES step4_equilibration.inp > output_gpu1.dat
namd2 +p28 +setcpuaffinity +idlepoll +devices $CUDA_VISIBLE_DEVICES step4_equilibration_mts.inp > output_gpu2.dat
