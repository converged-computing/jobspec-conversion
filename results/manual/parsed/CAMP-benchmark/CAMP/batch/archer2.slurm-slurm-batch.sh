#!/bin/bash
#SBATCH --job-name=CAMP
#SBATCH --account=ta094-wenqingpen
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --time=01:20:00
#SBATCH --qos=standard

export OMP_NUM_THREADS='128'
export OMP_PROC_BIND='true'

module load cray-python
source /work/ta094/ta094/wenqingpeng/pyenv-camp/bin/activate
export OMP_NUM_THREADS=128
export OMP_PROC_BIND=true
srun --hint=nomultithread --unbuffered ./camp config/example
