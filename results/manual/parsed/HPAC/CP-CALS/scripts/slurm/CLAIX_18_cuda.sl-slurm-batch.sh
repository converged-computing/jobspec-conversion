#!/bin/bash
#SBATCH --job-name=Bench-CU
#SBATCH --output=output.%J.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:volta:2
#SBATCH --mem=50G
#SBATCH --time=02:00:00
#SBATCH --partition=c18g
#SBATCH: --exclusive

export OMP_NUM_THREADS='24'
export OMP_THREAD_LIMIT='24'

module load DEVELOP
module load gcc/9
module load cuda/11.2
source ~/.zshrc.local
cd ${CALS_DIR} || exit
cd build_cuda || exit
make -j 48
numactl -H
numactl --cpubind=0,1 --membind=0,1 -- numactl -show
export OMP_NUM_THREADS=24
export OMP_THREAD_LIMIT=24
numactl --cpubind=0,1 --membind=0,1 -- ./src/experiments/experiments_jk 24
