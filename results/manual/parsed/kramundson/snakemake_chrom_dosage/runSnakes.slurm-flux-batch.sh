#!/bin/bash
#FLUX: --job-name=snake_mapping
#FLUX: -t=259200
#FLUX: --urgency=16

date
hostname
source activate dosage
snakemake -j 7 -s 1_init_genome_fofn.snakes --cluster-config cluster.yaml --cluster "sbatch -p {cluster.partition} -n {cluster.n} -t {cluster.time} -c {cluster.c} --mem-per-cpu {cluster.mempercpu}" -k -w 120
snakemake -j 999 -s 2_fastq_to_dosage_plot.snakes --cluster-config cluster.yaml --cluster "sbatch -p {cluster.partition} -n {cluster.n} -t {cluster.time} -c {cluster.c} --mem-per-cpu {cluster.mempercpu}" -k -w 120
source deactivate
date
