#!/bin/bash
#FLUX: --job-name=fat-kerfuffle-4987
#FLUX: --priority=16

set -e
module load python/3.6.6
python3 -m venv env && source env/bin/activate && pip3 install -r config/requirements.txt
mkdir -p output/logs_slurm
snakemake -s workflows/ATACpipeLauncher.snakefile --configfile "config/ATACconfig.yaml" --cluster-config "config/cluster.yaml" --cluster "sbatch -J {cluster.name} -p {cluster.partition} -t {cluster.time} -c {cluster.cpusPerTask} --mem-per-cpu={cluster.memPerCpu} -N {cluster.nodes} --output {cluster.output} --error {cluster.error} --parsable" --cluster-status ./workflows/utils/status.py -j 100 --max-jobs-per-second 5 --max-status-checks-per-second 5 --rerun-incomplete -p --latency-wait 500 
echo "Workflow completed successfully!"
