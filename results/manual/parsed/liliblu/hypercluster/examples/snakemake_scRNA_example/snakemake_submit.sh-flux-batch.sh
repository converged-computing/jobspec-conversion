#!/bin/bash
#FLUX: --job-name=snakeautocluster
#FLUX: --queue=cpu_long
#FLUX: -t=2419199
#FLUX: --urgency=16

module purge
module add slurm
source activate hc_test
cd /gpfs/data/ruggleslab/home/lmb529/hypercluster/examples/snakemake_scRNA_example
mkdir -p logs/slurm/
snakemake -j 999 -p --verbose \
-s ../../snakemake/hypercluster.smk \
--configfile config.yml \
--keep-going \
--cluster-config cluster.json \
--cluster "sbatch --mem={cluster.mem} -t {cluster.time} -o {cluster.output} -p {cluster.partition}"
