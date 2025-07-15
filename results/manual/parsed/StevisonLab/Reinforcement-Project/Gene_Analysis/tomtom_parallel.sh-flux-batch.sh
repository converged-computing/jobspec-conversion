#!/bin/bash
#FLUX: --job-name=fuzzy-general-7596
#FLUX: --urgency=16

module load gnu-parallel/20120222
Seqs=(`grep ">" ParaCyno.Unique.Ref.fa | sed 's/>//'`)
for Seq in ${Seqs[@]}
do 
grep -A 1 "${Seq}" ParaCyno.Unique.Ref.fa > tomtom_output/${Seq}.Ref.fa
grep -A 1 "${Seq}" ParaCyno.Unique.Alt.fa > tomtom_output/${Seq}.Alt.fa
done
Files=(`ls tomtom_output/*.fa`)
parallel '
Prefix=`echo {} | sed "s/.fa//"`
~/meme/libexec/meme-5.4.1/rna2meme -dna {} > ${Prefix}.meme
if [[ ${Prefix} == *"Ref" ]]
then
~/meme/bin/tomtom -verbosity 4 ${Prefix}.meme ~/meme/motif_databases/CIS-BP_2.00/Macaca_mulatta.meme -o ${Prefix}_out
else
~/meme/bin/tomtom -verbosity 4 ${Prefix}.meme ~/meme/motif_databases/CIS-BP_2.00/Macaca_fascicularis.meme -o ${Prefix}_out
fi' ::: ${Files[@]}
