#!/bin/bash
#SBATCH -p defq,sched_mem1TB,quicktest
#SBATCH -n 1
#SBATCH --time=1-00:00:00
#SBATCH -o mainout.txt
#SBATCH -e mainerr.txt
#SBATCH --mem=2000
#SBATCH --mail-user=aconwill@mit.edu
#SBATCH --mail-type=ALL
#SBATCH --exclude=node310

bash snakemakeslurm.sh

echo Done!!!
