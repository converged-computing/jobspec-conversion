#!/bin/bash
#FLUX: --job-name=reclusive-blackbean-1004
#FLUX: -c=6
#FLUX: -t=59
#FLUX: --urgency=16

source activate pytorch
python preprocess.py -train_src /home/rajaunbc/project/rajaunbc/data/stanfordnmt/training.tok.en -train_tgt /home/rajaunbc/project/rajaunbc/data/stanfordnmt/training.tok.de -valid_src /home/rajaunbc/project/rajaunbc/data/stanfordnmt/newstest2015.tok.en -valid_tgt /home/rajaunbc/project/rajaunbc/data/stanfordnmt/newstest2015.tok.de -save_data data/stan_en_de_50k -src_vocab_size 50000 -tgt_vocab_size 50000 -lower
