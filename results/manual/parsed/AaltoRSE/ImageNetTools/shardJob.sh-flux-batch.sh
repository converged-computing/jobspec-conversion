#!/bin/bash
#FLUX: --job-name=chocolate-onion-9163
#FLUX: -c=2
#FLUX: -t=43200
#FLUX: --urgency=16

module load miniconda
source activate shardProcess
cp $1 /tmp/ToShard.tar
cp $2 /tmp/meta.mat
srun python dataset_sharding.py -c shardImageNetTrain
cp /tmp/Sharded/* $3
