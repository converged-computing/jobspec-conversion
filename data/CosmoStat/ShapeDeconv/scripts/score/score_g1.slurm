#!/bin/bash
#SBATCH --job-name=tikho_train       # job name
#SBATCH --ntasks=1                   # number of MP tasks
#SBATCH --ntasks-per-node=1          # number of MPI tasks per node
#SBATCH --gres=gpu:1                 # number of GPUs per node
#SBATCH --cpus-per-task=10           # number of cores per tasks
# /!\ Caution, in the following line, "multithread" refers to hyperthreading.
#SBATCH --hint=nomultithread         # we get physical cores not logical
#SBATCH --distribution=block:block   # we pin the tasks on contiguous cores
#SBATCH --time=14:00:00               # maximum execution time (HH:MM:SS)
#SBATCH --output=score_g1%j.out   # output file name
#SBATCH --error=score_g1%j.out    # error file name


module purge
module load tensorflow-gpu/py3/1.15.2

set -x

export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/alpha-transform"
export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/score"

cd $WORK/GitHub/ShapeDeconv/scripts

python ./score_g1.py