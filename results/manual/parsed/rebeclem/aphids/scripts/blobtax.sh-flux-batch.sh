#!/bin/bash
#FLUX: --job-name=blob_array
#FLUX: -n=20
#FLUX: --queue=atlas
#FLUX: -t=172800
#FLUX: --urgency=16

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)
t1=$(date +"%s")
echo "Starting $name1"
module load miniconda
source activate discovarenv
blastparams="6 qseqid staxids bitscore std sscinames sskingdoms stitle"
blastn -db /reference/data/NCBI/blast/2023-08-31/nt \
        -task megablast \
        -query ${name1}_primary.genome.scf.fasta \
        -outfmt "6 qseqid staxids bitscore std" \
        -culling_limit 5 \
        -evalue 1e-25 \
        -num_threads 16 \
        -out ${name1}_masurca.megablast_nt
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
