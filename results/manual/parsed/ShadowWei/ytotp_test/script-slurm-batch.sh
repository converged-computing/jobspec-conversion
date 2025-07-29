#!/bin/bash
#SBATCH --job-name=comp_422_openmp
#SBATCH --account=soc-kp
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --mem=10G
#SBATCH --time=00:10:00
#SBATCH --partition=soc-kp
#SBATCH --constraint=ntasks-per-node=1

ulimit -c unlimited -s
mpiexec -n 2 python -m ytopt.search.async_search --prob_path=problems/convolution-2d/problem.py --exp_dir=experiments/exp-4 --prob_attr=problem --exp_id=exp-4  --max_time=60 --base_estimator='RF'
