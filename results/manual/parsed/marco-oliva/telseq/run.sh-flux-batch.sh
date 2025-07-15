#!/bin/bash
#FLUX: --job-name=TLS-disp
#FLUX: -t=345600
#FLUX: --urgency=16

pwd; hostname; date
module load snakemake
snakemake --cluster "sbatch -A {cluster.account} -q {cluster.qos} -c {cluster.cpus-per-task} -N {cluster.Nodes} \
  -t {cluster.runtime} --mem {cluster.mem} -J {cluster.jobname} --mail-type={cluster.mail_type} \
  --mail-user={cluster.mail} --output {cluster.out} --error {cluster.err}" \
  --cluster-config config/cluster.json --jobs 100 --latency-wait 20 --rerun-incomplete --use-envmodules
