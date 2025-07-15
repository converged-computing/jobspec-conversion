#!/bin/bash
#FLUX: --job-name=gloopy-knife-9176
#FLUX: -c=2
#FLUX: -t=43200
#FLUX: --priority=16

module load miniconda
source activate shardProcess
cp $1 /tmp/ToShard.tar
cp $2 /tmp/meta.mat
srun python dataset_sharding.py -c shardImageNetTrain
cp /tmp/Sharded/* $3
