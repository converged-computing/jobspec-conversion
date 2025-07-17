#!/bin/bash
#FLUX: --job-name=dirty-pastry-8665
#FLUX: -c=2
#FLUX: --queue=dgx-common,gpu
#FLUX: -t=43200
#FLUX: --urgency=16

module load miniconda
source activate shardProcess
cp $1 /tmp/ToShard.tar
cp $2 /tmp/meta.mat
srun python dataset_sharding.py -c shardImageNetTrain
cp /tmp/Sharded/* $3
