#!/bin/bash
#FLUX: --job-name=NF_GATK
#FLUX: -t=86400
#FLUX: --priority=16

set -e
set -u
start=`date +%s`
module load nextflow
NEXTFLOW=nextflow
cd ${SLURM_SUBMIT_DIR}
${NEXTFLOW} run main.nf \
   --genome "test-data/ref/b73_chr1_150000001-151000000.fasta" \
   --reads_file read-path.txt \
   --queueSize 50 \
   --account maizegdb \
   --outdir "GATK_Results" \
   -profile maize_ceres,singularity \
   -resume
end=`date +%s`
scontrol show job ${SLURM_JOB_ID}
echo "ran submit_nf.slurm: " `date` "; Execution time: " $((${end}-${start})) " seconds" >> LOGGER.txt
