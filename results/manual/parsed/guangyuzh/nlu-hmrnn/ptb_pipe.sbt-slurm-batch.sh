#!/bin/bash
#FLUX: --job-name=PTB_pipe
#FLUX: --queue=p100_4
#FLUX: -t=172800
#FLUX: --urgency=16

CONFIG='small_nets'
module purge
module load tensorflow/python3.5/1.2.1 cuda/8.0.44
cd hierarchical-rnn
python3 -u char_class.py --config $CONFIG > logs/char_class.log
python3 -u ptb_test.py --config $CONFIG > logs/ptb_test.log
TIMESTAMP=$(date +%Y%m%d%H%M%S)
mkdir -p ../backup/$TIMESTAMP
cp logs/char_class.log checkpoint text8.[dim]* ../backup/$TIMESTAMP/
cd ../treebank
python3 evaluate.py > logs/ptb_eval.log
