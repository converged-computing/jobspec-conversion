#!/bin/bash
#FLUX: --job-name=velocyto
#FLUX: --priority=16

conda activate r4.0.3
spack load -r samtools@1.8
samtools --version
echo $SLURM_ARRAY_TASK_ID
PROJECT_NAME="scRNAseq-AIM"
path=/athena/elementolab/scratch/yah2014/Projects/${PROJECT_NAME}/data
file_folder=$(ls ${path}/counts | tail -n +${SLURM_ARRAY_TASK_ID}| head -1) # Uses job array for each sample in the folder
rmsk_gtf=/athena/elementolab/scratch/yah2014/Indexed_genome/hg38_rmsk.gtf
genes_gtf=/athena/elementolab/scratch/yah2014/Indexed_genome/refdata-gex-GRCh38-2020-A/genes/genes.gtf
echo "path="
echo "$path"
echo " "
echo $(ls -l $path/counts/$file_folder/)
echo $(ls -l $rmsk_gtf)
echo $(ls -l $genes_gtf)
echo "total size"
echo $(ls $path/counts/$file_folder)
echo " "
echo $(ls -l $path/counts/$file_folder/outs/possorted_genome_bam.bam)
if test -f "$path/counts/$file_folder/outs/cellsorted_possorted_genome_bam.bam"
then
    echo "sorted bam exists"
    rm $path/counts/$file_folder/outs/cellsorted_possorted_genome_bam.bam*
fi
