#!/bin/bash
#FLUX: --job-name=quirky-platanos-0740
#FLUX: -n=15
#FLUX: --queue=campus-new
#FLUX: -t=3600
#FLUX: --priority=16

load_modules() {
  module purge
  local modules=(Apptainer/1.1.6 Nextflow/23.04.2 Java/17.0.6)
  for module in "${modules[@]}"; do
    module load "$module" || {
      echo "Error: Failed to load module '$module'!"
      exit 1  
    }
  done
}
echo "Job started on $(hostname) at $(date)"
echo "Job ID: $SLURM_JOB_ID"
echo "Using $SLURM_CPUS_ON_NODE cores."
load_modules
nextflow run nf-core/fetchngs \
    -r 1.12.0 \
    -profile apptainer \
    --download_method sratools \
    --nf_core_pipeline viralrecon \
    --input ids.csv \
    --outdir data_fetchNGS/ \
    -resume 
echo "Job finished at $(date)"
