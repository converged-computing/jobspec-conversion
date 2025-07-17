#!/bin/bash
#FLUX: --job-name=topreco_v2
#FLUX: -c=10
#FLUX: -t=14400
#FLUX: --urgency=16

which python
cd /global/homes/x/xju/code/root_gnn
train_top_reco configs/train_topreco_2tops_v2.yaml
