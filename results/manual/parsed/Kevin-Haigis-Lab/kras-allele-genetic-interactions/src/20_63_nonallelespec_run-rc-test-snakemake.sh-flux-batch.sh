#!/bin/bash
#FLUX: --job-name=gassy-sundae-9088
#FLUX: --queue=priority
#FLUX: -t=172800
#FLUX: --urgency=16

module unload python
module load gcc conda2 slurm-drmaa/1.1.1
conda activate rctest
snakemake \
  --snakefile src/20_62_nonallelespec_rc-test-Snakefile.py \
  --jobs 9980 \
  --restart-times 0 \
  --cluster-config config/rc-test-snakemake-cluster.json \
  --latency-wait 120 \
  --drmaa " -c {cluster.cores} -p {cluster.partition} --mem={cluster.mem} -t {cluster.time} -o {cluster.out} -e {cluster.err} -J {cluster.J}"
conda deactivate
