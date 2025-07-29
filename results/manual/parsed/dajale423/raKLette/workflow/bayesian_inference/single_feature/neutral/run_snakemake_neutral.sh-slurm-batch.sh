#!/bin/bash
#SBATCH --output=hostname_%j.out
#SBATCH --error=hostname_%j.err
#SBATCH --mail-user=daniel_lee@g.harvard.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=1000M
#SBATCH --time=00:12:00
#SBATCH --partition=short

                                           # You can change the filenames given with -o and -e to any filenames you'd like
rm slurm*
snakemake --unlock
snakemake --cluster "sbatch -c {resources.cpus_per_task} -t {resources.runtime} -p {resources.partition} --mem={resources.mem_mb}" -j 30 --retries 4 --rerun-incomplete
