#!/bin/bash
#SBATCH --account=def-geof
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4000M
#SBATCH --time=00:00:30
#SBATCH --array=1-10

source /home/syz/sdecouplings/bin/activate
SRAND=$RANDOM
echo $SRAND
nvidia-smi
python faces.py --srcpath /home/syz/syz/wtf/src --n_iter 25 --outfile "output_$SRAND" --r __R__ --srand $SRAND
