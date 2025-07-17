#!/bin/bash
#FLUX: --job-name=evasive-train-2515
#FLUX: -c=2
#FLUX: --queue=short
#FLUX: -t=720
#FLUX: --urgency=16

                                           # You can change the filenames given with -o and -e to any filenames you'd like
rm slurm*
snakemake --unlock
snakemake --cluster "sbatch -c {resources.cpus_per_task} -t {resources.runtime} -p {resources.partition} --mem={resources.mem_mb}" -j 30 --retries 4 --rerun-incomplete
