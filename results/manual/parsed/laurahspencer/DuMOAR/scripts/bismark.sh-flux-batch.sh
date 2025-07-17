#!/bin/bash
#FLUX: --job-name=bismark-mbd
#FLUX: -c=20
#FLUX: -t=1814400
#FLUX: --urgency=16

module load bio/bismark/0.24.0
source /home/lspencer/venv/bin/activate
IN="/scratch/lspencer/DuMOAR/concatenated/after-trim/"
OUT="/scratch/lspencer/DuMOAR/aligned/trim-before-concat/"
bismark_genome_preparation \
--verbose \
--parallel 20 \
--bowtie2 \
/home/lspencer/references/dungeness/
cd ${OUT}
find ${IN}*_R1.fastq \
| xargs basename -s _R1.fastq | xargs -I{} bismark \
--bowtie2 \
-genome /home/lspencer/references/dungeness/ \
-p 4 \
-score_min L,0,-0.6 \
--non_directional \
-1 ${IN}{}_R1.fastq \
-2 ${IN}{}_R2.fastq \
--output_dir ${OUT}
find *.bam | \
xargs basename -s .bam | \
xargs -I{} deduplicate_bismark \
--bam \
--paired \
{}.bam
bismark_methylation_extractor \
--bedGraph --counts --scaffolds \
--multicore 20 \
--buffer_size 75% \
*deduplicated.bam
bismark2report
bismark2summary
multiqc . .
