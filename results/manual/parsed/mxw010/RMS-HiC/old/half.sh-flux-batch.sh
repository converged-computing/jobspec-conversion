#!/bin/bash
#FLUX: --job-name=quirky-general-2719
#FLUX: -c=10
#FLUX: --queue=himem
#FLUX: --priority=16

datadir=$1
outdir=$2
index_dir=$3
indx_prefix=`realpath $index_dir/*.fna`
chrom_sizes=`realpath $index_dir/main_chrom.size`
n_count=`echo $SLURM_ARRAY_TASK_ID`
prefix=`ls ${datadir}/*R1* | xargs -i basename {} | sed 's/.R1.fastq.gz//g' | head -n${n_count} | tail -1`
SORTED_PAIRS_PATH=${outdir}/${prefix}.sorted.pairs.gz
read1=`ls ${datadir}/${prefix}.R1*`
read2=`ls ${datadir}/${prefix}.R2*`
echo "file to align is $read1, $read2"
ml GCC/9.3.0 SAMtools/1.10
ml load Miniconda3/4.9.2
eval "$(conda shell.bash hook)"
conda activate hic
pairtools parse --add-columns mapq --drop-sam --chroms-path ${chrom_sizes}  ${prefix}_temp.bam |
pairtools sort --nproc 4 -o ${SORTED_PAIRS_PATH}
