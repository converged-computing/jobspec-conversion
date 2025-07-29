#!/bin/bash
#SBATCH --job-name=emu_gpu_test
#SBATCH --account=m3018
#SBATCH --mail-user=eugene.willcox@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:8
#SBATCH --time=00:15:00
#SBATCH --constraint=gpu

export OMP_PLACES='cores'
export OMP_PROC_BIND='true'
export OMP_NUM_THREADS='5'

cd $SLURM_SUBMIT_DIR
export OMP_PLACES=cores
export OMP_PROC_BIND=true
export OMP_NUM_THREADS=5
srun --cpu_bind=cores ./main3d.gnu.DEBUG.TPROF.MPI.CUDA.ex inputs_bipolar_test
