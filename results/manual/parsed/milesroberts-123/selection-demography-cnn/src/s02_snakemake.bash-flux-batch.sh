#!/bin/bash
#FLUX: --job-name=hanky-parrot-8290
#FLUX: --queue=josephsnodes
#FLUX: -t=604800
#FLUX: --priority=16

echo "This job is running on $HOSTNAME on `date`"
echo Loading snakemake...
conda activate snakemake
echo Changing directory...
cd ../workflow
echo Unlocking snakemake...
snakemake --unlock --cores 1
echo Running snakemake...
snakemake --cluster "sbatch --time 3:59:00 --qos=scavenger --cpus-per-task={threads} --mem-per-cpu={resources.mem_mb_per_cpu}" --jobs 950 --cores 950 --use-conda --rerun-incomplete --rerun-triggers mtime --scheduler greedy --retries 3 --keep-going
