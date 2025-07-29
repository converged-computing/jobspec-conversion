#!/bin/bash
#FLUX: --job-name=PostDiscovery_deRep
#FLUX: -c=8
#FLUX: -t=288000
#FLUX: --urgency=16

module purge
module load BLAST+/2.13.0-gompi-2022a 
module list
mkdir -p ../VIR_DB/initial_dereplication
makeblastdb \
    -in ../VIR_DB/virus_contigs/all_extended_pruned_viral_renamed.fasta \
    -dbtype nucl \
    -out ../VIR_DB/initial_dereplication/NEXT_VIR_DB  # later renamed the files from NEXT to AMG to avoid confusion with Chiliadal
blastn \
    -query ../VIR_DB/virus_contigs/all_extended_pruned_viral_renamed.fasta \
    -db ../VIR_DB/initial_dereplication/NEXT_VIR_DB \
    -outfmt '6 std qlen slen' \
    -max_target_seqs 10000 \
    -out ../VIR_DB/initial_dereplication/NEXT_viruses_blast.tsv \
    -num_threads ${SLURM_CPUS_PER_TASK}  # later renamed the files from NEXT to AMG to avoid confusion with Chiliadal
echo "all-vs-all blastn done!"
module purge
module load Python/3.10.8-GCCcore-12.2.0
module load CheckV/1.0.1-foss-2021b-DIAMOND-2.1.8
module list
python anicalc.py \
	-i ../VIR_DB/initial_dereplication/NEXT_viruses_blast.tsv \
	-o ../VIR_DB/initial_dereplication/NEXT_viruses_ani.tsv  # later renamed the files from NEXT to AMG to avoid confusion with Chiliadal
python aniclust.py \
    --fna ../VIR_DB/virus_contigs/all_extended_pruned_viral_renamed.fasta \
    --ani ../VIR_DB/initial_dereplication/NEXT_viruses_ani.tsv \
    --out ../VIR_DB/initial_dereplication/NEXT_viral_clusters.tsv \
    --min_ani 95 \
    --min_tcov 85 \
    --min_qcov 0  # later renamed the files from NEXT to AMG to avoid confusion with Chiliadal
module purge
module load seqtk/1.3-GCC-11.3.0
awk -F '\t' '{print $1}' \
	../VIR_DB/initial_dereplication/NEXT_viral_clusters.tsv \
	> ../VIR_DB/initial_dereplication/NEXT_vOTU_representatives  # later renamed the files from NEXT to AMG to avoid confusion with Chiliadal
seqtk \
        subseq \
        -l60 \
        ../VIR_DB/virus_contigs/all_extended_pruned_viral_renamed.fasta \
        ../VIR_DB/initial_dereplication/NEXT_vOTU_representatives \
        > ../VIR_DB/virus_contigs/NEXT_vOTU_representatives_w_neg_der95.fasta  # later renamed the files from NEXT to AMG to avoid confusion with Chiliadal
module purge
