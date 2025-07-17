#!/bin/bash
#FLUX: --job-name=frigid-cupcake-6562
#FLUX: --queue=josephsnodes
#FLUX: -t=604800
#FLUX: --urgency=16

echo "This job is running on $HOSTNAME on `date`"
echo Loading snakemake...
conda activate snakemake
echo Changing directory...
cd ../workflow
echo Unlocking snakemake...
snakemake --unlock --cores 1
echo Running snakemake...
snakemake --cluster "sbatch --time 7-00:00:00 --qos=scavenger --partition=josephsnodes --account=josephsnodes --cpus-per-task={threads} --mem-per-cpu={resources.mem_mb_per_cpu}" --jobs 990 --cores 1024 --use-conda --retries 5 --rerun-incomplete --rerun-triggers mtime
