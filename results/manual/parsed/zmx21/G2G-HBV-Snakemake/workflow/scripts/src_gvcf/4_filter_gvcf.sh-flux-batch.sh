#!/bin/bash
#FLUX: --job-name=4_filter_gvcf
#FLUX: -t=43200
#FLUX: --urgency=16

export TMPDIR='/scratch/rueger/$SLURM_JOB_ID'

module load gcc/6.4.0
module load gcc/7.3.0
module load intel/18.0.2
DIROUT=/scratch/rueger/gvcf_tmp
export TMPDIR=/scratch/rueger/$SLURM_JOB_ID
HOME=/work/gr-fe/rueger/G2G-HBV
VEP=/work/gr-fe/lawless/ref/variant_effect_predictor
vcfhacks=/work/gr-fe/lawless/tool/vcfhacks
hg1kv37=/work/gr-fe/lawless/ref/b37/human_g1k_v37.fasta
GATK=/work/gr-fe/lawless/tool/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar
K1GINDEL=/work/gr-fe/lawless/ref/b37/1000G_phase1.indels.b37.vcf
MILLS1000G=/work/gr-fe/lawless/ref/b37/Mills_and_1000G_gold_standard.indels.b37.sites.vcf
DBSNP=/work/gr-fe/lawless/ref/b37/dbSnp146.b37.vcf.gz
SSV5=/work/gr-fe/lawless/ref/SureSelectAllExonV5/S04380110_Regions_b37.bed
HAPMAPSITES=/work/gr-fe/lawless/ref/b37/hapmap_3.3.b37.sites.vcf
K1GOMNISITES=/work/gr-fe/lawless/ref/b37/1000G_omni2.5.b37.sites.vcf
K1GSNP=/work/gr-fe/lawless/ref/b37/1000G_phase1.snps.high_confidence.b37.vcf
echo started at `date`
filter=hard ## option 2
if [ $filter = "hard" ]
then
echo applying hard filter
  java -jar $GATK \
  -T SelectVariants \
  -R $hg1kv37 \
  -selectType SNP \
  --variant $DIROUT/hbv_gilead_joint_genotype.vcf \
  -o $DIROUT/hbv_gilead_joint_genotype_raw-snps.vcf
  java -jar $GATK \
  -T SelectVariants \
  -R $hg1kv37 \
  --variant $DIROUT/hbv_gilead_joint_genotype.vcf \
  -selectType INDEL -selectType MNP \
  -o $DIROUT/hbv_gilead_joint_genotype_raw-indels.vcf
  java -jar $GATK \
  -T VariantFiltration \
  -R $hg1kv37 \
  -V $DIROUT/hbv_gilead_joint_genotype_raw-snps.vcf \
  --filterExpression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MappingQualityRankSum < -12.5 || ReadPosRankSum < -8.0" \
  --filterName "snp_hard_filter" \
  -o $DIROUT/hbv_gilead_joint_genotype_raw-snps.filtered.snvs.vcf 
  java -jar $GATK \
  -T VariantFiltration \
  -R $hg1kv37 \
  -V $DIROUT/hbv_gilead_joint_genotype_raw-indels.vcf \
  --filterExpression "QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0" \
  --filterName "indel_hard_filter" \
  -o $DIROUT/hbv_gilead_joint_genotype_raw-indels.filtered.indels.vcf
  # Now join the two datasets back together
  java -jar $GATK \
  -T CombineVariants \
  -R $hg1kv37 \
  --variant $DIROUT/hbv_gilead_joint_genotype_raw-snps.filtered.snvs.vcf \
  --variant $DIROUT/hbv_gilead_joint_genotype_raw-indels.filtered.indels.vcf \
  -o $DIROUT/hbv_gilead_joint_genotype.fltd-combinedvars.vcf \
  --genotypemergeoption UNSORTED
fi
if [ $filter = "soft" ]
then
echo applying soft filter
java -Xmx24g -Djava.io.tmpdir=/scratch/rueger/${SLURM_JOBID} \
  -jar $GATK \
  -T VariantRecalibrator \
  -R $hg1kv37 \
  -resource:hapmap,known=false,training=true,truth=true,prior=15.0 $HAPMAPSITES \
  -resource:omni,known=false,training=true,truth=false,prior=12.0 $K1GOMNISITES \  ## truth-false
  -resource:1000G,known=false,training=true,truth=false,prior=10.0 $K1GSNP \
  -resource:dbsnp,known=true,training=false,truth=false,prior=2.0 $DBSNP \
  -an QD -an MQRankSum -an ReadPosRankSum -an FS \
  -tranche 100.0 -tranche 99.9 -tranche 99.0 -tranche 90.0 \
  -mode SNP \
  -input $DIROUT/hbv_gilead_joint_genotype.vcf \
  -recalFile $DIROUT/hbv_gilead_joint_genotype.snvrecal \
  -tranchesFile $DIROUT/hbv_gilead_joint_genotype.snvrecal.tranches \
  -rscriptFile $DIROUT/hbv_gilead_joint_genotype.snvrecal.plots.R -nt 1 && \
java -Xmx24g -Djava.io.tmpdir=/scratch/rueger/${SLURM_JOBID} \
  -jar $GATK \
  -T VariantRecalibrator \
  -R $hg1kv37 \
  -resource:mills,known=false,training=true,truth=true,prior=12.0 $MILLS1000G \
  -resource:dbsnp,known=true,training=false,truth=false,prior=2.0 $DBSNP \
  -an FS -an ReadPosRankSum -an MQRankSum -mode INDEL \
  -input $DIROUT/hbv_gilead_joint_genotype.vcf \
  -recalFile $DIROUT/hbv_gilead_joint_genotype.indelrecal \
  -tranchesFile $DIROUT/hbv_gilead_joint_genotype.indelrecal.tranches \
  -rscriptFile $DIROUT/hbv_gilead_joint_genotype.indelrecal.plots.R -nt 1 && \
java -Xmx24g -Djava.io.tmpdir=/scratch/rueger/${SLURM_JOBID} \
  -jar $GATK \
  -T ApplyRecalibration \
  -R $hg1kv37 \
  -input $DIROUT/hbv_gilead_joint_genotype.vcf \
  -recalFile $DIROUT/hbv_gilead_joint_genotype.snvrecal \
  -tranchesFile $DIROUT/hbv_gilead_joint_genotype.snvrecal.tranches \
  -o $DIROUT/hbv_gilead_joint_genotype.snvts99pt9.vcf \
  -mode SNP --ts_filter_level 99.9 -nt 1 && \
java -Xmx24g -Djava.io.tmpdir=/scratch/rueger/${SLURM_JOBID} \
  -jar $GATK \
  -T ApplyRecalibration \
  -R $hg1kv37 \
  -input $DIROUT/hbv_gilead_joint_genotype.snvts99pt9.vcf \
  -recalFile $DIROUT/hbv_gilead_joint_genotype.indelrecal \
  -tranchesFile $DIROUT/hbv_gilead_joint_genotype.indelrecal.tranches  \
  -o $DIROUT/hbv_gilead_joint_genotype.ts99pt9.vcf \
  -mode INDEL --ts_filter_level 99.9 -nt 1 && \
perl $vcfhacks/annotateSnps.pl \
  -d $DBSNP /work/gr-fe/lawless/ref/b37/clinvar_20160531.vcf.gz -f 1 -pathogenic \
  -i $DIROUT/hbv_gilead_joint_genotype.ts99pt9.vcf \
  -o $DIROUT/hbv_gilead_joint_genotype.1pcdbsnp.vcf -t 16 && \
perl $vcfhacks/filterOnEvsMaf.pl \
  -d /work/gr-fe/lawless/ref/evs/ -f 1 --progress \
  -i $DIROUT/hbv_gilead_joint_genotype.ts99pt9.1pcdbsnp.vcf \
  -o $DIROUT/hbv_gilead_joint_genotype.ts99pt9.1pcdbsnp.1pcEVS.vcf -t 16 && \
fi
echo ended at `date`
exit
