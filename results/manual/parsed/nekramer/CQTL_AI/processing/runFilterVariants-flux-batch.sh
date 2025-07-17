#!/bin/bash
#FLUX: --job-name=filterVariants
#FLUX: --queue=general
#FLUX: -t=864000
#FLUX: --urgency=16

module load python/3.6.6
python3 -m venv env && source env/bin/activate && pip3 install -r config/requirements.txt
mkdir -p output/logs_slurm
snakemake -j 100 --max-jobs-per-second 5 --rerun-incomplete -s snakefiles/filterVariants.smk --until concatVariantHets_part2 --cluster-config "config/cluster.yaml" --cluster "sbatch -J {cluster.name} -p {cluster.partition} -t {cluster.time} -c {cluster.cpusPerTask} --mem-per-cpu={cluster.memPerCpu} -N {cluster.nodes} --output {cluster.output} --error {cluster.error} --parsable" --cluster-status ./scripts/status.py
