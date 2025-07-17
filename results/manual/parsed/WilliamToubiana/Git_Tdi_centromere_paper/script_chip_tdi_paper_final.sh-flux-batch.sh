#!/bin/bash
#FLUX: --job-name=reclusive-parsnip-1701
#FLUX: --queue=cpu
#FLUX: -t=3600
#FLUX: --urgency=16

echo "Starting job $SLURM_JOB_NAME with ID $SLURM_JOB_ID".
module load gcc
module load bwa
module load perl
module load bedtools2
module load samtools
module load python
  ## Genic features
  ## Transposable Elements (TEs)
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip/
cat *cenh3*R1*.gz > Tdi_testes_cenh3_1_R1.fq.gz
cat *cenh3*R3*.gz > Tdi_testes_cenh3_1_R3.fq.gz
cat *input*R1*.gz > Tdi_testes_input_1_R1.fq.gz
cat *input*R3*.gz > Tdi_testes_input_1_R3.fq.gz
module load trimmomatic
for i in *_R1.fq.gz ; do
        foo1=`echo $i`
                basename=`echo $foo1 | sed 's/_R1.fq.gz*//' | sed 's/.*\///'`
        infileR1=`echo $foo1`
        infileR2=`echo $foo1 | sed 's/_R1.fq.gz/_R3.fq.gz/'`
        outfileR1=`echo "./"$basename"_R1_qtrimmed.fq"`
        outfileR2=`echo "./"$basename"_R3_qtrimmed.fq"`
        outfileR1_UP=`echo "./"$basename"_R1_qtrimmed_UNPAIRED.fq"`
        outfileR2_UP=`echo "./"$basename"_R3_qtrimmed_UNPAIRED.fq"`
        trimmomatic PE -threads 16 $infileR1 $infileR2 $outfileR1 $outfileR1_UP $outfileR2 $outfileR2_UP ILLUMINACLIP:AllIllumina-PEadapters.fa:3:25:6 LEADING:9 TRAILING:9 SLIDINGWINDOW:4:15 MINLEN:90
done
module load bedtools2
module load samtools
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip/genomes
samtools faidx Tdi_LRv5a_mtDNAv350.fasta
cut -f1,2 Tdi_LRv5a_mtDNAv350.fasta.fai > Tdi_chm_size_mtDNAv350.txt
bedtools makewindows -g Tdi_chm_size_mtDNAv350.txt -w 10000  > Tdi_chm_size_mtDNAv350_w10000.bed
	## bwa index
module load bwa
module load samtools
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip
bwa index genomes/Tdi_LRv5a_mtDNAv350.fasta
	## bwa map
mkdir bwa
bwa mem -t 16 -c 1000000000 -T 30 genomes/Tdi_LRv5a_mtDNAv350.fasta Tdi_testes_cenh3_1_R1_qtrimmed.fq Tdi_testes_cenh3_1_R3_qtrimmed.fq > bwa/chip_cenh3_tdi_testes_1_bwa.sam
bwa mem -t 16 -c 1000000000 -T 30 genomes/Tdi_LRv5a_mtDNAv350.fasta chip/Tdi_testes_input_1_R1_qtrimmed.fq chip/Tdi_testes_input_1_R3_qtrimmed.fq > bwa/chip_input_tdi_testes_1_bwa.sam
	## flagstat
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip/bwa
samtools flagstat chip_cenh3_tdi_testes_1_bwa.sam > chip_cenh3_tdi_testes_1_bwa_flagstat.txt
samtools flagstat chip_input_tdi_testes_1_bwa.sam > chip_input_tdi_testes_1_bwa_flagstat.txt
	## sort bam
samtools view -u chip_cenh3_tdi_testes_1_bwa.sam | samtools sort -o chip_cenh3_tdi_testes_1_bwa.bam
samtools view -u chip_input_tdi_testes_1_bwa.sam | samtools sort -o chip_input_tdi_testes_1_bwa.bam
	## remove supp (chimeric) alignements
samtools view chip_cenh3_tdi_testes_1_bwa.bam | fgrep SA:Z: | cut -f 1 > chip_cenh3_tdi_testes_1_bwa_badnames.txt
samtools view -h chip_cenh3_tdi_testes_1_bwa.bam | fgrep -vf chip_cenh3_tdi_testes_1_bwa_badnames.txt | samtools view -b > chip_cenh3_tdi_testes_1_bwa_final.bam
samtools flagstat chip_cenh3_tdi_testes_1_bwa_final.bam > chip_cenh3_tdi_testes_1_bwa_final_flagstat.txt
samtools view chip_input_tdi_testes_1_bwa.bam | fgrep SA:Z: | cut -f 1 > chip_input_tdi_testes_1_bwa_badnames.txt
samtools view -h chip_input_tdi_testes_1_bwa.bam | fgrep -vf chip_input_tdi_testes_1_bwa_badnames.txt | samtools view -b > chip_input_tdi_testes_1_bwa_final.bam
samtools flagstat chip_input_tdi_testes_1_bwa_final.bam > chip_input_tdi_testes_1_bwa_final_flagstat.txt
	##remove PCR duplicates
module load picard
module load samtools
for i in  *tdi_testes_1*.bam; do
    outbam=`echo $i | sed 's/_bwa_final.bam/_bwa_final_DR.bam/'`
       flagstat_out_bam=`echo $outbam | sed 's/.bam/_flagstat_out.txt/'`
       metric_file=`echo $outbam | sed 's/.bam/_metric.txt/'`
       picard MarkDuplicates REMOVE_DUPLICATES=true \
       INPUT=$i \
    OUTPUT=$outbam \
    METRICS_FILE=$metric_file
       samtools flagstat $outbam > $flagstat_out_bam
       mv $flagstat_out_bam /scratch/wtoubian/bwa_timema_genomes/mapping_genomes/BWA_out/flagstat_out_paired
done
module load bedtools2
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip
mkdir coverage
bedtools coverage -a genomes/Tdi_chm_size_mtDNAv350_w10000.bed -b bwa/chip_cenh3_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/Tdi_cenh3_testes_1_GW_coverage_DR.txt
bedtools coverage -a genomes/Tdi_chm_size_mtDNAv350_w10000.bed -b bwa/chip_input_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/Tdi_input_testes_1_GW_coverage_DR.txt
module load bedtools2
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip
	## Tandem Repeats
sortBed -faidx genomes/Tdi_chm_size_mtDNAv350.txt -i TR_annotation_timema/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse.bed > TR_annotation_timema/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_sorted.bed
awk '{print $1 "\t" $2 "\t" $3;}' TR_annotation_timema/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_sorted.bed > TR_annotation_timema/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_sorted_noSeq.bed
	## Genic features
perl agat_sp_add_introns.pl --gff gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1.gff --out gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns.gff #agat_sp_add_introns.pl can be find here: https://github.com/NBISweden/AGAT/blob/master/bin/agat_sp_add_introns.pl
awk '{print $1 "\t" $4 "\t" $5 "\t" $3;}' gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns.gff > gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns.bed
sortBed -faidx genomes/Tdi_chm_size_mtDNAv350.txt -i gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns.bed > gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns_sorted.bed
grep -w "exon" gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_exons.bed
grep -w "5'-UTR" gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_5UTRs.bed
grep -w "3'-UTR" gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_3UTRs.bed
grep -w "intron" gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_introns.bed
grep -w "ncRNA" gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_ncRNA.bed
grep -w "rRNA" gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_rRNA.bed
grep -w "tRNA" gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_add_introns_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > gene_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_tRNA.bed
	## TEs
sortBed -faidx genomes/Tdi_chm_size_mtDNAv350.txt -i TE_annotation_timema/Tdi_AllRepeats.classi.bed > TE_annotation_timema/Tdi_AllRepeats.classi_sorted.bed
grep -w "LINE" TE_annotation_timema/Tdi_AllRepeats.classi_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > TE_annotation_timema/Tdi_LINEs.bed
grep -w "SINE" TE_annotation_timema/Tdi_AllRepeats.classi_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > TE_annotation_timema/Tdi_SINEs.bed
grep -w "DNA" TE_annotation_timema/Tdi_AllRepeats.classi_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > TE_annotation_timema/Tdi_DNAs.bed
grep -w "LTR" TE_annotation_timema/Tdi_AllRepeats.classi_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > TE_annotation_timema/Tdi_LTRs.bed
grep -w "RC" TE_annotation_timema/Tdi_AllRepeats.classi_sorted.bed | awk '{print $1 "\t" $2 "\t" $3;}' > TE_annotation_timema/Tdi_RCs.bed
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip
mkdir coverage/GW
bedtools coverage -a TR_annotation_timema/Tdi_LRv5a/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_sorted_noSeq.bed -b bwa/chip_input_tdi_testes_1_bwa_final_DR.bam  -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_TR_coverage_GW.txt
bedtools coverage -a TR_annotation_timema/Tdi_LRv5a/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_sorted_noSeq.bed -b bwa/chip_cenh3_tdi_testes_1_bwa_final_DR.bam  -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_TR_coverage_GW.txt
bedtools coverage -a TE_annotation_timema/Tdi_LINEs.bed -b bwa/chip_input_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_TE_LINE_coverage_GW.txt
bedtools coverage -a TE_annotation_timema/Tdi_LINEs.bed -b bwa/chip_cenh3_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_TE_LINE_coverage_GW.txt
bedtools coverage -a TE_annotation_timema/Tdi_SINEs.bed -b bwa/chip_input_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_TE_SINE_coverage_GW.txt
bedtools coverage -a TE_annotation_timema/Tdi_SINEs.bed -b bwa/chip_cenh3_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_TE_SINE_coverage_GW.txt
bedtools coverage -a TE_annotation_timema/Tdi_LTRs.bed -b bwa/chip_input_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_TE_LTR_coverage_GW.txt
bedtools coverage -a TE_annotation_timema/Tdi_LTRs.bed -b bwa/chip_cenh3_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_TE_LTR_coverage_GW.txt
bedtools coverage -a TE_annotation_timema/Tdi_RCs.bed -b bwa/chip_input_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_TE_RC_coverage_GW.txt
bedtools coverage -a TE_annotation_timema/Tdi_RCs.bed -b bwa/chip_cenh3_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_TE_RC_coverage_GW.txt
bedtools coverage -a TE_annotation_timema/Tdi_DNAs.bed -b bwa/chip_input_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_TE_DNA_coverage_GW.txt
bedtools coverage -a TE_annotation_timema/Tdi_DNAs.bed -b bwa/chip_cenh3_tdi_testes_1_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_TE_DNA_coverage_GW.txt
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_exons.bed -b bwa/chip_input_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_exon_coverage_GW.txt
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_exons.bed -b bwa/chip_cenh3_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_exon_coverage_GW.txt
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_introns.bed -b bwa/chip_input_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_intron_coverage_GW.txt
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_introns.bed -b bwa/chip_cenh3_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_intron_coverage_GW.txt
        ## 5-UTR coverage
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_5UTRs.bed -b bwa/chip_input_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_5-UTR_coverage_GW.txt
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_5UTRs.bed -b bwa/chip_cenh3_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_5-UTR_coverage_GW.txt
        ## 3-UTR coverage
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_3UTRs.bed -b bwa/chip_input_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_3-UTR_coverage_GW.txt
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_3UTRs.bed -b bwa/chip_cenh3_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_3-UTR_coverage_GW.txt
        ## ncRNA coverage
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_ncRNA.bed -b bwa/chip_input_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_ncRNA_coverage_GW.txt
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_ncRNA.bed -b bwa/chip_cenh3_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_ncRNA_coverage_GW.txt
        ## rRNA coverage
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_rRNA.bed -b bwa/chip_input_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_rRNA_coverage_GW.txt
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_rRNA.bed -b bwa/chip_cenh3_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_rRNA_coverage_GW.txt
        ## tRNA coverage
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_tRNA.bed -b bwa/chip_input_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_input_testes_1_tRNA_coverage_GW.txt
bedtools coverage -a genome_annotation_timema_v2/Tdi_LRv5a_mtDNAv350_v2.1_tRNA.bed -b bwa/chip_cenh3_tdi_testes_bwa_final_DR.bam -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/GW/Tdi_cenh3_testes_1_tRNA_coverage_GW.txt
module load r
./Proportion_categories.R
module load r
mkdir enriched_10kb_regions
./Enriched_windows.R
mkdir enriched_10kb_regions/categories
	#TRs
bedtools intersect -a enriched_10kb_regions/tdi_cenh3_testes_GW_coverage_DR_w10000_logRatio2.bed -b TR_annotation_timema/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_sorted_noSeq.bed > enriched_10kb_regions/categories/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_sorted_10kb.bed
sortBed -faidx genomes/Tdi_chm_size_mtDNAv350.txt -i enriched_10kb_regions/categories/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_sorted_10kb.bed > enriched_10kb_regions/categories/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_sorted_10kb_sorted.bed
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip
mkdir coverage/enriched_windows
        ## TR coverage
bedtools coverage -a enriched_10kb_regions/categories/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_sorted_10kb_sorted.bed -b bwa/chip_input_tdi_testes_1_bwa_final_DR.bam  -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/enriched_windows/Tdi_input_testes_1_TR_10kb_coverage.txt
bedtools coverage -a enriched_10kb_regions/categories/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_sorted_10kb_sorted.bed -b bwa/chip_cenh3_tdi_testes_1_bwa_final_DR.bam  -sorted -g genomes/Tdi_LRv5a_mtDNAv350.fasta.fai -mean > coverage/enriched_windows/Tdi_cenh3_testes_1_TR_10kb_coverage.txt
perl script_minimal_rotation_parse.pl TR_annotation_timema/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse.txt > TR_annotation_timema/Tdi_LRv5a/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_minimal_rotation.txt
awk '{print $1 "\t" $2 "\t" $3 "\t" $7;}' TR_annotation_timema/Tdi_LRv5a/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_minimal_rotation.txt | awk 'NR>1' > TR_annotation_timema/Tdi_LRv5a/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_minimal_rotation.bed
source ~/.bashrc
conda activate /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/softwares/bedtools_env
bedtools intersect -a TR_annotation_timema/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_minimal_rotation.bed -b enriched_10kb_regions/tdi_cenh3_testes_GW_coverage_DR_w10000_logRatio2.bed > enriched_10kb_regions/Tdi_LRv5a_mtDNAv350.fasta.2.7.7.80.10.50.2000_parse_minimal_rotation_enriched_10kb_regions.txt
mkdir enriched_motifs
mkdir enriched_motifs/levenstein
mkdir enriched_motifs/blast
./Enriched_minimal_rotation_TR_motifs.R
module load python
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip/enriched_motifs/levenstein
python script_levenshtein_rotations_F-F_inputFiles.py #computes pair-wise levenstein distances between duplicated motif sequences. Outputs levenstein_distances_FF.txt file
python script_levenshtein_rotations_F-R_inputFiles.py #computes pair-wise levenstein distances between duplicated motif sequences and reverse complements. Outputs levenstein_distances_FR.txt file
module load r
./Levenstein_network.R
module load r
./Heatmap_TRF-based.R
module load blast-plus
bedtools getfasta -fi genomes/Tdi_LRv5a_mtDNAv350.fasta -bed enriched_10kb_regions/tdi_cenh3_testes_GW_coverage_DR_w10000_logRatio2.bed > enriched_motifs/blast/tdi_cenh3_testes_GW_bwa_coverage_RS_logRatio2.fasta
makeblastdb -in enriched_motifs/blast/tdi_cenh3_testes_GW_bwa_coverage_RS_logRatio2.fasta -dbtype nucl -parse_seqids -max_file_sz '3.9GB' -input_type fasta
blastn -task blastn-short -query enriched_motifs/blast/Enriched_motifs_enriched_10kb_regions.fasta -db enriched_motifs/blast/tdi_cenh3_testes_GW_bwa_coverage_RS_logRatio2.fasta -outfmt "6 qseqid sseqid pident length mismatch gapopen qlen qstart qend sstart send evalue bitscore" -num_threads 16 -out enriched_motifs/blast/Enriched_motifs_enriched_10kb_regions_blastn.txt
module load r
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip/enriched_motifs/blast
./Heatmap_blast-based.R
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip/
mkdir kmer_centromere
source ~/.bashrc
conda activate /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip/kmer_centromere/kmc_env/
snakemake -s kmer_centromere/snakefile_v9_genomev10PRE_SE.py --configfile kmer_centromere/config_xla_merge_final_SE_v9_yf_genome10.2.yaml -pr --cores 8
module load gcc spades
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip/
mkdir kmer_centromere/spades_assembly
spades.py --careful --only-assembler -s kmer_centromere/result_tdi_cenh3_testes_GW_kmer25_CIVAL100/yf_seqdat/xla_genome_chunks_v10.2/xla_merge_final/25/100/madx25/CAoINPUT_extract.fa -o kmer_centromere/spades_assembly/
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip/kmer_centromere/spades_assembly
mkdir levenstein
./kmer_minimal_rotation_TR_motifs.R
module load python
cd /work/FAC/FBM/DEE/tschwand/asex_sinergia/wtoubian/chip/kmer_centromere/spades_assembly/levenstein
python script_levenshtein_rotations_F-F_inputFiles.py #computes pair-wise levenstein distances between duplicated motif sequences. Outputs levenstein_distances_FF_contigs.txt file
python script_levenshtein_rotations_F-R_inputFiles.py #computes pair-wise levenstein distances between duplicated motif sequences and reverse complements. Outputs levenstein_distances_FR_contigs.txt file
module load r
./Levenstein_network_contigs.R
