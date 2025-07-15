#!/bin/bash
#FLUX: --job-name=snakeautocluster
#FLUX: -c=2
#FLUX: --queue=cpu_long
#FLUX: -t=2419199
#FLUX: --priority=16

module purge
module add slurm
source activate hypercluster
cd /gpfs/home/lmb529/ruggleslabHome/hypercluster
mkdir -p logs/slurm/
snakemake -j 999 -p --verbose \
-s hypercluster.smk \
--keep-going \
--cluster-config cluster.json \
--cluster "sbatch --mem={cluster.mem} -t {cluster.time} -o {cluster.output} -p {cluster.partition}"
