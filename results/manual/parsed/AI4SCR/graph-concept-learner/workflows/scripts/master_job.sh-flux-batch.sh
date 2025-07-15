#!/bin/bash
#FLUX: --job-name="m_graph_gen"
#FLUX: -t=356400
#FLUX: --priority=16

module purge
module load gcc/8.2.0 python/3.8.5
source $HOME/gcl/bin/activate
cd $HOME/graph-concept-learner-pub/workflows
snakemake pretrain_all
