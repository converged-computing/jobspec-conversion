#!/bin/bash
#FLUX --job-name=eccentric-toaster-5626
#FLUX -t=432000
#FLUX --urgency=16

snakemake -j 10 --cluster "sbatch -p largenode -c 16 --mem=100000 -t 2-0" --latency-wait 30
