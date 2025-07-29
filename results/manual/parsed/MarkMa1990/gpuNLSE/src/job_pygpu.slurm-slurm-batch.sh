#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=outtest.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=2GB
#SBATCH --time=01:30:00
#SBATCH --exclude=calcul-gpu-lahc-5

source /home_expes/tools/python/python367_gpu
echo "on node: " $SLURMD_NODENAME
srun --exclusive nvidia-smi
echo ""
cmake --version
cmake -DBOOST_DIR=/home_expes/tools/boost/boost_1_66_0 .
make
srun --exclusive ./main_loop
