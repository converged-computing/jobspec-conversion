#!/bin/bash
#SBATCH --output=/fast/users/a1647910/20190122_Q96K97_NoStress_RNASeq/slurm/%x_%j.out
#SBATCH --error=/fast/users/a1647910/20190122_Q96K97_NoStress_RNASeq/slurm/%x_%j.err
#SBATCH --mail-user=lachlan.baer@adelaide.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32GB
#SBATCH --time=01:00:00
#SBATCH --partition=batch

CORES=16
module load FastQC/0.11.7
module load STAR/2.5.3a-foss-2016b
module load SAMtools/1.3.1-GCC-5.3.0-binutils-2.25
module load AdapterRemoval/2.2.1-foss-2016b
module load GCC/5.4.0-2.26
module load Subread
REFS=/fast/users/a1647910/20190122_Q96K97_NoStress_RNASeq/gtf_temp/
GTF=${REFS}Danio_rerio.GRCz11.94.chr.gtf
PROJROOT=/fast/users/a1647910/20190122_Q96K97_NoStress_RNASeq
RAWDATA=${PROJROOT}/0_rawData
mkdir -p ${RAWDATA}/FastQC
TRIMDATA=${PROJROOT}/1_trimmedData
mkdir -p ${TRIMDATA}/fastq
mkdir -p ${TRIMDATA}/FastQC
mkdir -p ${TRIMDATA}/log
ALIGNDATA=${PROJROOT}/2_alignedData
mkdir -p ${ALIGNDATA}/log
mkdir -p ${ALIGNDATA}/bam
mkdir -p ${ALIGNDATA}/FastQC
mkdir -p ${ALIGNDATA}/featureCounts
sampleList=`find ${ALIGNDATA}/bam -name "*out.bam" | tr '\n' ' '`
featureCounts -Q 10 \
  -s 2 \
  -T ${CORES} \
  -p \
  -a ${GTF} \
  -o ${ALIGNDATA}/featureCounts/counts.out ${sampleList}
cut -f1,7- ${ALIGNDATA}/featureCounts/counts.out | \
sed 1d > ${ALIGNDATA}/featureCounts/genes.out
