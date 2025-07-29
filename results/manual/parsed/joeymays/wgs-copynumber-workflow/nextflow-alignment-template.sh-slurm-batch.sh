#!/bin/bash
#SBATCH --job-name=example_name
#SBATCH --output=log_alignment_%j.log
#SBATCH --mail-user=example@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

module load nextflow
nextflow run /gpfs/data/davolilab/data/WGS/01-scripts/wgs-copynumber-workflow/wgs-alignment.nf -with-report report-nextflow-alignment-$(date +"%Y%m%d%H%m").html -resume
