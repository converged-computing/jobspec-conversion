#!/bin/bash
#SBATCH --output=ShardTest.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=240G
#SBATCH --time=12:00:00

module load miniconda
source activate shardProcess
cp $1 /tmp/ToShard.tar
cp $2 /tmp/meta.mat
srun python dataset_sharding.py -c shardImageNetTrain
cp /tmp/Sharded/* $3
