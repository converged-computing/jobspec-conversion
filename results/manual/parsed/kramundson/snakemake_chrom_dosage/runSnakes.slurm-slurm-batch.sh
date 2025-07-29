#!/bin/bash
#SBATCH --job-name=snake_mapping
#SBATCH --output=pipeline_test.out
#SBATCH --error=pipeline_test.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=3-00:00:00
#SBATCH --partition=production

date
hostname
source activate dosage
snakemake -j 7 -s 1_init_genome_fofn.snakes --cluster-config cluster.yaml --cluster "sbatch -p {cluster.partition} -n {cluster.n} -t {cluster.time} -c {cluster.c} --mem-per-cpu {cluster.mempercpu}" -k -w 120
snakemake -j 999 -s 2_fastq_to_dosage_plot.snakes --cluster-config cluster.yaml --cluster "sbatch -p {cluster.partition} -n {cluster.n} -t {cluster.time} -c {cluster.c} --mem-per-cpu {cluster.mempercpu}" -k -w 120
source deactivate
date
