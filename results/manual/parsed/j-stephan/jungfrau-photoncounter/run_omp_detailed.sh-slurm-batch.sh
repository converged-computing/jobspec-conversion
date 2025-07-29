#!/bin/bash
#SBATCH --job-name=OpenMP_Run_detailed
#SBATCH --output=log.od.slurm-%A_%a.out
#SBATCH --error=err.od.slurm-%A_%a.out
#SBATCH --mail-user=j.schenke@hzdr.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=200000
#SBATCH --time=08:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-61

export alpaka_DIR='/home/schenk24/workspace/alpaka/'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/
module load git gcc cmake boost python
cd build_omp
python ../run_detailed.py $SLURM_ARRAY_TASK_ID
