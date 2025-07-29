#!/bin/bash
#SBATCH --job-name=pipeline
#SBATCH --output=pipeline.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=3-00:00:00

RULES=Snakefile
CONFIG=../config/config.yaml
CLUSTER_CONFIG=cluster.yaml
CLUSTER='sbatch --mem={cluster.mem} -t {cluster.time} -c {cluster.cores} -J {cluster.jobname} --nodelist={cluster.nodelist} -o logs/{cluster.out} -e logs/{cluster.error}'
MAX_JOBS=500
rm -fr .snakemake
mkdir -p logs
snakemake --configfile $CONFIG -s $RULES --dag | dot -Tpdf > dag.pdf
snakemake --configfile $CONFIG -s $RULES -p -j $MAX_JOBS --cluster-config $CLUSTER_CONFIG --cluster "$CLUSTER" --use-conda
exit 0
