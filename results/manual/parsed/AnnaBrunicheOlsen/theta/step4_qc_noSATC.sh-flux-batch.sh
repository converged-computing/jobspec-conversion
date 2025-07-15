#!/bin/bash
#FLUX: --job-name=S4_genus-species
#FLUX: --priority=16

export PATH='$PATH:~/genmap-build/bin'

module load bioinfo
module load bioawk
module load cmake/3.9.4
module load BEDTools
module load BBMap
module load R
module load bedops
export PATH=$PATH:~/genmap-build/bin
genus_species=
accession=
n=
cd /scratch/bell/dewoody/theta/${genus_species}/
genmap index -F ${accession}_ref/ref_100kb.fa -I index -S 50 # build an index 
mkdir mappability
genmap map -K 100 -E 2 -T $n -I index -O mappability -t -w -bg                
sortBed -i ${accession}_rm/repeats.bed > ${accession}_rm/repeats_sorted.bed 
awk 'BEGIN {FS="\t"}; {print $1 FS $2}' ${accession}_ref/ref_100kb.fa.fai > ${accession}_ref/ref.genome 
awk '{print $1, $2, $2}' ${accession}_ref/ref.genome > ${accession}_ref/ref2.genome
sed -i 's/ /\t/g' ${accession}_ref/ref2.genome
sortBed -i ${accession}_ref/ref2.genome > ${accession}_ref/ref3.genome
awk '{print $1, $2 }' ${accession}_ref/ref3.genome > ${accession}_ref/ref_sorted.genome
sed -i 's/ /\t/g' ${accession}_ref/ref_sorted.genome
rm ${accession}_ref/ref.genome
rm ${accession}_ref/ref2.genome
rm ${accession}_ref/ref3.genome
bedtools complement -i ${accession}_rm/repeats_sorted.bed -g ${accession}_ref/ref_sorted.genome > ${accession}_rm/nonrepeat.bed
awk '$4 == 1' mappability/ref_100kb.genmap.bedgraph > mappability/map.bed                                           
awk 'BEGIN {FS="\t"}; {print $1 FS $2 FS $3}' mappability/map.bed > mappability/mappability.bed
sortBed -i mappability/mappability.bed > mappability/mappability2.bed
sed -i 's/ /\t/g' mappability/mappability2.bed
bedtools subtract -a mappability/mappability2.bed -b ${accession}_rm/repeats_sorted.bed > mappability/map_nonreapeat.bed
bedtools sort -i mappability/map_nonreapeat.bed > mappability/filter_sorted.bed
bedtools merge -i mappability/filter_sorted.bed > mappability/merged.bed
awk '{ print $1, $2, $2 }' ./${accession}_ref/ref_100kb.fa.fai > ./${accession}_ref/ref_100kb.info
awk '$2="0"' ./${accession}_ref/ref_100kb.info > ./${accession}_ref/ref_100kb.bed
sed -i 's/ /\t/g' ./${accession}_ref/ref_100kb.bed
bedtools intersect -a ./${accession}_ref/ref_100kb.bed -b ./mappability/merged.bed > ok.bed	
cut -f 1 ${accession}_ref/ref_100kb.bed > ${accession}_ref/chrs.txt
rm mappability/map.bed
rm mappability/filter_sorted.bed
rm mappability/mappability2.bed
rm ${accession}_ref/ref_sorted.genome
cd /scratch/bell/${USER}/theta/source/
Rscript qc_reference_stats.R --args /scratch/bell/dewoody/theta/${genus_species}/ ${genus_species} ${accession} 
cd /scratch/bell/dewoody/theta/${genus_species}/
map=$(sed -n '1p' okmap.txt)
norepeats=$(sed -n '1p' norepeat.txt)
okbed=$(sed -n '1p' okbed.txt)
echo -e "${genus_species}\t $accession\t $map\t $norepeats\t $okbed" >> map_repeat_summary.txt
mkdir /scratch/bell/dewoody/theta/${genus_species}/theta/
cd /scratch/bell/dewoody/theta/${genus_species}/theta/
ls /scratch/bell/dewoody/theta/${genus_species}/sra/final_bams/*.bam > ./bam.filelist
