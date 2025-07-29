#!/bin/bash
#SBATCH --job-name=benchmark_gpu
#SBATCH --account=fc_biome
#SBATCH --output=output_gpu.log
#SBATCH --mail-user=sameli@berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --time=4-00:00:00
#SBATCH --qos=savio_normal

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

PYTHON_DIR=$HOME/programs/miniconda3
SCRIPTS_DIR=$(dirname $PWD)/scripts
LOG_DIR=$PWD
module load cuda/11.2
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
$PYTHON_DIR/bin/python ${SCRIPTS_DIR}/benchmark_speed.py -g > ${LOG_DIR}/stream_output_gpu.txt
