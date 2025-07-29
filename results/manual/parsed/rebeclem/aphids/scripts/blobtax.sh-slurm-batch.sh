#!/bin/bash
#SBATCH --job-name=blob_array
#SBATCH --account=aphid_phylogenomics
#SBATCH --output=blob_%A_%a.out
#SBATCH --error=blob_%A_%a.err
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=atlas
#SBATCH --array=1-36

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
