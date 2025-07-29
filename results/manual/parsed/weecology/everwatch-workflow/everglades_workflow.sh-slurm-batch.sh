#!/bin/bash
#SBATCH --job-name=everglades_workflow
#SBATCH --output=/blue/ewhite/everglades/everwatch-workflow/logs/everglades_workflow.out
#SBATCH --error=/blue/ewhite/everglades/everwatch-workflow/logs/everglades_workflow.err
#SBATCH --mail-user=henrysenyondo@ufl.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=60
#SBATCH --gres=a100:4
#SBATCH --mem=600gb
#SBATCH --time=3-08:00:00

echo "INFO: [$(date "+%Y-%m-%d %H:%M:%S")] Starting everglades workflow on $(hostname) in $(pwd)"
echo "INFO [$(date "+%Y-%m-%d %H:%M:%S")] Loading required modules"
source /etc/profile.d/modules.sh
ml conda
conda activate everwatch
cd /blue/ewhite/everglades/everwatch-workflow/
snakemake --unlock
echo "INFO [$(date "+%Y-%m-%d %H:%M:%S")] Starting Snakemake pipeline"
snakemake --printshellcmds --keep-going --cores 60 --resources gpu=4 --rerun-incomplete --latency-wait 10 --use-conda
echo "INFO [$(date "+%Y-%m-%d %H:%M:%S")] End"
