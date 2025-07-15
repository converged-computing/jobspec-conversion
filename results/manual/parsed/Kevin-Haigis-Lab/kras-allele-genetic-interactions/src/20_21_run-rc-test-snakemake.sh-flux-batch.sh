#!/bin/bash
#FLUX: --job-name=gloopy-motorcycle-7757
#FLUX: --urgency=16

module load gcc conda2 slurm-drmaa/1.1.0
source activate rctest
snakemake \
  --snakefile src/20_20_rc-test-Snakefile \
  --jobs 9950 \
  --restart-times 0 \
  --cluster-config config/rc-test-snakemake-cluster.json \
  --latency-wait 120 \
  --drmaa " -c {cluster.cores} -p {cluster.partition} --mem={cluster.mem} -t {cluster.time} -o {cluster.out} -e {cluster.err} -J {cluster.J}"
