#!/bin/bash
#FLUX: --job-name=Daytona_dengue
#FLUX: -c=25
#FLUX: -t=259200
#FLUX: --urgency=16

module load apptainer
bash ./kraken2_viral.sh
nextflow run daytona_dengue.nf -params-file params.yaml
sort ./output/dengue*/*/report.txt | uniq > ./output/sum_report.txt
sed -i '/sampleID\treference/d' ./output/sum_report.txt
sed -i '1i sampleID\treference\tstart\tend\tnum_raw_reads\tnum_clean_reads\tnum_mapped_reads\tpercent_mapped_clean_reads\tcov_bases_mapped\tpercent_genome_cov_map\tmean_depth\tmean_base_qual\tmean_map_qual\tassembly_length\tnumN\tpercent_ref_genome_cov\tVADR_flag\tQC_flag' ./output/sum_report.txt
mv ./Serotypes.txt ./output/
mv ./kraken_out_broad ./output/
python3 ./table.py
mkdir ./output/fastqc ./output/humanscrubber ./output/bbduk ./output/fastqc_clean ./output/multiqc ./output/alignment ./output/variant ./output/assembly ./output/assembly_qc_pass ./output/variant_qc_pass ./output/report
mv ./output/dengue*/*/*original_fastqc* ./output/fastqc
mv ./output/dengue*/*/*humanclean.fastq* ./output/humanscrubber
mv ./output/dengue*/*/*fq.gz ./output/bbduk
mv ./output/dengue*/*/*clean_fastqc* ./output/fastqc_clean
mv ./output/dengue*/*/*multiqc_data ./output/multiqc
mv ./output/dengue*/*/alignment/* ./output/alignment
mv ./output/dengue*/SER*/variants/* ./output/variant
mv ./output/dengue*/SER*/assembly/SER* ./output/assembly
mv ./output/dengue*/assemblies/* ./output/assembly_qc_pass
mv ./output/dengue*/variants/* ./output/variant_qc_pass
mv ./output/final_report.txt ./output/report
mv ./output/Serotypes.txt ./output/report
rm -r ./output/dengue* ./output/sum_report.txt samples.txt ai
for i in ./output/*/SER*
do
   mv "$i" "${i/SER[1-4]_/}"
done
