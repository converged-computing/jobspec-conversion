#!/bin/bash
#FLUX: --job-name=astute-buttface-2146
#FLUX: --priority=16

snakemake -s run_CGEtools.snake.py --cluster "sbatch -n1 -t 1-00:00:00 --mem 49152 -o Cluster_%A_job.out" -j 8
