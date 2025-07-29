#!/bin/bash
#SBATCH --job-name=CUDA_Run_base_4
#SBATCH --output=log.cb4.slurm-%A_%a.out
#SBATCH --error=err.cb4.slurm-%A_%a.out
#SBATCH --mail-user=j.schenke@hzdr.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:4
#SBATCH --mem=350000
#SBATCH --time=01:00:00
#SBATCH --partition=gpu
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-9

export alpaka_DIR='/home/schenk24/workspace/alpaka/'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/
module load git gcc cmake cuda boost python
cd build_cuda_4
python ../run_base.py $SLURM_ARRAY_TASK_ID
