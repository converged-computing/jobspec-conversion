#!/bin/bash
#FLUX: --job-name=timecourse
#FLUX: -t=691200
#FLUX: --urgency=16

unset TMPDIR
module load python3
snakemake --rerun-incomplete --configfile config.yaml --snakefile Snakefile -c 20 --jobs 10 --directory . --cluster-config hipergator.cluster.json --cluster "sbatch --qos={cluster.qos} -c {cluster.c} -n {cluster.N} --mail-type=FAIL --mail-user=mallory.morgan@ufl.edu -t {cluster.time} --mem={cluster.mem} -J "timecourse" -o timecourse_%j.out -D /blue/peter/mallory.morgan/rnastar_deseq2_MeJA_timecourse"
