#!/bin/bash
#FLUX: --job-name=blank-signal-8503
#FLUX: -c=5
#FLUX: -t=7200
#FLUX: --urgency=16

module load python
conda activate pytorch-gnn
echo "...building pre-clustering"
python equivariant-tracking/graph-construction/build_pre-clustering.py equivariant-tracking/graph-construction/configs/pre-clustering.yaml --start-evtid=1000 --end-evtid=2500
echo "...done"
