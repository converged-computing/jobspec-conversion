#!/bin/bash
#FLUX: --job-name=summarise_MethylDackel
#FLUX: --queue=general
#FLUX: --priority=16

set -xeuo pipefail
echo ------------------------------------------------------
echo SBATCH: working directory is $SLURM_SUBMIT_DIR
echo SBATCH: job identifier is $SLURM_JOBID
echo SBATCH: array_ID is ${SLURM_ARRAY_TASK_ID}
echo ------------------------------------------------------
echo working dir is $PWD
echo changing to SLURM_SUBMIT_DIR
cd "$SLURM_SUBMIT_DIR"
echo working dir is now $PWD
conda activate $conda_enviro
module load bedtools/2.30.0-gcc-10.3.0
module load samtools/1.13-gcc-10.3.0
ID="$(/bin/sed -n ${SLURM_ARRAY_TASK_ID}p ${LIST})"
echo sample being mapped is $ID
cd analysis
mkdir -p MethylDackel
mkdir -p MethylDackel_bigwigs
mkdir -p ConversionRate_bwa-meth
mkdir -p MethylDackel_mbias
mkdir -p bwa-meth-filtered_bigWigs_deeptools
mkdir -p MethylDackel_C_summaries
bamCoverage \
--bam bwa-meth-filtered/${ID}_sorted_MarkDup_pairs_clipOverlap.bam \
-o bwa-meth-filtered_bigWigs_deeptools/${ID}.bw \
--binSize 10 \
--normalizeUsing CPM \
--minMappingQuality 10 \
-p $cores
bamCoverage \
--bam bwa-meth-filtered/${ID}_sorted_MarkDup_pairs_clipOverlap.bam \
-o bwa-meth-filtered_bigWigs_deeptools/${ID}_MAPQ10.bw \
--binSize 10 \
--normalizeUsing CPM \
-p $cores
MethylDackel extract \
--CHG \
--CHH \
-@ $cores \
--minOppositeDepth=3 \
--maxVariantFrac=0.1 \
--nOT 0,0,0,0 \
--nOB 0,0,0,0 \
-o MethylDackel/${ID}_methratio_head \
${genome_reference} \
bwa-meth-filtered/${ID}_sorted_MarkDup_pairs_clipOverlap.bam
MethylDackel mbias \
${genome_reference} \
bwa-meth-filtered/${ID}_sorted_MarkDup_pairs_clipOverlap.bam \
MethylDackel_mbias/${ID}_methratio_mbias
awk -F$"\\t" \
'BEGIN {OFS = FS} (NR>1){print $1, $2, $3, $4, $5, $6}' \
MethylDackel/${ID}_methratio_head_CpG.bedGraph | LC_COLLATE=C sort -k1,1 -k2,2n - > MethylDackel/${ID}_methratio_CG.bedGraph
awk -F$"\\t" \
'BEGIN {OFS = FS} (NR>1){print $1, $2, $3, $4, $5, $6}' \
MethylDackel/${ID}_methratio_head_CHG.bedGraph | LC_COLLATE=C sort -k1,1 -k2,2n - > MethylDackel/${ID}_methratio_CHG.bedGraph
awk -F$"\\t" \
'BEGIN {OFS = FS} (NR>1){print $1, $2, $3, $4, $5, $6}' \
MethylDackel/${ID}_methratio_head_CHH.bedGraph | LC_COLLATE=C sort -k1,1 -k2,2n - > MethylDackel/${ID}_methratio_CHH.bedGraph
mkdir -p tmp_bedgraphs
awk -F$"\\t" \
'BEGIN {OFS = FS} (NR>1){print $1, $2, $3, $4}' \
MethylDackel/${ID}_methratio_head_CpG.bedGraph | LC_COLLATE=C sort -k1,1 -k2,2n - > tmp_bedgraphs/${ID}_methratio_CG.bedGraph
awk -F$"\\t" \
'BEGIN {OFS = FS} (NR>1){print $1, $2, $3, $4}' \
MethylDackel/${ID}_methratio_head_CHG.bedGraph | LC_COLLATE=C sort -k1,1 -k2,2n - > tmp_bedgraphs/${ID}_methratio_CHG.bedGraph
awk -F$"\\t" \
'BEGIN {OFS = FS} (NR>1){print $1, $2, $3, $4}' \
MethylDackel/${ID}_methratio_head_CHH.bedGraph | LC_COLLATE=C sort -k1,1 -k2,2n - > tmp_bedgraphs/${ID}_methratio_CHH.bedGraph
bedGraphToBigWig "tmp_bedgraphs/${ID}_methratio_CG.bedGraph" ${chrom_sizes_file} \
"MethylDackel_bigwigs/${ID}_MethylDackel_CG.bigWig"
bedGraphToBigWig "tmp_bedgraphs/${ID}_methratio_CHG.bedGraph" ${chrom_sizes_file} \
"MethylDackel_bigwigs/${ID}_MethylDackel_CHG.bigWig"
bedGraphToBigWig "tmp_bedgraphs/${ID}_methratio_CHH.bedGraph" ${chrom_sizes_file} \
"MethylDackel_bigwigs/${ID}_MethylDackel_CHH.bigWig"
if [ "$chr_or_genome" == "chromosome" ]
then
awk -F$"\\t" -v ID=$ID \
'BEGIN {OFS = FS} (NR>1){print $1, $2, $3, $4, $5, $6 > "MethylDackel/"ID"_"$1"_methratio_CG.bedGraph"}' \
MethylDackel/${ID}_methratio_head_CpG.bedGraph
awk -F$"\\t" -v ID=$ID \
'BEGIN {OFS = FS} (NR>1){print $1, $2, $3, $4, $5, $6 > "MethylDackel/"ID"_"$1"_methratio_CHG.bedGraph"}' \
MethylDackel/${ID}_methratio_head_CHG.bedGraph
awk -F$"\\t" -v ID=$ID \
'BEGIN {OFS = FS} (NR>1){print $1, $2, $3, $4, $5, $6 > "MethylDackel/"ID"_"$1"_methratio_CHH.bedGraph"}' \
MethylDackel/${ID}_methratio_head_CHH.bedGraph
fi
rm -rv MethylDackel/${ID}_methratio_head*
rm -rv tmp_bedgraphs/${ID}_methratio_*
if [ "$chr_or_genome" == "chromosome" ]
then
awk -F$"\\t" \
'BEGIN {OFS = FS} {sum1 += $6; sum2 +=$5} END {print sum1, sum2 , 100-((sum2/sum1)*100)}' \
MethylDackel/${ID}_${ChrC_name}_methratio_CHH.bedGraph > ConversionRate_bwa-meth/${ID}_conversion_rate.txt
elif [ "$chr_or_genome" == "genome" ]
then
awk -F$"\\t" -v ChrC_name=$ChrC_name \
'BEGIN {OFS = FS} {if($1==ChrC_name) print}' \
MethylDackel/${ID}_methratio_CHH.bedGraph | \
awk -F$"\\t" 'BEGIN {OFS = FS} {sum1 += $6; sum2 +=$5} END {print sum1+sum2, sum2 , 100-((sum2/(sum1+sum2))*100)}' \
- > ConversionRate_bwa-meth/${ID}_conversion_rate.txt
fi
awk -F$"\\t" -v ID=$ID 'BEGIN {OFS = FS} {Cs ++; sum1 += $6; sum2 +=$5} END {print ID, Cs, sum1+sum2, sum2 , (sum2/(sum1+sum2)*100), (sum1+sum2)/Cs}' \
MethylDackel/${ID}_methratio_CG.bedGraph > MethylDackel_C_summaries/${ID}_whole_genome_percent_CG.txt
awk -F$"\\t" -v ID=$ID 'BEGIN {OFS = FS} {Cs ++; sum1 += $6; sum2 +=$5} END {print ID, sum1+sum2, sum2 , (sum2/(sum1+sum2)*100)}' \
MethylDackel/${ID}_methratio_CHG.bedGraph > MethylDackel_C_summaries/${ID}_whole_genome_percent_CHG.txt
awk -F$"\\t" -v ID=$ID 'BEGIN {OFS = FS} {Cs ++; sum1 += $6; sum2 +=$5} END {print ID, sum1+sum2, sum2 , (sum2/(sum1+sum2)*100)}' \
MethylDackel/${ID}_methratio_CHH.bedGraph > MethylDackel_C_summaries/${ID}_whole_genome_percent_CHH.txt
echo finished summarising
