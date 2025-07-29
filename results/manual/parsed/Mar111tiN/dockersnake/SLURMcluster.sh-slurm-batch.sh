#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=slogs/%x-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=500M
#SBATCH --time=20:00:00

export LOGDIR='${SNAKE_HOME}/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}'
export TMPDIR='/fast/users/${USER}/scratch/tmp;'

SNAKE_HOME=$(pwd);
export LOGDIR=${SNAKE_HOME}/slogs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}
export TMPDIR=/fast/users/${USER}/scratch/tmp;
mkdir -p $LOGDIR;
set -x;
unset DRMAA_LIBRARY_PATH
conda activate WES-env;
echo $CONDA_PREFIX "activated";
DRMAA=" -p {cluster.partition} -t {cluster.t} --mem-per-cpu={cluster.mem} -J {cluster.name} --nodes={cluster.nodes} -n {cluster.threads}";
DRMAA="$DRMAA -o ${LOGDIR}/{rule}-%j.log";
snakemake --unlock --rerun-incomplete;
snakemake --dag | dot -Tsvg > dax/dag.svg;
snakemake --use-conda --rerun-incomplete --cluster-config configs/cluster/somvar-cluster.json --drmaa "$DRMAA" -prk -j 1000;
