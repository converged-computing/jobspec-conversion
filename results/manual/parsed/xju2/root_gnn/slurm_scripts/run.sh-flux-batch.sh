#!/bin/bash
#FLUX: --job-name=loopy-bike-5394
#FLUX: --priority=16

which python
cd /global/homes/x/xju/code/root_gnn
train_top_reco configs/train_topreco_2tops_v2.yaml
