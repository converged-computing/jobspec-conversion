#!/bin/bash
#SBATCH --account=C3SE2019-1-14
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=7-00:00:00
#SBATCH --partition=vera

source $HOME/loadenv_gpu.sh
cd /c3se/users/zrimec/Vera/projects/DeepExpression/2019_2_22
snakemake -j 1 --latency-wait 22 --max-jobs-per-second 1 --forceall --resources gpu=200 mem_frac=160 > _run_hyperas_scerevisiae_l2.log  
