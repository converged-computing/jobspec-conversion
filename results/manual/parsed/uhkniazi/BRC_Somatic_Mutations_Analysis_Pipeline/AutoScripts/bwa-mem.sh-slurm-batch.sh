#!/bin/bash
#SBATCH --job-name=bwa-array
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=6000MB
#SBATCH --time=6-20:05:00
#SBATCH --array=1-8

module load apps/bwa/0.7.17-singularity
number=$SLURM_ARRAY_TASK_ID
paramfile=bwa_param.txt
inr1=`sed -n ${number}p $paramfile | awk '{print $1}'`
inr2=`sed -n ${number}p $paramfile | awk '{print $2}'`
outsam=`sed -n ${number}p $paramfile | awk '{print $3}'`
bwa mem -t 4 /users/k1625253/scratch/old-scratch_rosalind-legacy-import_2020-01-28/Data/MetaData/GenomeIndex/hg38_bwa/hg38.fa $inr1 $inr2 > $outsam
