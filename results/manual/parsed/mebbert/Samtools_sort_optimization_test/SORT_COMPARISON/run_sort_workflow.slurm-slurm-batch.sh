#!/bin/bash
#SBATCH --job-name=NF_Parent_Sort
#SBATCH --account=coa_mteb223_uksr
#SBATCH --output=slurm/slurm-%j.out
#SBATCH --error=slurm/slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=3-00:15:00

export NXF_WORK='/mnt/gpfs3_amd/condo/mteb223/mteb223/Samtools_sort_optimization_test/SORT_COMPARISON/work'

export NXF_WORK=/mnt/gpfs3_amd/condo/mteb223/mteb223/Samtools_sort_optimization_test/SORT_COMPARISON/work
module load ccs/java/jdk1.8.0_202
nextflow run SORT_COMPARISON.nf \
	-with-report all_three-report-queue_size_30.html \
	-with-trace all_three-trace-queue_size_30.txt \
	-with-timeline
