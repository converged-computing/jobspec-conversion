#!/bin/bash
#FLUX: --job-name="lcdb-wf"
#FLUX: --queue="norm"
#FLUX: -t=86400
#FLUX: --priority=16

if [[ ! -e logs ]]; then mkdir -p logs; fi
(
    time snakemake \
    -p \
    --directory $PWD \
    -k \
    --rerun-incomplete \
    --jobname "s.{rulename}.{jobid}.sh" \
    -j 999 \
    --cluster-config config/clusterconfig.yaml \
    --verbose \
    --cluster 'sbatch {cluster.prefix} --cpus-per-task={threads}  --output=logs/{rule}.o.%j --error=logs/{rule}.e.%j' \
    --use-conda \
    --configfile config/config.yaml \
    --latency-wait=300 \
    ) > "Snakefile.log" 2>&1
SNAKE_PID=$!
finish(){
    echo 'Stopping running snakemake job.'
    kill -SIGINT $SNAKE_PID
    exit 0
}
trap finish SIGTERM
wait $SNAKE_PID
