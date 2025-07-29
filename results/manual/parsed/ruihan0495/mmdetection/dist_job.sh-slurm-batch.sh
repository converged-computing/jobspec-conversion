#!/bin/bash
#SBATCH --job-name=ExampleJob
#SBATCH --output=slurm_output_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:2
#SBATCH --mem=90G
#SBATCH --time=01:00:00

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
source activate mmalb
cp -r $HOME/mmdetection/data "$TMPDIR"
cp -r $HOME/mmdetection/configs "$TMPDIR"
cd "$TMPDIR"
pwd
ls
CONFIG=$1
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
srun python -u $HOME/mmdetection/tools/train.py $CONFIG --launcher="slurm" ${@:2}
cp -r work_dirs/cascade_df2 $HOME/mmdetection/scratch_output
