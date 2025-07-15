#!/bin/bash
#FLUX: --job-name=RNAseq
#FLUX: -n=2
#FLUX: --queue=medium
#FLUX: -t=72000
#FLUX: --priority=16

export LOGDIR='${HOME}/scratch/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}'
export TMPDIR='/fast/users/${USER}/scratch/tmp;'

SNAKE_HOME=$(pwd);
export LOGDIR=${HOME}/scratch/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}
export TMPDIR=/fast/users/${USER}/scratch/tmp;
mkdir -p $LOGDIR;
eval "$($(which conda) shell.bash hook)"
conda activate snake-env;
echo $CONDA_PREFIX "activated";
set -x;
SLURM_CLUSTER="sbatch -p {cluster.partition} -t {cluster.t} --mem-per-cpu={cluster.mem} -J {cluster.name} --nodes={cluster.nodes} -n {cluster.threads}";
SLURM_CLUSTER="$SLURM_CLUSTER -o ${LOGDIR}/{rule}-%j.log"
snakemake --unlock --rerun-incomplete;
snakemake --dag | awk '$0 ~ "digraph" {p=1} p' | dot -Tsvg > dax/dag.svg;
snakemake --use-conda --rerun-incomplete --cluster-config config/cluster/RNAseq-cluster.json --cluster "$SLURM_CLUSTER" -prk -j 1000;
