#!/bin/bash
#FLUX: --job-name=somVars
#FLUX: -n=2
#FLUX: --queue=long
#FLUX: -t=3600
#FLUX: --urgency=16

export LOGDIR='${HOME}/scratch/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}'
export TMPDIR='/fast/users/${USER}/scratch/tmp;'

SNAKE_HOME=$(pwd);
export LOGDIR=${HOME}/scratch/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}
export TMPDIR=/fast/users/${USER}/scratch/tmp;
mkdir -p $LOGDIR;
set -x;
eval "$($(which conda) shell.bash hook)"
conda activate cellranger-env;
echo $CONDA_PREFIX "activated";
SLURM_CLUSTER="sbatch -p {cluster.partition} -t {cluster.t} --mem-per-cpu={cluster.mem} -J {cluster.name} --nodes={cluster.nodes} -n {cluster.threads}";
SLURM_CLUSTER="$SLURM_CLUSTER -o ${LOGDIR}/{rule}-%j.log";
snakemake --unlock
snakemake --use-conda \
--rerun-incomplete \
--snakefile Snaketest \
--cluster-config test/test-cluster.json \
--cluster "$SLURM_CLUSTER" \
 -prk -j 62;
