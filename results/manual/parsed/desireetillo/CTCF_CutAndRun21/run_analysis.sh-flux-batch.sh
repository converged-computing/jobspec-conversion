#!/bin/bash
#FLUX: --job-name=ornery-dog-8609
#FLUX: --queue=ccr
#FLUX: -t=43200
#FLUX: --urgency=16

set -e
module load python/3.5
module load snakemake/5.1.3
mkdir -p Reports
if [ -f Reports/snakemake.log ]; then
    modtime1=`stat -c %y Reports/snakemake.log|awk -F "." '{print $1}'|sed 's/ /_/g' -|sed 's/:/_/g'|sed 's/-/_/g' -`
    mv Reports/snakemake.log Reports/snakemake.log.$modtime1
fi
touch Reports/snakemake.log
snakemake --latency-wait 10 --printshellcmds --cluster-config cluster.json --keep-going --cluster "sbatch --gres {cluster.gres} --cpus-per-task {cluster.threads} -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} --job-name={params.rname}" -j 100 --rerun-incomplete --stats test.stats -T 2>&1|tee -a Reports/snakemake.log
mkdir -p logs/
mv slurm-*out logs/
