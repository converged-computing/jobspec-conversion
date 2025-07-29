#!/bin/bash
#SBATCH --job-name=Nextflow
#SBATCH --output=R_%x.%J.out
#SBATCH --error=R_%x.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=16

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
