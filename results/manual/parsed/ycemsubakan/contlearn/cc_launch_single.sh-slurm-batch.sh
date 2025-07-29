#!/bin/bash
#SBATCH --account=rpp-bengioy
#SBATCH --output=logs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=00:00:50

source ~/torch/bin/activate 
cd ~/contlearn
python main_mnist.py --dataset_name mnist_plus_fmnist --prior vampprior_short --replay_size constant --use_mixingw_correction 0 --add_cap 1 --number_components 50 --number_components_init 50 --replay_type replay --notes 'mpfmnistb1' --use_vampmixingw 1 --separate_means 0 --restart_means 1 --use_classifier 1  --use_replaycostcorrection 1 --use_visdom 1 --dynamic_binarization 0 --permindex 0 --semi_sup 0 --classifier_EP 75 --use_entrmax 1 --load_model --debug --use_visdom 0 --classifier_lr 0.0005
