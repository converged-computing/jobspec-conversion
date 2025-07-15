#!/bin/bash
#FLUX: --job-name=CONCOCT
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

workdir=/path/to/workdir                              # < CHANGE
datasets_array=($(<datasets.txt))
concoct_sif="${workdir}singularity/concoct.sif"
for dataset in "${datasets_array[@]}"; do
outdir="${workdir}results/04-CONCOCT/${dataset}_bins"
contigs="${workdir}data/assemblies/${dataset}.fa.gz"
bamfile="${workdir}results/01-indexing/${dataset}_indices/${dataset}_aligned.sorted.bam"
mkdir -p ${outdir}
cd ${outdir}
singularity exec \
--bind ${outdir} \
--bind ${bamfile} \
--bind ${contigs} \
--bind ${workdir} \
${concoct_sif} cut_up_fasta.py <( zcat ${contigs}) -c 10000 -o 0 --merge_last -b contigs_10k.bed > contigs_10k.fa
singularity exec \
--bind ${outdir} \
--bind ${bamfile} \
--bind ${contigs} \
--bind ${workdir} \
${concoct_sif} concoct_coverage_table.py contigs_10k.bed ${bamfile} > coverage_table.tsv
singularity exec \
--bind ${outdir} \
--bind ${bamfile} \
--bind ${contigs} \
--bind ${workdir} \
${concoct_sif} concoct -t 8 --composition_file contigs_10k.fa --coverage_file coverage_table.tsv -b concoct_output/
singularity exec \
--bind ${outdir} \
--bind ${bamfile} \
--bind ${contigs} \
--bind ${workdir} \
${concoct_sif} merge_cutup_clustering.py concoct_output/clustering_gt1000.csv > concoct_output/clustering_merged.csv
mkdir ${outdir}/concoct_output/fasta_bins
singularity exec \
--bind ${outdir} \
--bind ${bamfile} \
--bind ${contigs} \
--bind ${workdir} \
${concoct_sif} extract_fasta_bins.py <(zcat ${contigs}) concoct_output/clustering_merged.csv --output_path concoct_output/fasta_bins
done
