#!/bin/bash
#FLUX: --job-name=faux-motorcycle-5916
#FLUX: --priority=16

module load python/3.6.6
python3 -m venv env && source env/bin/activate && pip3 install -r config/requirements.txt
snakemake -j 100 --max-jobs-per-second 5 --latency-wait 30 --rerun-incomplete -s snakefiles/AI_LD_buddies.smk --cluster-config "config/cluster.yaml" --cluster "sbatch -J {cluster.name} -p {cluster.partition} -t {cluster.time} -c {cluster.cpusPerTask} --mem-per-cpu={cluster.memPerCpu} -N {cluster.nodes} --output {cluster.output} --error {cluster.error} --parsable" --cluster-status ./scripts/status.py
