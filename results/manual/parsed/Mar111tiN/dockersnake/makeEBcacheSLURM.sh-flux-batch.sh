#!/bin/bash
#FLUX: --job-name=EBcache
#FLUX: -n=2
#FLUX: --queue=long
#FLUX: -t=72000
#FLUX: --priority=16

export LOGDIR='${SNAKE_HOME}/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}'
export TMPDIR='/fast/users/${USER}/scratch/tmp;'

SNAKE_HOME=$(pwd);
export LOGDIR=${SNAKE_HOME}/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}
export TMPDIR=/fast/users/${USER}/scratch/tmp;
mkdir -p $LOGDIR;
set -x;
unset DRMAA_LIBRARY_PATH
conda activate somvar-env;
echo $CONDA_PREFIX "activated";
DRMAA=" -p {cluster.partition} -t {cluster.t} --mem-per-cpu={cluster.mem} --nodes={cluster.nodes} -n {cluster.threads}";
DRMAA="$DRMAA -o ${LOGDIR}/{rule}-%j.log";
snakemake --snakefile Snakefiles/EBcacheSnakefile --unlock --rerun-incomplete
snakemake --snakefile Snakefiles/EBcacheSnakefile --dag | dot -Tsvg > dax/EBcache_dag.svg
snakemake --snakefile Snakefiles/EBcacheSnakefile --cluster-config configs/cluster/ebcache-cluster.json --use-conda --rerun-incomplete --drmaa "$DRMAA" -j 3000 -p -r -k
