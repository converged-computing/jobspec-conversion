#!/bin/bash
#SBATCH --job-name=example_name
#SBATCH --output=log_copywriter_%j.log
#SBATCH --mail-user=example@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

module load nextflow
nextflow run /gpfs/data/davolilab/data/WGS/01-scripts/wgs-copynumber-workflow/wgs-copynumber.nf -with-report report-nextflow-copywriter-$(date +"%Y%m%d%H%m").html -resume
