#!/bin/bash
#SBATCH --job-name=EBcache
#SBATCH --output=slogs/%x-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=500M
#SBATCH --time=1-10:00:00

export LOGDIR='${HOME}/scratch/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}'
export TMPDIR='/fast/users/${USER}/scratch/tmp;'

SNAKE_HOME=$(pwd);
export LOGDIR=${HOME}/scratch/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}
export TMPDIR=/fast/users/${USER}/scratch/tmp;
mkdir -p $LOGDIR;
set -x;
eval "$($(which conda) shell.bash hook)"
conda activate snake-env;
echo $CONDA_PREFIX "activated";
SLURM_CLUSTER="sbatch -p {cluster.partition} -t {cluster.t} --mem-per-cpu={cluster.mem} -J {cluster.name} --nodes={cluster.nodes} -n {cluster.threads}";
SLURM_CLUSTER="$SLURM_CLUSTER -o ${LOGDIR}/{rule}-%j.log";
snakemake --snakefile cacheSnakefile --unlock
snakemake --dag | awk '$0 ~ "digraph" {p=1} p' | dot -Tsvg > dax/cacheDag.svg
snakemake --snakefile cacheSnakefile --use-conda \
--rerun-incomplete \
--cluster-config configs/cluster/PONcache-cluster.json \
--cluster "$SLURM_CLUSTER" \
-prkj 3000
