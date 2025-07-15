#!/bin/bash
#FLUX: --job-name=milky-dog-7903
#FLUX: -n=8
#FLUX: --queue=amd
#FLUX: -t=1065600
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
sh /usr/local/modules/profile.modules
source /atavium/home/yang4414/renxx275/anaconda3/etc/profile.d/conda.sh
conda activate python2
for each in `cat fastq.txt`
do
hisat2 -p 8 -x /atavium/home/yang4414/cleanup/reference_genomes/hg38/hisat2/genome -U ${each}.fastq | /usr/bin/samtools view -Sbo ${each}.bam -
/usr/bin/samtools sort ${each}.bam -o ${each}_sorted.bam
/usr/bin/samtools index ${each}_sorted.bam
done
