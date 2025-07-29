#!/bin/bash
#SBATCH --account=
#SBATCH --output=output.txt
#SBATCH --error=errors.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00

cd /scratch/$USER/
module purge
module use /nopt/nrel/apps/modules/test/modulefiles/
module load conda
module load gcc/7.4.0
module load cudnn/8.0.5/cuda-10.2
sleep 3
source activate py38tf24
sleep 5
python3 TFbenchmark.py
