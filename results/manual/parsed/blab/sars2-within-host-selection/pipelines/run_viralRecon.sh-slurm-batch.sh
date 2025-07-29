#!/bin/bash
#SBATCH --output=logs/nextflow.out
#SBATCH --error=logs/nextflow.err
#SBATCH --nodes=1
#SBATCH --ntasks=36
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=40G
#SBATCH --time=02:00:00
#SBATCH --partition=campus-new

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
nextflow run nf-core/viralrecon -r 2.6.0  \
--input data_fetchNGS/samplesheet/samplesheet.csv \
--outdir results/data_viralrecon \
--platform illumina \
--protocol amplicon \
--consensus_caller ivar \
--genome 'MN908947.3' \
--primer_set artic \
--primer_set_version 3 \
--skip_assembly \
--skip_asciigenome \
-c custom.config \
-profile gizmo
