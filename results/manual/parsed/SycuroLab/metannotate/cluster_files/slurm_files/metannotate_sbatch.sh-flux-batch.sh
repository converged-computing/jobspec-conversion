#!/bin/bash
#FLUX: --job-name=phat-leopard-7039
#FLUX: --queue=cpu2019
#FLUX: -t=172800
#FLUX: --priority=16

log_dir="$(pwd)"
log_file="logs/metannotate-analysis.log.txt"
num_jobs=10
echo "started at: `date`"
snakemake --cluster-config cluster.json --cluster 'sbatch --partition={cluster.partition} --cpus-per-task={cluster.cpus-per-task} --nodes={cluster.nodes} --ntasks={cluster.ntasks} --time={cluster.time} --mem={cluster.mem} --output={cluster.output} --error={cluster.error}' --jobs $num_jobs --use-conda &> $log_dir/$log_file
echo "finished with exit code $? at: `date`"
