#!/bin/bash
#SBATCH --output=%j-%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:2
#SBATCH --mem=127518M
#SBATCH --time=00:00:30

model=f_1i_mal_y
module load cuda cudnn python/3.6.3
echo "Present working directory is $PWD"
source $HOME/tensorflow/bin/activate
python $HOME/brainlearning/brainlearning/operations.py --mode generate --model $model --model_dir $model/ --images_dir_path ../project/ml-bet/
