#!/bin/bash
#FLUX: --job-name=SRX17852074
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
nextflow run nf-core/viralrecon -r 2.6.0 \
--input SRX17852074_samplesheet.csv \
--outdir results/SRX17852074_runViralRecon \
--platform illumina \
--protocol amplicon \
--fasta SRX17852074.fasta \
--primer_bed SRX17852074_Artic_4.1.bed \
--gff SRX17852074_GCA_009858895.3_ASM985889v3_genomic.200409.gff \
--variant_caller ivar \
--skip_fastqc \
--skip_kraken2 \
--skip_cutadapt \
--skip_assembly \
--skip_nextclade \
--skip_multiqc \
--skip_consensus \
--skip_asciigenome \
-c custom.config \
-profile gizmo
