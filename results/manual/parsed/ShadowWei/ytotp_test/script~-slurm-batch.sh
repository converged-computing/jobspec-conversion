#!/bin/bash
#SBATCH --job-name=comp_422_openmp
#SBATCH --account=soc-kp
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --mem=10G
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

ulimit -c unlimited -s
mpiexec -n 2 python -m ytopt.search.async_search --prob_path=problems/atax/problem.py --exp_dir=experiments/exp-2 --prob_attr=problem --exp_id=exp-2  --max_time=60 --base_estimator='RF'
