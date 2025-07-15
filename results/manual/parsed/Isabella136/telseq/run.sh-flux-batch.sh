#!/bin/bash
#FLUX: --job-name=all_samples
#FLUX: -t=432000
#FLUX: --priority=16

pwd; hostname; date
module load snakemake
snakemake --cluster "sbatch -A {cluster.account} -q {cluster.qos} -c {cluster.cpus-per-task} -N {cluster.Nodes} \
  -t {cluster.runtime} --mem {cluster.mem} -J {cluster.jobname} --mail-type={cluster.mail_type} \
  --mail-user={cluster.mail} --output {cluster.out} --error {cluster.err}" \
  --cluster-config config/cluster.json --jobs 300 --latency-wait 20 --rerun-incomplete --use-envmodules --use-conda --conda-frontend mamba
