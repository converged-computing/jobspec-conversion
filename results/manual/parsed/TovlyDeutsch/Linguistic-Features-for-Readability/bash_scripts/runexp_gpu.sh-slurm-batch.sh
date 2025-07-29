#!/bin/bash
#SBATCH --mail-user=tdeutsch@college.harvard.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=10000
#SBATCH --time=00:08:00

echo ${RUN_CONFIG}
module load Anaconda3/5.0.1-fasrc02
module load cuda/10.0.130-fasrc01 cudnn/7.4.1.5_cuda10.0-fasrc01
source activate 2tf1.14_cuda10
python -W ignore runner.py -a ${SLURM_ARRAY_TASK_ID} ${RUN_CONFIG}
