#!/bin/bash
#FLUX: --job-name=butterscotch-frito-8648
#FLUX: -c=6
#FLUX: -t=720
#FLUX: --urgency=16

model=f_1i_mal_y
module load cuda cudnn python/3.6.3
echo "Present working directory is $PWD"
source $HOME/tensorflow/bin/activate
for i in {1..4}
do
    echo "------------------------------------------------------------------------------"
    echo "$model 500-1 - $i"
    python $HOME/brainlearning/brainlearning/operations.py --mode continue --model $model --model_dir $model/ --batch_size 2 --n_channels 1 --steps_per_epoch 1 --epochs 500 --save_each_epochs 20 --save_each_epochs_dir $HOME/scratch/model/$model/ --images_dir_path ../project/ml-bet/ --verbose 2
done
for i in {1..4}
do
    echo "------------------------------------------------------------------------------"
    echo "$model 200-1 - $i"
    python $HOME/brainlearning/brainlearning/operations.py --mode continue --model $model --model_dir $model/ --batch_size 2 --n_channels 1 --steps_per_epoch 1 --epochs 200 --save_each_epochs 20 --save_each_epochs_dir $HOME/scratch/model/$model/ --images_dir_path ../project/ml-bet/ --verbose 2
done
for i in {1..4}
do
    echo "------------------------------------------------------------------------------"
    echo "$model 100 - $i"
    python $HOME/brainlearning/brainlearning/operations.py --mode continue --model $model --model_dir $model/ --batch_size 2 --n_channels 1 --steps_per_epoch 1 --epochs 100 --save_each_epochs 20 --save_each_epochs_dir $HOME/scratch/model/$model/ --images_dir_path ../project/ml-bet/ --verbose 2
done
for i in {1..2}
do
    echo "------------------------------------------------------------------------------"
    echo "$model 500-2 - $i"
    python $HOME/brainlearning/brainlearning/operations.py --mode continue --model $model --model_dir $model/ --batch_size 2 --n_channels 1 --steps_per_epoch 1 --epochs 500 --save_each_epochs 20 --save_each_epochs_dir $HOME/scratch/model/$model/ --images_dir_path ../project/ml-bet/ --verbose 2
done
for i in {1..2}
do
    echo "------------------------------------------------------------------------------"
    echo "$model 200-1 - $i"
    python $HOME/brainlearning/brainlearning/operations.py --mode continue --model $model --model_dir $model/ --batch_size 2 --n_channels 1 --steps_per_epoch 1 --epochs 200 --save_each_epochs 20 --save_each_epochs_dir $HOME/scratch/model/$model/ --images_dir_path ../project/ml-bet/ --verbose 2
done
for i in {1..6}
do
    echo "------------------------------------------------------------------------------"
    echo "$model 100 - $i"
    python $HOME/brainlearning/brainlearning/operations.py --mode continue --model $model --model_dir $model/ --batch_size 2 --n_channels 1 --steps_per_epoch 1 --epochs 100 --save_each_epochs 20 --save_each_epochs_dir $HOME/scratch/model/$model/ --images_dir_path ../project/ml-bet/ --verbose 2
done
