#!/bin/bash
#FLUX: --job-name=spicy-pot-8891
#FLUX: -c=12
#FLUX: -t=7200
#FLUX: --priority=16

module load bowtie/1.2.3
module load samtools/1.10
[ ! -d "$genome_dir" ] && mkdir -p "$genome_dir"
if [ ! -f "${genome_dir}/${genome}.fa" ]; then
	rsync -avzP rsync://ftp.ensembl.org/ensembl/pub/release-110/fasta/${species_latin}/dna/${species_latin_2}.${genome}.dna.toplevel.fa.gz $genome_dir
	rsync -avzP rsync://ftp.ensembl.org/ensembl/pub/release-110/fasta/${species_latin}/dna_index/${species_latin_2}.${genome}.dna.toplevel.fa.gz.fai $genome_dir
	#rsync -avzP rsync://ftp.ensembl.org/ensembl/pub/current_fasta/${species_latin}/dna/${species_latin_2}.${genome}.dna.toplevel.fa.gz $genome_dir
	#rsync -avzP rsync://ftp.ensembl.org/ensembl/pub/current_fasta/${species_latin}/dna_index/${species_latin_2}.${genome}.dna.toplevel.fa.gz.fai $genome_dir
	mv ${genome_dir}/${species_latin_2}.${genome}.dna.toplevel.fa.gz ${genome_dir}/${genome}.fa.gz
	mv ${genome_dir}/${species_latin_2}.${genome}.dna.toplevel.fa.gz.fai ${genome_dir}/${genome}.fa.fai
	gunzip ${genome_dir}/${genome}.fa.gz
fi
if [ ! -f "${genome_dir}/${genome}.chrom.sizes" ]; then
	awk -F '\t' '{print $1, $2}' ${genome_dir}/${genome}.fa.fai > ${genome_dir}/${genome}.chrom.sizes
fi
if [ ! -f "${genome_dir}/${genome}.gtf" ]; then
	rsync -av rsync://ftp.ensembl.org/ensembl/pub/release-110/gtf/${species_latin}/${species_latin_2}.${genome}.110.gtf.gz $genome_dir
	mv ${genome_dir}/${species_latin_2}.${genome}.110.gtf.gz ${genome_dir}/${genome}.gtf.gz
	gunzip ${genome_dir}/${genome}.gtf.gz
fi
if [ ! -f "${genome_dir}/rmsk.txt" ]; then
	rsync -avzP rsync://hgdownload.soe.ucsc.edu/goldenPath/${genome_ucsc}/database/rmsk.txt.gz $genome_dir
	wait
	gunzip ${genome_dir}/rmsk.txt.gz
fi
wait
if [ ! -f "${genome_dir}/${genome}_subset.chromosomes.txt" ]; then
	head -n $chrom_number ${genome_dir}/${genome}.chrom.sizes > ${genome_dir}/${genome}_subset.chrom.sizes
	awk 'BEGIN { OFS = "\n" }{print $1}' ${genome_dir}/${genome}_subset.chrom.sizes > ${genome_dir}/${genome}_subset.chromosomes.txt
fi
if [ ! -f "${genome_dir}/${genome}_subset.fa" ]; then
	samtools faidx ${genome_dir}/${genome}.fa -r ${genome_dir}/${genome}_subset.chromosomes.txt > ${genome_dir}/${genome}_subset.fa
	samtools faidx ${genome_dir}/${genome}_subset.fa > ${genome_dir}/${genome}_subset.fa.fai
fi
if [ ! -f "${genome_dir}/${genome}_subset.gtf" ]; then
	head -n 5 ${genome_dir}/${genome}.gtf > ${genome_dir}/${genome}_subset.gtf
	for k in $(awk 'BEGIN { OFS = "\n" }{print $1}' ${genome_dir}/${genome}_subset.chromosomes.txt)
	do
		awk -F $'\t' -v k="${k}" '$1==k' ${genome_dir}/${genome}.gtf > ${genome_dir}/${genome}_subset_${k}.gtf
	done
	cat ${genome_dir}/${genome}_subset_*.gtf >> ${genome_dir}/${genome}_subset.gtf
	#wc -l ${genome_dir}/${genome}_subset.gtf
	rm ${genome_dir}/${genome}_subset_*.gtf
fi
cat ${genome_dir}/${genome}_subset.chrom.sizes | awk -F ' ' '$1=(sprintf("chr%s",$1))' > ${genome_dir}/${genome}_subset_ucsc.chrom.sizes
genome_size=$(awk '{SUM+=$2}; END {print SUM}' ${genome_dir}/${genome}_subset.chrom.sizes)
cd $genome_dir
if stat -t *ebwt* >/dev/null 2>&1; then
	echo Found bowtie index
else
	echo Building bowtie genome index
	bowtie-build -f --threads 12 --quiet ${genome_dir}/${genome}_subset.fa $genome
fi
wait
echo All done! 
