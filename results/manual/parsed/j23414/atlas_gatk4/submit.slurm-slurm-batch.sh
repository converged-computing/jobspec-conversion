#!/bin/bash
#SBATCH --job-name=NX_GATK
#SBATCH --account=isu_gif_vrsc
#SBATCH --output=slurm.%x.%J.out
#SBATCH --error=slurm.%x.%J.err
#SBATCH --mail-user=jenchang@iastate.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=16

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
