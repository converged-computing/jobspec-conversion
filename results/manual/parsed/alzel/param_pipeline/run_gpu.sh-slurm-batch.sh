#!/bin/bash
#SBATCH --account=C3SE2019-1-14
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=7-00:00:00

source $HOME/loadenv_gpu.sh
cd /c3se/users/zrimec/Vera/projects/DeepExpression/2019_3_22
snakemake -j 1 > _run_hyperas_scerevisiae_codons.log
