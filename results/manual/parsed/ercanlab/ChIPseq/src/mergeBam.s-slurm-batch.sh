#!/bin/bash
#SBATCH --job-name=mergeBam
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30GB
#SBATCH --time=00:30:00

module purge
module load samtools/intel/1.6
module load bedtools/intel/2.27.1
val=$SLURM_ARRAY_TASK_ID
params=$(sed -n ${val}p forMerge.txt)
bamfiles=($params)
mergedBam=${bamfiles[0]}
printf "Merging ${bamfiles[*]:1} into $mergedBam\n"
samtools merge $mergedBam ${bamfiles[*]:1}
printf "Converting $mergedBam from BAM to BED\n"
bedtools bamtobed -i $mergedBam > ${mergedBam}.bed
exit 0;
