#!/bin/bash
#FLUX: --job-name=milky-animal-4006
#FLUX: --priority=16

module load python/3.6.6
python3 -m venv env && source env/bin/activate && pip3 install -r config/requirements.txt
mkdir -p output/logs_slurm
snakemake -j 75 --max-jobs-per-second 5 --latency-wait 500 --rerun-incomplete -s snakefiles/LD.smk --cluster-config "config/cluster.yaml" --cluster "sbatch -J {cluster.name} -p {cluster.partition} -t {cluster.time} -c {cluster.cpusPerTask} --mem-per-cpu={cluster.memPerCpu} -N {cluster.nodes} --output {cluster.output} --error {cluster.error} --constraint={cluster.constraint} --parsable" --cluster-status ./scripts/status.py
