#!/bin/bash
#SBATCH --job-name=NF_GATK
#SBATCH --output=R-%x.%J.out
#SBATCH --error=R-%x.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=4

set -e
set -u
start=`date +%s`
module load gcc/7.3.0-xegsmw4 nextflow
module load singularity
NEXTFLOW=nextflow
cd ${SLURM_SUBMIT_DIR}
${NEXTFLOW} run main.nf \
  --genome "test-data/ref/b73_chr1_150000001-151000000.fasta" \
  --reads "test-data/fastq/*_{R1,R2}.fastq.gz" \
  --queueSize 25 \
  -profile slurm,singularity \
  -resume
  #--account isu_gif_vrsc       #<= add this to Atlas
end=`date +%s`
scontrol show job ${SLURM_JOB_ID}
echo "ran submit_nf.slurm: " `date` "; Execution time: " $((${end}-${start})) " seconds" >> LOGGER.txt
