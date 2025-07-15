#!/bin/bash
#FLUX: --job-name=creamy-pancake-3569
#FLUX: -c=8
#FLUX: --priority=16

module purge
module load numpy/python2.7/intel/1.14.0
module load bowtie2/2.3.4.3
module load samtools/intel/1.3.1
module load lofreq_star/2.1.3.1
python neat-genreads-master/genReads.py \
-r rDNA_repeat_S288c.fsa \
-R 150 \
-o out_30000_1 \
--bam \
--vcf \
--pe-model fraglen.p \
-e seq_error.p \
--gc-model gcmodel.p \
-p 1 \
-M 0.015 \
-c 150 \
-t rDNA_repeat_S288c_benchmark.bed \
-to 0.4 \
--rng 123
python neat-genreads-master/genReads.py \
-r rDNA_repeat_S288c.fsa \
-R 150 \
-o out_30000_2 \
--bam \
--pe-model fraglen.p \
-e seq_error.p \
--gc-model gcmodel.p \
-p 1 \
-M 0 \
-c 29850 \
-t rDNA_repeat_S288c_benchmark.bed \
-to 0.4 \
--rng 456
neat-genreads-master/mergeJobs.py -i out_30000_1 out_30000_2 -o simulation_30000 -s /path/to/samtools --no-job
bowtie2 -5 1 -N 1 -p 8 -x /path/to/rDNA/prototype/index/prefix -1 simulation_30000_read1.fq -2 simulation_30000_read2.fq -S simulation_30000_pipeline.sam
samtools view -Sbh -F 12 simulation_30000_pipeline.sam > simulation_30000_pipeline.bam
samtools sort -o simulation_30000_pipeline.sort.bam -O 'bam' simulation_30000_pipeline.bam
rm simulation_30000_pipeline.bam
samtools index simulation_30000_pipeline.sort.bam
lofreq indelqual --dindel -f rDNA_repeat_S288c.fsa -o simulation_30000_pipeline.dindel.bam simulation_30000_pipeline.sort.bam
lofreq call --call-indels -f rDNA_repeat_S288c.fsa -o simulation_30000_pipeline.vcf simulation_30000_pipeline.dindel.bam
python neat-genreads-master/utilities/vcf_compare_OLD.py -r rDNA_repeat_S288c.fsa -g simulation_30000_golden.vcf -w simulation_30000_pipeline.vcf -o simulation_30000 -a 0.002 --vcf-out --incl-fail --no-plot
mkdir simulation_30000
mv out_30000_1 simulation_30000
mv out_30000_2 simulation_30000
mv simulation_30000_* simulation_30000
