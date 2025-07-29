#!/bin/bash
#SBATCH --job-name=MNIST_sweep
#SBATCH --mail-user=rmo2@nist.gov
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=2G\
#SBATCH --time=6-16:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1,ntasks-per-socket=5
#SBATCH --array=1

module purge 
module load python/3.10.9/anaconda
module load julia/1.9.0
module load cuda
conda activate /home/rmo2/envs/testenv
python-jl exp_MNIST_full.py --name test_series2 --digits 3 --run 5 --samples 10 --low_bound 0 --eta 0.0005 --decay True
