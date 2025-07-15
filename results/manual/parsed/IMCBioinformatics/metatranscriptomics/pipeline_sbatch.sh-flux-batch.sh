#!/bin/bash
#FLUX: --job-name=scruptious-dog-9163
#FLUX: -c=8
#FLUX: --queue=synergy,cpu2019,cpu2021
#FLUX: -t=604800
#FLUX: --urgency=16

log_dir="$(pwd)"
log_file="logs/pipeline-analysis.log.txt"
num_jobs=60
snakemake --unlock
echo "started at: `date`"
snakemake --latency-wait 100 --rerun-incomplete --cluster-config cluster.json --cluster 'sbatch --partition={cluster.partition} --cpus-per-task={cluster.cpus-per-task} --nodes={cluster.nodes} --ntasks={cluster.ntasks} --time={cluster.time} --mem={cluster.mem} --output={cluster.output} --error={cluster.error}' --jobs $num_jobs --use-conda &>> $log_dir/$log_file
echo "finished with exit code $? at: `date`"
