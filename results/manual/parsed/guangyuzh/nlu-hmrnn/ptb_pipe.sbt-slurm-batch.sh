#!/bin/bash
#SBATCH --job-name=PTB_pipe
#SBATCH --output=logs/ptb_pipe.out
#SBATCH --mail-user=gz612@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=p100_4

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
