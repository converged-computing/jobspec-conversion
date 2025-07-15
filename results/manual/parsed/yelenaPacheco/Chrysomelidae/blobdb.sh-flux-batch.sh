#!/bin/bash
#FLUX: --job-name=eccentric-itch-0919
#FLUX: --urgency=16

name1="N_clydesmithi"
t1=$(date +"%s")
echo "Starting $name1"
module load blobtools/4.3.6
blobtools create --fasta N_clydesmithi_hifiasm_contigs.fa $name1
blobtools add --cov minimap.bam $name1
blobtools add --hits N_clydesmithi.megablast_nt --taxrule bestsumorder --taxdump ./taxdump $name1
blobtools view --plot $name1 
blobtools view --plot --view snail  $name1
blobtools view --plot --param catField=bestsumorder_genus $name1 --out $name1 # this outputs the genus level one into the individual folder.
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
