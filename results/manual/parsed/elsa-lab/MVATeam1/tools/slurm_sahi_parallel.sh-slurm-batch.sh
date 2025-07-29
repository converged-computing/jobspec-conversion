#!/bin/bash
#SBATCH --job-name=MVA2023_object_detection
#SBATCH --account=MST109262
#SBATCH --output=test.out
#SBATCH --error=test.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:2
#SBATCH --partition=gtest
#SBATCH --constraint=ntasks-per-node=2

export MASTER_PORT='9487'
export OMP_NUM_THREADS='4'
export MKL_NUM_THREADS='4'

module purge
module load miniconda3
module load cuda/11.5
module load gcc10
module load cmake
conda activate mva_team1
CONFIG=$1
MODEL=$2
DATADIR=$3
ANNOTATION=$4
PY_ARGS=${@:5}
export MASTER_PORT=9487
echo $CONFIG
export OMP_NUM_THREADS=4
export MKL_NUM_THREADS=4
srun --kill-on-bad-exit=1 \
    python -u tools/sahi_evaluation_slurm.py ${CONFIG} ${MODEL} ${DATADIR} ${ANNOTATION} ${PY_ARGS}
