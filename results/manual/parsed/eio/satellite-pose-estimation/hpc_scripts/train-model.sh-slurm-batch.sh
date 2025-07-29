#!/bin/bash
#SBATCH --job-name=CVIA-Train-Stream-2-Elliott
#SBATCH --output=train-model.out
#SBATCH --mail-user=001@student.uni.lu
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

export MODULEPATH='/opt/apps/resif/iris/2019b/gpu/modules/all/'
export ANACONDA='/opt/apps/resif/iris/2019b/default/modules/all/lang/Anaconda3/'

cd /home/users/ewobler/satellite-pose-estimation-main/
conda activate torchit
export MODULEPATH=/opt/apps/resif/iris/2019b/default/modules/all/
module load lang/Anaconda3/2020.02
export ANACONDA=/opt/apps/resif/iris/2019b/default/modules/all/lang/Anaconda3/
export MODULEPATH=/opt/apps/resif/iris/2019b/gpu/modules/all/
module load system/CUDA/
python -u run_model.py
