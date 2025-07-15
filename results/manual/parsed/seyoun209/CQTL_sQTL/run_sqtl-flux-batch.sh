#!/bin/bash
#FLUX: --job-name=gassy-salad-4492
#FLUX: --priority=16

set -e
module load python/3.9.6
python3 -m venv env && source env/bin/activate && pip3 install -r config/requirements.txt
mkdir -p output/logs_slurm
snakemake -s snakefiles/sqtl.snakefile --configfile "config/rna_prcoess.yaml" --cluster-config "config/cluster.yaml" --cluster "sbatch -J {cluster.name} -p {cluster.partition} -t {cluster.time} -c {cluster.cpusPerTask} --mem-per-cpu={cluster.memPerCpu} -N {cluster.nodes} --output {cluster.output} --error {cluster.error} --parsable" --cluster-status snakefiles/utils/status.py -j 460 --max-jobs-per-second 5 --max-status-checks-per-second 0.2 --rerun-incomplete -p --latency-wait 500 --dry-run
echo "Workflow completed successfully!"
