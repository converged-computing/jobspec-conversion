#!/bin/bash
#SBATCH --job-name=eiafcst
#SBATCH --account=eiafcst
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=12:00:00
#SBATCH --partition=shared

module purge
module load cuda/9.2.148
module load python/anaconda3.2019.3
source /share/apps/python/anaconda3.2019.3/etc/profile.d/conda.sh
nvidia-smi
tid=$SLURM_ARRAY_TASK_ID
echo "python eiafcst/models/hpar_opt.py $1 $2 $3${tid}.csv"
python eiafcst/models/hpar_opt.py $1 $2 $3${tid}.csv
