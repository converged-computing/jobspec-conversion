#!/bin/bash
#SBATCH --job-name=EBcache
#SBATCH --output=slogs/%x-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=500M
#SBATCH --time=20:00:00
#SBATCH --partition=long

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
