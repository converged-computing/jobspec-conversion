#!/bin/bash
#FLUX: --job-name=NX_GATK
#FLUX: -t=86400
#FLUX: --urgency=16

start=`date +%s`
module load singularity
cd ${SLURM_SUBMIT_DIR}
NEXTFLOW=/project/isu_gif_vrsc/bin/nextflow
$NEXTFLOW run 04_GATK.nf \
  --genome "00_Raw-Data/test-data/ref/*.fasta" \
  --reads "00_Raw-Data/test-data/fastq/*_{R1,R2}.fastq.gz" \
  -resume \
  -with-singularity gatk.sif \
  -with-timeline "timeline_report.html"
end=`date +%s`
scontrol show job ${SLURM_JOB_ID}
echo "ran NX.slurm: " `date` "; Execution time: " $((${end}-${start})) " seconds" >> LOGGER.txt
