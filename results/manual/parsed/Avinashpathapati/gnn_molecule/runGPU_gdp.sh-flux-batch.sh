#!/bin/bash
#FLUX: --job-name=anxious-dog-3731
#FLUX: --queue=gpu
#FLUX: -t=174180
#FLUX: --urgency=16

cd /home/s3754715/gnn_molecule/pytorch_geometric/examples/
python omdb_nn_conv.py > out.txt
