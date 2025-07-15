#!/bin/bash
#FLUX: --job-name=doopy-underoos-1046
#FLUX: --queue=gpu
#FLUX: -t=174180
#FLUX: --priority=16

cd /home/s3754715/gnn_molecule/pytorch_geometric/examples/
python omdb_nn_conv.py > out.txt
