#!/bin/bash
#SBATCH --output=/fast/users/a1647910/20200310_rRNADepletion/slurm/%x_%j.out
#SBATCH --error=/fast/users/a1647910/20200310_rRNADepletion/slurm/%x_%j.err
#SBATCH --mail-user=baerlachlan@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32GB
#SBATCH --time=10:00:00
#SBATCH --partition=batch

CORES=16
module load FastQC/0.11.7
module load BWA/0.7.15-foss-2017a
module load SAMtools/1.9-foss-2016b
RRNA=/data/biorefs/rRNA/danio_rerio/bwa/danRer11
PROJROOT=/data/biohub/20170327_Psen2S4Ter_RNASeq/data
TRIMDATA=${PROJROOT}/1_trimmedData
ALIGNDATABWA=${PROJROOT}/4_bwa
mkdir -p ${ALIGNDATABWA}/bam
mkdir -p ${ALIGNDATABWA}/fastq
mkdir -p ${ALIGNDATABWA}/log
mkdir -p ${ALIGNDATABWA}/FastQC
gzip ${ALIGNDATABWA}/fastq/*.fastq
