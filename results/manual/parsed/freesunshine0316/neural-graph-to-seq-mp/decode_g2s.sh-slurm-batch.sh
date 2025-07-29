#!/bin/bash
#SBATCH --output=decode.out
#SBATCH --error=decode.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=10GB
#SBATCH --time=01:00:00
#SBATCH --constraint=K80

export PYTHONPATH='$PYTHONPATH:/home/lsong10/ws/exp.graph_to_seq/neural-graph-to-seq-mp'

export PYTHONPATH=$PYTHONPATH:/home/lsong10/ws/exp.graph_to_seq/neural-graph-to-seq-mp
python src_g2s/G2S_beam_decoder.py --model_prefix logs_g2s/G2S.$1 \
        --in_path data/test.json \
        --out_path logs_g2s/test.g2s.$1\.tok \
        --mode beam
