#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=94G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu_4,gpu_8

echo "$0" "$@"
module load compiler/gnu/10.2
module load mpi/openmpi
eval "$(conda shell.bash hook)"
conda activate onlypybin
env
nvidia-smi
echo q | htop -C  | tail -c +10
set -eu
numsimul="$1"
shift
./run-simul.sh "$numsimul" 1 "$@"
