#!/bin/bash
#FLUX: --job-name=Trinity
#FLUX: -n=16
#FLUX: --priority=16

date
module unload perl/5.20.2
module load perl/5.22.0
module load trinity-rnaseq/2.4.0
module load samtools/1.4.1
module load bowtie/1.1.1
module load rsem/1.3.0
module load transdecoder/3.0.0
module load bowtie2/2.2.9
Trinity --seqType fq --single /rhome/jlandis/bigdata/Nicotiana/Seq_reads/de_novo/cleaned_files2/Ntab51789_reads.fastq,/rhome/jlandis/bigdata/Nicotiana/Seq_reads/de_novo/cleaned_files2/Ntab095_55_reads.fastq --max_memory 127G --CPU 8 --min_contig_length 250 --output /rhome/jlandis/bigdata/Nicotiana/de_novo_approach/trinity_Ntab --full_cleanup
/opt/linux/centos/7.x/x86_64/pkgs/trinity-rnaseq/2.4.0/util/align_and_estimate_abundance.pl --transcripts Nicotiana_insilico.Trinity.fasta --est_method RSEM --aln_method bowtie --trinity_mode --prep_reference
/opt/linux/centos/7.x/x86_64/pkgs/trinity-rnaseq/2.4.0/util/align_and_estimate_abundance.pl --transcripts Nicotiana_insilico.Trinity.fasta --seqType fq --single /rhome/jlandis/bigdata/Nicotiana/Seq_reads/de_novo/cleaned_files2/Ntab51789_reads.fastq,/rhome/jlandis/bigdata/Nicotiana/Seq_reads/de_novo/cleaned_files2/Ntab095_55_reads.fastq,/rhome/jlandis/bigdata/Nicotiana/Seq_reads/New_reads/All_QM_reads.fastq,/rhome/jlandis/bigdata/Nicotiana/Seq_reads/New_reads/All_sylv_reads.fastq,/rhome/jlandis/bigdata/Nicotiana/Seq_reads/New_reads/All_tab_reads.fastq,/rhome/jlandis/bigdata/Nicotiana/Seq_reads/New_reads/All_tom_reads.fastq --est_method RSEM --aln_method bowtie --trinity_mode --thread_count 16 --output_prefix Nicotiana --output_dir mapping/
TransDecoder.LongOrfs -t Nicotiana_insilico.Trinity.fasta --gene_trans_map Nicotiana_insilico.Trinity.fasta.gene_trans_map
/opt/linux/centos/7.x/x86_64/pkgs/trinity-rnaseq/2.4.0/util/align_and_estimate_abundance.pl --transcripts /rhome/jlandis/bigdata/Nicotiana/de_novo_approach/In_silico_assembly/Nicotiana_insilico.Trinity.fasta --seqType fq --samples_file Samples.txt --est_method RSEM --aln_method bowtie2 --trinity_mode --thread_count 16
/opt/linux/centos/7.x/x86_64/pkgs/trinity-rnaseq/2.4.0/util/abundance_estimates_to_matrix.pl --est_method RSEM --quant_files target_files.txt --gene_trans_map /rhome/jlandis/bigdata/Nicotiana/de_novo_approach/In_silico_assembly/Nicotiana_insilico.Trinity.fasta.gene_trans_map --name_sample_by_basedir
mkdir DE_voom
/opt/linux/centos/7.x/x86_64/pkgs/trinity-rnaseq/2.4.0/Analysis/DifferentialExpression/run_DE_analysis.pl  --matrix matrix.counts.matrix --method voom --samples_file DE_samples.txt --output DE_voom
