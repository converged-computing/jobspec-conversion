#!/bin/bash
#FLUX: --job-name=ref_format_ncbi
#FLUX: --priority=16

export PATH='$PATH:~/genmap-build/bin'

module load bioinfo
module load bioawk
module load seqtk
module load samtools
module load BEDTools
module load BBMap
module load r
module load bedops
export PATH=$PATH:~/genmap-build/bin
	module --force purge
	module load biocontainers/default
	module load repeatmasker
	RepeatMasker -pa 64 -a -qq -species Melozone -dir . ref_100kb.fa 
	cat ref_100kb.fa.out  | tail -n +4 | awk '{print $5,$6,$7,$11}' | sed 's/ /\t/g' > repeats.bed 
module --force purge
module load bioinfo
module load bioawk
module load seqtk
module load samtools
module load cmake/3.9.4
module load BEDTools
module load BBMap
module load R
module load bedops
export PATH=$PATH:~/genmap-build/bin
genmap index -F ref_100kb.fa -I index -S 50 # build an index 
mkdir mappability
genmap map -K 100 -E 2 -T 64 -I index -O mappability -t -w -bg                
sortBed -i repeats.bed > repeats_sorted.bed 
awk 'BEGIN {FS="\t"}; {print $1 FS $2}' ref_100kb.fa.fai > ref.genome 
awk '{print $1, $2, $2}' ref.genome > ref2.genome
sed -i 's/ /\t/g' ref2.genome
sortBed -i ref2.genome > ref3.genome
awk '{print $1, $2 }' ref3.genome > ref_sorted.genome
sed -i 's/ /\t/g' ref_sorted.genome
rm ref.genome
rm ref2.genome
rm ref3.genome
bedtools complement -i repeats_sorted.bed -g ref_sorted.genome > nonrepeat.bed
awk '$4 == 1' mappability/ref_100kb.genmap.bedgraph > mappability/map.bed                                           
awk 'BEGIN {FS="\t"}; {print $1 FS $2 FS $3}' mappability/map.bed > mappability/mappability.bed
sortBed -i mappability/mappability.bed > mappability/mappability2.bed
sed -i 's/ /\t/g' mappability/mappability2.bed
bedtools subtract -a mappability/mappability2.bed -b repeats_sorted.bed > mappability/map_nonreapeat.bed
bedtools sort -i mappability/map_nonreapeat.bed > mappability/filter_sorted.bed
bedtools merge -i mappability/filter_sorted.bed > mappability/merged.bed
awk '{ print $1, $2, $2 }' ref_100kb.fa.fai > ref_100kb.info
awk '$2="0"' ref_100kb.info > ref_100kb.bed
sed -i 's/ /\t/g' ref_100kb.bed
bedtools intersect -a ref_100kb.bed -b ./mappability/merged.bed > ok.bed	
cut -f 1 ref_100kb.bed > chrs.txt
