#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=broadwl
#FLUX: -t=86400
#FLUX: --priority=16

echo "hello world3"
snakemake --jobs 200 -p --ri --cluster-config cluster-config.json --cluster "sbatch --partition={cluster.partition} --job-name={cluster.name} --output=/dev/null --job-name={cluster.name} --nodes={cluster.n} --mem={cluster.mem}"
