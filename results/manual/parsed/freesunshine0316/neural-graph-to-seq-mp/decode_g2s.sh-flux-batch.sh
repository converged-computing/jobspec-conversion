#!/bin/bash
#FLUX: --job-name=rainbow-leg-4961
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/home/lsong10/ws/exp.graph_to_seq/neural-graph-to-seq-mp'

export PYTHONPATH=$PYTHONPATH:/home/lsong10/ws/exp.graph_to_seq/neural-graph-to-seq-mp
python src_g2s/G2S_beam_decoder.py --model_prefix logs_g2s/G2S.$1 \
        --in_path data/test.json \
        --out_path logs_g2s/test.g2s.$1\.tok \
        --mode beam
