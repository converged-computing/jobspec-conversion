#!/bin/bash
#SBATCH --job-name=blob_array
#SBATCH --output=blob_%A_%a.out
#SBATCH --error=blob_%A_%a.err
#SBATCH --mail-user=yelena.pacheco@usda.gov
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

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
