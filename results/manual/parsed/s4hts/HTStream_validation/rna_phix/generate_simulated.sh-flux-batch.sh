#!/bin/bash
#FLUX: --job-name=simulate_data # Job name
#FLUX: -n=9
#FLUX: -t=54000
#FLUX: --priority=16

start=`date +%s`
echo $HOSTNAME
length=250
bbmap_dir='/share/biocore/keith/benchmarking/tools/bbmap'
reference='References/GRCh38.primary_assembly.genome.fa'
outdir='01-GoldStandard/human_genome/'
${bbmap_dir}/./randomreads.sh ref=${reference} out1='${outdir}/human_genome1.fastq.gz' out2='${outdir}/human_genome2.fastq.gz' length=$length reads=500000 paired=t
end=`date +%s`
runtime=$((end-start))
echo $runtime
