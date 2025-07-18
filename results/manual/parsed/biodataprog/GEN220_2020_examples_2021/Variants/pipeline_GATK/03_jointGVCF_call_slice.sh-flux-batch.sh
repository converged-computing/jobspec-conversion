#!/bin/bash
#FLUX: --job-name=slice.GVCFGeno
#FLUX: -n=2
#FLUX: --queue=intel
#FLUX: --urgency=16

hostname
MEM=24g
module unload java
module load picard
module load gatk/4
module load java/13
module load bcftools
module load parallel
source config.txt
declare -x TEMPDIR=$TEMP/$USER/$$
cleanup() { 
	#echo "rm temp is: $TEMPDIR"
	rm -rf $TEMPDIR
	rmdir $TEMPDIR
}
trap "cleanup; rm -rf $TEMPDIR; exit" SIGHUP SIGINT SIGTERM EXIT
GVCF_INTERVAL=1
N=${SLURM_ARRAY_TASK_ID}
if [ -z $N ]; then
    N=$1
    if [ -z $N ]; then
        echo "Need an array id or cmdline val for the job"
        exit
    fi
fi
if [ -f config.txt ]; then
	source config.txt
fi
if [ -z $SLICEVCF ]; then
	SLICEVCF=vcf_slice
fi
mkdir -p $SLICEVCF
STEM=$SLICEVCF/$PREFIX.$N
GENOVCFOUT=$STEM.all.vcf
FILTERSNP=$STEM.SNP.filter.vcf
FILTERINDEL=$STEM.INDEL.filter.vcf
SELECTSNP=$STEM.SNP.selected.vcf
SELECTINDEL=$STEM.INDEL.selected.vcf
if [ ! -f $REFGENOME ]; then
    module load samtools/1.9
    samtools faidx $REFGENOME
fi
NSTART=$(perl -e "printf('%d',1 + $GVCF_INTERVAL * ($N - 1))")
NEND=$(perl -e "printf('%d',$GVCF_INTERVAL * $N)")
MAX=$(wc -l $REFGENOME.fai | awk '{print $1}')
if [ "$NSTART" -gt "$MAX" ]; then
	echo "NSTART ($NSTART) > $MAX"
	exit
fi
if [ "$NEND" -gt "$MAX" ]; then
	NEND=$MAX
fi
echo "$NSTART -> $NEND"
CPU=$SLURM_CPUS_ON_NODE
if [ ! $CPU ]; then
    CPU=2
fi
if [[ $(ls $GVCFFOLDER | grep -c -P "\.g.vcf$") -gt "0" ]]; then
    parallel -j $CPU bgzip {} ::: $GVCFFOLDER/*.g.vcf
    parallel -j $CPU tabix -f {} ::: $GVCFFOLDER/*.g.vcf.gz
fi
FILES=$(ls $GVCFFOLDER/*.g.vcf.gz | sort | perl -p -e 's/(\S+)\n/-V $1 /')
INTERVALS=$(cut -f1 $REFGENOME.fai  | sed -n "${NSTART},${NEND}p" | perl -p -e 's/(\S+)\n/--intervals $1 /g')
mkdir -p $TEMPDIR
if [ ! -f $GENOVCFOUT.gz ]; then
    if [ ! -f $GENOVCFOUT ]; then
	DB=$TEMPDIR/${GVCFFOLDER}_slice_$N
	rm -rf $DB
	gatk  --java-options "-Xmx$MEM -Xms$MEM" GenomicsDBImport --consolidate --merge-input-intervals --genomicsdb-workspace-path $DB $FILES $INTERVALS --tmp-dir $TEMPDIR --reader-threads $CPU
	#--reader-threads $CPU
	#gatk  --java-options "-Xmx$MEM -Xms$MEM" GenomicsDBImport --genomicsdb-workspace-path $DB $FILES $INTERVALS  --reader-threads $CPU
	time gatk GenotypeGVCFs --reference $REFGENOME --output $GENOVCFOUT -V gendb://$DB --tmp-dir $TEMPDIR
	ls -l $TEMPDIR
	rm -rf $DB
    fi
    if [ -f $GENOVCFOUT ]; then
    	bgzip $GENOVCFOUT
    	tabix $GENOVCFOUT.gz
    fi
fi
TYPE=SNP
echo "VCF = $STEM.$TYPE.vcf.gz"
if [[ ! -f $STEM.$TYPE.vcf.gz ]]; then
    gatk SelectVariants \
	-R $REFGENOME \
	--variant $GENOVCFOUT.gz \
	-O $STEM.$TYPE.vcf \
	--restrict-alleles-to BIALLELIC \
	--select-type-to-include $TYPE --create-output-variant-index false
    bgzip $STEM.$TYPE.vcf
    tabix $STEM.$TYPE.vcf.gz
fi
if [[ ! -f $FILTERSNP.gz || $STEM.$TYPE.vcf.gz -nt $FILTERSNP.gz ]]; then
    gatk VariantFiltration --output $FILTERSNP \
	--variant $STEM.$TYPE.vcf.gz -R $REFGENOME \
	--cluster-window-size 10  \
	--filter-expression "QD < 2.0" --filter-name QualByDepth \
	--filter-expression "MQ < 40.0" --filter-name MapQual \
	--filter-expression "QUAL < 100" --filter-name QScore \
	--filter-expression "SOR > 4.0" --filter-name StrandOddsRatio \
	--filter-expression "FS > 60.0" --filter-name FisherStrandBias \
	--missing-values-evaluate-as-failing --create-output-variant-index false
    bgzip $FILTERSNP
    tabix $FILTERSNP.gz
fi
if [[ ! -f $SELECTSNP.gz || $FILTERSNP.gz -nt $SELECTSNP.gz ]]; then
    gatk SelectVariants -R $REFGENOME \
	--variant $FILTERSNP.gz \
	--output $SELECTSNP \
	--exclude-filtered --create-output-variant-index false
    bgzip $SELECTSNP
    tabix $SELECTSNP.gz
fi
TYPE=INDEL
if [ ! -f $STEM.$TYPE.vcf.gz ]; then
    gatk SelectVariants \
        -R $REFGENOME \
        --variant $GENOVCFOUT.gz \
        -O $STEM.$TYPE.vcf  --select-type-to-include MIXED --select-type-to-include MNP \
        --select-type-to-include $TYPE --create-output-variant-index false
    bgzip $STEM.$TYPE.vcf
    tabix $STEM.$TYPE.vcf.gz
fi
if [[ ! -f $FILTERINDEL.gz || $STEM.$TYPE.vcf.gz -nt $FILTERINDEL.gz ]]; then
    gatk VariantFiltration --output $FILTERINDEL \
	--variant $STEM.$TYPE.vcf.gz -R $REFGENOME \
	--cluster-window-size 10  -filter "QD < 2.0" --filter-name QualByDepth \
	-filter "SOR > 10.0" --filter-name StrandOddsRatio \
	-filter "FS > 200.0" --filter-name FisherStrandBias \
	-filter "InbreedingCoeff < -0.8" --filter-name InbreedCoef \
	--create-output-variant-index false
    bgzip $FILTERINDEL
    tabix $FILTERINDEL.gz
fi
if [[ ! -f $SELECTINDEL.gz || $FILTERINDEL.gz -nt $SELETINDEL.gz ]]; then
    gatk SelectVariants -R $REFGENOME \
	--variant $FILTERINDEL.gz \
	--output $SELECTINDEL \
	--exclude-filtered --create-output-variant-index false
    bgzip $SELECTINDEL
    tabix $SELECTINDEL.gz
fi
if [ -d $TEMPDIR ]; then
	rmdir $TEMPDIR
fi
