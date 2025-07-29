#!/bin/bash
#SBATCH --output=%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:0
#SBATCH --mem=32G
#SBATCH --time=00:00:59

source activate pytorch
python preprocess.py -train_src /home/rajaunbc/project/rajaunbc/data/stanfordnmt/training.tok.en -train_tgt /home/rajaunbc/project/rajaunbc/data/stanfordnmt/training.tok.de -valid_src /home/rajaunbc/project/rajaunbc/data/stanfordnmt/newstest2015.tok.en -valid_tgt /home/rajaunbc/project/rajaunbc/data/stanfordnmt/newstest2015.tok.de -save_data data/stan_en_de_50k -src_vocab_size 50000 -tgt_vocab_size 50000 -lower
