#!/bin/bash
#FLUX: --job-name=gloopy-avocado-8416
#FLUX: --urgency=16

snakemake -s run_CGEtools.snake.py --cluster "sbatch -n1 -t 1-00:00:00 --mem 49152 -o Cluster_%A_job.out" -j 8
