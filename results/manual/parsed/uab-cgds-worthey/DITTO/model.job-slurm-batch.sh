#!/bin/bash
#SBATCH --job-name=DITTO
#SBATCH --output=DITTO_logs.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=06:00:00
#SBATCH --partition=amd-hdr100-res

module reset
module load Java/13.0.2
module load Anaconda3
/data/project/worthey_lab/tools/nextflow/nextflow-22.10.7/nextflow run ../pipeline.nf \
  --outdir /data/results \
  -work-dir .work_dir/ \
  --build hg38 -c cheaha.config -with-report \
  --sample_sheet .test_data/file_list.txt -resume
