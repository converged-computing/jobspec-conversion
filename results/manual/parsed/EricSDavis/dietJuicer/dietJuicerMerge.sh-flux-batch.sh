#!/bin/bash
#FLUX: --job-name=dietJuicerMerge
#FLUX: --queue=general
#FLUX: -t=864000
#FLUX: --urgency=16

set -e
module load python/3.6.6
python3 -m venv env && source env/bin/activate && pip3 install -r config/requirements.txt
mkdir -p output/logs_slurm
snakemake -j 100 --rerun-incomplete --restart-times 3 -p -s workflows/buildHIC --latency-wait 500 --cluster-config "config/cluster.yaml" --cluster "sbatch -J {cluster.name} -p {cluster.partition} -t {cluster.time} -c {cluster.cpusPerTask} --mem-per-cpu={cluster.memPerCpu} -N {cluster.nodes} --output {cluster.output} --error {cluster.error} --parsable" --cluster-status ./scripts/status.py
echo "Entire workflow completed successfully!"
