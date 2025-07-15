#!/bin/bash
#FLUX: --job-name=creamy-parrot-8730
#FLUX: --urgency=16

module load htslib/1.11
for x in {1..20} X
do 
~/conda/bin/pixy --n_cores 15 --stats dxy fst --vcf Reinforcement.chr${x}.filtered.allsites.vcf.gz --populations Reinforcement_Populations.txt --bed_file Reinforcement.chr${x}.MAF.SplineWindows.bed --output_prefix Reinforcement.SplineDefined.chr${x}
done
for x in {1..100}
do
sort -R Sample_List.txt > Randomized_List.txt
paste Randomized_List.txt Reinforcement_Populations.txt | awk '{OFS="\t" ; print $1,$3}' > Randomized_Populations_${x}.txt
for y in {1..20} X
do
~/conda/bin/pixy --n_cores 15 --stats dxy fst --vcf Reinforcement.chr${y}.filtered.allsites.vcf.gz --populations Randomized_Populations_${x}.txt --bed_file Reinforcement.chr${y}.MAF.SplineWindows.bed --output_prefix Randomized.SplineDefined.chr${y}.${x}
done
done
