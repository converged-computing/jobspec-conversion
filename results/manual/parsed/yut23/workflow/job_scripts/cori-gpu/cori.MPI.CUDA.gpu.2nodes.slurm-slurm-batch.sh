#!/bin/bash
#SBATCH --job-name=castro_gpu_job
#SBATCH --account=[your
#SBATCH --mail-user=[your
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
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
srun --cpu_bind=cores ./Castro3d.gnu.TPROF.MPI.CUDA.ex inputs.3d.sph.testsuite
