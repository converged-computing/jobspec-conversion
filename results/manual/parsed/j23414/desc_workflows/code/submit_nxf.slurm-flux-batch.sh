#!/bin/bash
#FLUX: --job-name=Nextflow
#FLUX: -t=86400
#FLUX: --urgency=16

set -e
set -u
start=`date +%s`
cd ${SLURM_SUBMIT_DIR}
NEXTFLOW='/work/GIF/software/bin/nextflow'
module load jdk
${NEXTFLOW} run script06.nf --outdir test_run
end=`date +%s`
scontrol show job ${SLURM_JOB_ID}
echo "ran submit_nxf.slurm: " `date` "; Execution time: " $((${end}-${start})) " seconds" >> LOGGER.txt
