#!/bin/bash
#FLUX: --job-name=sanibel
#FLUX: -c=20
#FLUX: -t=172800
#FLUX: --urgency=16

module load nextflow
APPTAINER_CACHEDIR=./
export APPTAINER_CACHEDIR
for f in ./fastqs/*R1*.gz
do
  cp "$f" "$(echo $f | cut -d - -f 1)_1.fastq.gz"
done
for f in ./fastqs/*R2*.gz
do
  cp "$f" "$(echo $f | cut -d - -f 1)_2.fastq.gz"
done
mkdir ./fastqs/original
mv ./fastqs/*_R1_*.gz ./fastqs/original
mv ./fastqs/*_R2_*.gz ./fastqs/original
singularity exec docker://staphb/mlst:2.23.0 cp /mlst-2.23.0/db/pubmlst/neisseria/neisseria.txt ./
singularity exec  docker://staphb/mlst:2.23.0 cp /mlst-2.23.0/db/pubmlst/hinfluenzae/hinfluenzae.txt ./
nextflow run flaq_amr_plus2.nf -params-file params.yaml -c ./configs/docker.config
sort ./output/*/report.txt | uniq > ./output/sum_report.txt
sed -i '/sampleID\tspeciesID/d' ./output/sum_report.txt
sed -i '1i sampleID\tspeciesID_mash\tnearest_neighb_mash\tmash_distance\tspeciesID_kraken\tkraken_percent\tmlst_scheme\tmlst_st\tmlst_cc\tpmga_species\tserotype\tnum_clean_reads\tavg_readlength\tavg_read_qual\test_coverage\tnum_contigs\tlongest_contig\tN50\tL50\ttotal_length\tgc_content\tannotated_cds' ./output/sum_report.txt
rm ./neisseria.txt
rm ./hinfluenzae.txt
rm ./fastqs/*fastq.gz
mv ./fastqs/original/*fastq.gz ./fastqs/
rm -r ./fastqs/original
mv ./*.out ./output
mv ./*err ./output
dt=$(date "+%Y%m%d%H%M%S")
mv ./output ./output-$dt
rm -r ./work
rm -r ./cache
