#!/bin/bash
#FLUX: --job-name=ref_format
#FLUX: --urgency=16

module load biocontainers
module load bioawk
module load samtools
module load bedtools
module load bbmap
module load r
module load bedops
module load bwa
module load picard
module load biocontainers
module load bbmap
module load bioawk
reformat.sh in=ct_ref.asm.bp.hap1.purged.fa out=new.fa trd=t -Xmx20g overwrite=T
sortbyname.sh in=new.fa out=ref.fa -Xmx20g length descending overwrite=T
bioawk -c fastx '{ if(length($seq) > 100000) { print ">"$name; print $seq }}' ref.fa > ref_100kb.fa
rm new.fa
module load biocontainers
module load bwa
module load samtools
module load picard 
bwa index ref_100kb.fa
samtools faidx ref_100kb.fa
PicardCommandLine CreateSequenceDictionary reference=ref_100kb.fa output=ref_100kb.fa.dict
bwa index ref.fa
samtools faidx ref.fa
PicardCommandLine CreateSequenceDictionary reference=ref.fa output=ref.fa.dict
	module --force purge
	module load biocontainers/default
	module load repeatmasker
	RepeatMasker -pa 64 -a -qq -species vertebrates -dir . ref_100kb.fa 
	cat ref_100kb.fa.out  | tail -n +4 | awk '{print $5,$6,$7,$11}' | sed 's/ /\t/g' > repeats.bed 
module --force purge
module load biocontainers/default
module load genmap
genmap index -F ref_100kb.fa -I index -S 50 # build an index 
mkdir mappability
genmap map -K 100 -E 2 -T 64 -I index -O mappability -t -w -bg                
module --force purge
module load biocontainers
module load bioawk
module load samtools
module load cmake
module load bedtools
module load bbmap
module load r
module load bedops
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
module --force purge
module load biocontainers/default
module load genmap
awk '$4 == 1' mappability/ref_100kb.genmap.bedgraph > mappability/map.bed                                           
awk 'BEGIN {FS="\t"}; {print $1 FS $2 FS $3}' mappability/map.bed > mappability/mappability.bed
module --force purge
module load biocontainers
module load bioawk
module load samtools
module load cmake
module load bedtools
module load bbmap
module load r
module load bedops
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
rm mappability/map.bed
rm mappability/filter_sorted.bed
rm mappability/mappability2.bed
rm ref_sorted.genome
