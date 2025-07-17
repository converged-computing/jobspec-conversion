#!/bin/bash
#FLUX: --job-name=RNApipeCore
#FLUX: --queue=general
#FLUX: -t=259200
#FLUX: --urgency=16

set -e
module load python/3.6.6
python3 -m venv env && source env/bin/activate && python3 -m pip install -r config/requirements.txt && pip3 install pandas
mkdir -p output/logs_slurm
snakemake -s workflows/RNApipeCore.snakefile --configfile "config/RNAconfig.yaml" --cluster-config "config/cluster.yaml" --cluster "sbatch -J {cluster.name} -p {cluster.partition} -t {cluster.time} -c {cluster.cpusPerTask} --mem-per-cpu={cluster.memPerCpu} -N {cluster.nodes} --output {cluster.output} --error {cluster.error} --parsable" --cluster-status ./workflows/utils/status.py -j 100 --max-jobs-per-second 5 --max-status-checks-per-second 0.5 --rerun-incomplete -p --latency-wait 500 
snakemake -s workflows/mergeSignal.snakefile --configfile "config/RNAconfig.yaml" --cluster-config "config/cluster.yaml" --cluster "sbatch -J {cluster.name} -p {cluster.partition} -t {cluster.time} -c {cluster.cpusPerTask} --mem-per-cpu={cluster.memPerCpu} -N {cluster.nodes} --output {cluster.output} --error {cluster.error} --parsable" --cluster-status ./workflows/utils/status.py -j 100 --max-jobs-per-second 5 --max-status-checks-per-second 0.5 --rerun-incomplete -p --latency-wait 500 
echo "Workflow completed successfully!"
