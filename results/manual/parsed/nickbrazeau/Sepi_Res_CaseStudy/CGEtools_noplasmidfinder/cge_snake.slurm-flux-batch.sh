#!/bin/bash
#FLUX: --job-name=outstanding-blackbean-8349
#FLUX: -t=950400
#FLUX: --urgency=16

snakemake -s run_CGEtools.snake.py --cluster "sbatch -n1 -t 1-00:00:00 --mem 49152 -o Cluster_%A_job.out" -j 8
