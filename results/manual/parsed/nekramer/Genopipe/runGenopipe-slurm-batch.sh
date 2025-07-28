#!/bin/bash
#FLUX: --job-name=Genopipe
#FLUX: --queue=general
#FLUX: -t=86400
#FLUX: --urgency=16

module load python/3.6.6
module load plink
python3 -m venv env && source env/bin/activate && pip3 install -r config/requirements.txt
mkdir -p output/logs_slurm
snakemake -j 1 --latency-wait 500 -s snakefiles/genoProc --cluster-config "config/cluster.yaml" --cluster "sbatch -J {cluster.name} -p {cluster.partition} -t {cluster.time} -c {cluster.cpusPerTask} --mem-per-cpu={cluster.memPerCpu} -N {cluster.nodes} --output {cluster.output} --error {cluster.error} --constraint={cluster.constraint} --parsable" --cluster-status ./scripts/status.py
