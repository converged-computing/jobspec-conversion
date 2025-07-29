#!/bin/bash
#SBATCH --job-name=TLS-disp
#SBATCH --account=<account>
#SBATCH --output=logs/%j_disp.log
#SBATCH --error=logs/%j_disp.log
#SBATCH --mail-user=<email>
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=4-00:00:00
#SBATCH --qos=<account

pwd; hostname; date
module load conda
module load snakemake
snakemake --profiles profiles/slurm
