#!/bin/bash
#FLUX: --job-name=cna2015_exo
#FLUX: -c=2
#FLUX: -t=43200
#FLUX: --urgency=16

export PERL5LIB='$PERL5LIB:/home/jaldrich/perl5/lib/perl5:/usr/lib64/perl5/vendor_perl'
export MCR_CACHE_ROOT='${TD}/TempDir'

module load VCFtools/0.1.13
module load perl/5.14.2
module load MCR/9.0
module load BEDTools/2.26.0
module load R/3.4.1
export PERL5LIB=$PERL5LIB:/home/jaldrich/perl5/lib/perl5:/usr/lib64/perl5/vendor_perl
MCRPATH=/packages/MCR/9.0
cd ${DIR}
CNAPATH="/home/tgenref/binaries/tconut/mmrf_pegasusCNA"
TARGETSFILE=${CNAEXOMETARGET}
EXTENSIONS=${BASEDIR}/save_recipe.txt
ZTABLE="${CNAPATH}/ztable.txt"
CCDSLIST="/home/tgenref/homo_sapiens/grch37_hg19/hs37d5_tgen/gene_model/ensembl_v74/Homo_sapiens.GRCh37.74.gtf.hs37d5.EGFRvIII.gtf"
SNPSIFT=/home/achristofferson/local/snpEff_4.2_2015-12-05/SnpSift.jar
DBSNP_VCF=/home/tgenref/homo_sapiens/grch37_hg19/public_databases/dbsnp/b137/dbsnp_137.b37.vcf
GENDER_GRAPH_R=${JOBSDIR}/Gender_Graph.R
FAILED=0
TD=`pwd`
mkdir TempDir
TMPDIR=${TD}/TempDir
TMP=${TD}/TempDir
TEMPDIR=${TD}/TempDir
export MCR_CACHE_ROOT=${TD}/TempDir
cat ${VCF} | java -jar ${SNPSIFT} intervals ${BEDFILE} > ${VCF}.temp.vcf
if [ $? -ne 0 ]
then
        FAILED=1
fi
mv ${VCF} ${VCF}.original
mv ${VCF}.temp.vcf ${VCF}
cat ${VCF} | java -jar ${SNPSIFT} intervals /home/tgenref/binaries/tconut/mmrf_pegasusCNA/CNA_type2_and_pos35_filter_X_fixed_intervals_to_keep_X_Y.bed > ${VCF}.temp.vcf
if [ $? -ne 0 ]
then
        FAILED=1
fi
mv ${VCF} ${VCF}.filtered.original
mv ${VCF}.temp.vcf ${VCF} 
mkdir genderTest
echo "The following line contains the Haplotyper Caller VCF header:"
grep -v "##" ${VCF} | grep "#"
echo Extracting the first genotype column to determine if it is tumor or normal
FIRST_GENOTYPE_COLUMN=`grep -v "##" ${VCF} | grep "#" | cut -f10`
echo The first genotype column header is: ${FIRST_GENOTYPE_COLUMN}
FRACTION_LETTER=`echo ${FIRST_GENOTYPE_COLUMN} | cut -d_ -f6 | cut -c1`
echo The fraction letter in the first genotype column is: ${FRACTION_LETTER}
if [ "${FRACTION_LETTER}" == "T" ]
then
	echo Found expected genotype order - Proceeding with filtering
	cat ${VCF} | java -jar ${SNPSIFT} filter \
	"( GEN[1].DP > 50 ) & isVariant( GEN[1] ) \
	& ((REF = 'A') | (REF = 'C') | (REF = 'G') | (REF = 'T')) \
	& ((ALT = 'A') | (ALT = 'C') | (ALT = 'G') | (ALT = 'T')) \
	& (exists ID) & ( ID =~ 'rs' ) \
	& ( CHROM = 'X' )" | \
	java -jar ${SNPSIFT} annotate -info GMAF ${DBSNP_VCF} - | \
	java -jar ${SNPSIFT} filter "( GMAF >= 0.05 )" | \
	java -jar ${SNPSIFT} extractFields -e "." - \
	CHROM POS ID REF ALT FILTER GEN[1].AD[0] GEN[1].AD[1] GEN[1].DP | \
	awk 'NR>1' | \
	awk 'BEGIN{OFS = "\t" ; print "Chr", "Pos", "Normal_Ratio", "Normal_DP"}{OFS = "\t" ; print $1, $2, $8/($7+$8), $9}' > GenderDataTable.txt
elif [ "${FRACTION_LETTER}" == "C" ]
then
	echo Found the wrong genotype order - Reordering genotype columns and then Proceeding with filtering
	awk -F'\t' '{OFS="\t" ; print $1,$2,$3,$4,$5,$6,$7,$8,$9,$11,$10}' ${VCF} | java -jar ${SNPSIFT} filter \
	"( GEN[1].DP > 50 ) & isVariant( GEN[1] ) \
	& ((REF = 'A') | (REF = 'C') | (REF = 'G') | (REF = 'T')) \
	& ((ALT = 'A') | (ALT = 'C') | (ALT = 'G') | (ALT = 'T')) \
	& (exists ID) & ( ID =~ 'rs' ) \
	& ( CHROM = 'X' )" | \
	java -jar ${SNPSIFT} annotate -info GMAF ${DBSNP_VCF} - | \
	java -jar ${SNPSIFT} filter "( GMAF >= 0.05 )" | \
	java -jar ${SNPSIFT} extractFields -e "." - \
	CHROM POS ID REF ALT FILTER GEN[1].AD[0] GEN[1].AD[1] GEN[1].DP | \
	awk 'NR>1' | \
	awk 'BEGIN{OFS = "\t" ; print "Chr", "Pos", "Normal_Ratio", "Normal_DP"}{OFS = "\t" ; print $1, $2, $8/($7+$8), $9}' > GenderDataTable.txt
else
	#This should not happen
	echo WARNING!!! ERROR - PLEASE LOOK WE DID NOT FIND A T or C, what the hell!
	exit 1
fi
MEAN=`awk 'NR>1' GenderDataTable.txt | awk '{sum+=$3} END {print sum/NR}'`
SD=`awk 'NR>1' GenderDataTable.txt | awk '{sum+=$3; array[NR]=$3} END {for(x=1;x<=NR;x++){sumsq+=((array[x]-(sum/NR))**2);}print sqrt(sumsq/NR)}'`
ALLELES=`awk 'NR>1' GenderDataTable.txt | wc -l | cut -f1`
if [[ $MEAN > 0.8 ]]
then
        MALE=yes
	awk -F'\t' '{ if ($1 == 23 || $1 == 24) { OFS = "\t" ; print $1,$2,$3*2 } else { print $0 }}' ${NORMALDAT} > ${NORMALDAT}.male
        mv ${NORMALDAT} ${NORMALDAT}.original
        mv ${NORMALDAT}.male ${NORMALDAT}
fi
NORMX=`cat ${NORMALSAMPLE}.proj.md.jr.bam.picHSMetrics|grep -v ^#|grep -v ^BAIT |cut -f 22`
echo $NORMX
TUMORX=`cat ${TUMORSAMPLE}.proj.md.jr.bam.picHSMetrics|grep -v ^#|grep -v ^BAIT |cut -f 22`
echo $TUMORX
/home/tgenref/binaries/tconut/mmrf_pegasusCNA/parseHC_VCF_BAF.pl ${VCF}.filtered.original ${NORMALSAMPLE} ${TUMORSAMPLE}
if [ $? -ne 0 ]
then
	FAILED=1
fi
/home/tgenref/binaries/tconut/mmrf_pegasusCNA/parseHC_VCF_Hets.pl ${VCF} ${NORMALSAMPLE} ${TUMORSAMPLE}
if [ $? -ne 0 ]
then
        FAILED=1
fi
HETFILE=merged.vcf.txt
assayID="Exome"
smWin=6                 #   <<<< THIS CAN BE ADJUSTED - smoothing window size >>>>
fcThresh=0.2           #   <<<< THIS CAN BE ADJUSTED - fold-change threshold - plot >>>>
res=2                   #   <<<< THIS CAN BE ADJUSTED - min resolution >>>>
maxGap=1000   		#   <<<< THIS CAN BE ADJUSTED - max distance between consecutive postions >>>>
hetDepthN=${NORMX}      #   <<<< THIS CAN BE ADJUSTED - min depth of diploid het position >>>>
hetDepthT=${TUMORX}     #   <<<< THIS CAN BE ADJUSTED - min depth of diploid het position >>>>
hetDev=0.025             #   <<<< THIS CAN BE ADJUSTED - allowable deviation from ref allele frequency of 0.5
readDepth=$( echo "$hetDepthN * 3" | bc )            #   <<<< THIS CAN BE ADJUSTED - min number of counts >>>
echo $readDepth
echo "time /home/tgenref/binaries/tconut/mmrf_pegasusCNA/pegasusCNA_MMRF/run_ngsCNA.sh ${MCRPATH} ${NORMALDAT} ${TUMORDAT} ${OFILE}_exo ${HETFILE} ${smWin} ${fcThresh} ${assayID} ${res} ${readDepth} ${maxGap} ${hetDepth} ${hetDev} ${TARGETSFILE}"
time /home/tgenref/binaries/tconut/mmrf_pegasusCNA/pegasusCNA_MMRF/run_ngsCNA.sh ${MCRPATH} ${NORMALDAT} ${TUMORDAT} ${OFILE}_exo ${HETFILE} ${smWin} ${fcThresh} ${assayID} ${res} ${readDepth} ${maxGap} ${hetDepthN} ${hetDepthT} ${hetDev} ${TARGETSFILE}
if [ $? -ne 0 ]
then
        FAILED=1
fi
awk 'NR>1 { print $1"\t"$2"\t"$2+1"\t"$3 }' ${OFILE}_exo.cna.tsv > tmp.bed
bedtools intersect -wa -a tmp.bed -b /home/tgenref/binaries/tconut/mmrf_pegasusCNA/CNA_type2_and_pos35_filter_X_fixed_intervals_to_exclude.bed -c | awk '$5>0' |cut -f 1,2,4 > filt.tsv
/home/tgenref/binaries/tconut/mmrf_pegasusCNA/dlrs/run_runDLRS.sh ${MCRPATH} filt.tsv 1 ${OFILE}_exo.filt2012
rm filt.tsv
rm tmp.bed
awk 'NR>1 { print $1"\t"$2"\t"$2+1"\t"$3 }' ${OFILE}_exo.cna.tsv > tmp.bed
bedtools intersect -wa -a tmp.bed -b /home/tgenref/binaries/tconut/mmrf_pegasusCNA/CNA_waterfall_filter_035_removed_intervals.bed -c | awk '$5>0' |cut -f 1,2,4 > filt.tsv
/home/tgenref/binaries/tconut/mmrf_pegasusCNA/dlrs/run_runDLRS.sh ${MCRPATH} filt.tsv 1 ${OFILE}_exo.filt2016
rm filt.tsv
rm tmp.bed
Rscript --vanilla /home/tgenref/binaries/tconut/mmrf_pegasusCNA/validateCNAHets_v2.R ${OFILE}_exo.hets.tsv
if [ $? -ne 0 ]
then
        FAILED=1
fi
if [ -f CNA_unimodal_pass ]
then
        echo
        echo ${OFILE}_exo.hets.tsv fits a unimodal distribution.
        echo Continuing CNA script.
        ## CBS segmentation
        Rscript --vanilla /home/tgenref/binaries/tconut/mmrf_pegasusCNA/runDNAcopyExomeV4.R ${OFILE}_exo.cna.tsv ${OFILE}_exo.seg
	if [ $? -ne 0 ]
	then
        	FAILED=1
	fi
else
	# keep hets.tsv original
        mv ${OFILE}_exo.hets.tsv ${OFILE}_exo.hets.tsv.original	
	awk -F'\t' '{ OFS = "\t" ; print $2,$3-10000,$3+10000 }' CNA_positions_to_exclude.txt > CNA_intervals_to_exclude.bed
        bedtools merge -i CNA_intervals_to_exclude.bed > CNA_intervals_to_exclude_merged.bed
        awk -F'\t' 'NR > 1 { OFS = "\t" ; print $1,$2,$2+1,$3,$4,$5,$6,$7,$8 }' merged.vcf.txt > merged.vcf.bed
        mv merged.vcf.txt merged.vcf.txt.original
        bedtools intersect -v -a merged.vcf.bed -b CNA_intervals_to_exclude_merged.bed > temp
        awk -F'\t' 'BEGIN { OFS = "\t" ; print "Chromosome","Position","NormalReadDepth","NormalRefAllele","NormalAltAllele","TumorReadDepth","TumorRefAllele","TumorAltAllele" } { OFS = "\t" ; print $1,$2,$4,$5,$6,$7,$8,$9 }' temp > merged.vcf.txt
        rm temp
        time /home/tgenref/binaries/tconut/mmrf_pegasusCNA/pegasusCNA_MMRF/run_ngsCNA.sh ${MCRPATH} ${NORMALDAT} ${TUMORDAT} ${OFILE}_exo ${HETFILE} ${smWin} ${fcThresh} ${assayID} ${res} ${readDepth} ${maxGap} ${hetDepthN} ${hetDepthT} ${hetDev} ${TARGETSFILE}
	if [ $? -ne 0 ]
        then
                FAILED=1
        fi 
        ## CBS segmentation
        Rscript --vanilla /home/tgenref/binaries/tconut/mmrf_pegasusCNA/runDNAcopyExomeV4.R ${OFILE}_exo.cna.tsv ${OFILE}_exo.seg
	if [ $? -ne 0 ]
        then
                FAILED=1
        fi
fi
Rscript --vanilla /home/tgenref/binaries/tconut/mmrf_pegasusCNA/plotCGH_EXOME.R ${OFILE}_exo.cna.tsv ${OFILE}_exo.amp.tsv ${OFILE}_exo.del.tsv ${OFILE}_exo
if [ $? -ne 0 ]
then
	FAILED=1
fi
if [ -f ${OFILE}_exo.hets.tsv ]
then
	Rscript --vanilla /home/tgenref/binaries/tconut/mmrf_pegasusCNA/plotCGHwithHets.R ${OFILE}_exo.cna.tsv ${OFILE}_exo.amp.tsv ${OFILE}_exo.del.tsv ${OFILE}_exo.hets.tsv ${OFILE}_exo_withhets
	if [ $? -ne 0 ]
        then
                FAILED=1
        fi
fi
Rscript --vanilla /home/tgenref/binaries/tconut/mmrf_pegasusCNA/plotBAF.R baf.txt ${OFILE}_exo.baf
if [ $? -ne 0 ]
then
	FAILED=1
fi
Rscript --vanilla /home/tgenref/binaries/tconut/mmrf_pegasusCNA/runDNAcopyBAF.R baf.txt ${OFILE}_exo.baf
if [ $? -ne 0 ]
then
        FAILED=1
fi
DUPTHRESH=0.58     #   <<<< THIS CAN BE ADJUSTED - Amplification Threshold - log2 fold-change >>>>
DELTHRESH=-0.99    #   <<<< THIS CAN BE ADJUSTED - Deletion Threshold - log2 fold-change >>>>
/home/tgenref/binaries/tconut/mmrf_pegasusCNA/annotSeg.pl ${CCDSLIST} ${OFILE}_exo.cna.seg ${DUPTHRESH} ${DELTHRESH}
if [ $? -ne 0 ]
then
        FAILED=1
fi
/home/tgenref/binaries/tconut/mmrf_pegasusCNA/validateCNAVariantsVCF.pl ${OFILE}_exo.cna.seg.vcf baf.txt ${ZTABLE}
if [ $? -ne 0 ]
then
        FAILED=1
fi
module load MCR/9.0
MCR9PATH=/packages/MCR/9.0
/home/tgenref/binaries/tconut/mmrf_pegasusCNA/plotLinearCNA/run_plotLinearCNAandBAF.sh ${MCR9PATH} ${OFILE}_exo.cna.tsv baf.txt ${OFILE}_exo.cnaBAF.png
if [ $? -ne 0 ]
then
        FAILED=1
fi
/home/tgenref/binaries/tconut/mmrf_pegasusCNA/plotLinearCNAabsBAF/run_plotLinearCNAandAbsBAF.sh ${MCR9PATH} ${OFILE}_exo.cna.tsv baf.txt ${OFILE}_exo.cnaAbsBAF.png
if [ $? -ne 0 ]
then
        FAILED=1
fi
fails=0
if [ ${FAILED} = 0 ]
then
	for extToCopy in `cat $EXTENSIONS | grep "cna=" |cut -d= -f2 | tr "," "\n"`
	do
	        for fileToSave in `find ${DIR} -name "*$extToCopy"`
	        do
	        	fileName=`basename $fileToSave`
	                ssh ${USER}@${DATAMOVERIP} "rsync $fileToSave ${STARTDIR}/${PATIENT_NAME}/cna_manual_2016/${EXOMEPAIR}_exo/ "
			if [ $? -ne 0 ]
			then
	               		fails=1
	                fi
		done
	done
	ssh ${USER}@${DATAMOVERIP} "rsync ${DIR}/${NORMALSAMPLE}.proj.md.jr.bam.clc.cln.dat.cnaStats ${STARTDIR}/${PATIENT_NAME}/stats/${NORMALSAMPLE}.proj.md.jr.bam.clc.cln.dat.cnaManual2016Stats"
	if [ $? -ne 0 ]
	then
		fails=1
	fi
	ssh ${USER}@${DATAMOVERIP} "rsync ${DIR}/${TUMORSAMPLE}.proj.md.jr.bam.clc.cln.dat.cnaStats ${STARTDIR}/${PATIENT_NAME}/stats/${TUMORSAMPLE}.proj.md.jr.bam.clc.cln.dat.cnaManual2016Stats"
	if [ $? -ne 0 ]
        then
                fails=1
        fi
	ssh ${USER}@${DATAMOVERIP} "rsync ${DIR}/${OFILE}_exo.filt2012.dlrs ${STARTDIR}/${PATIENT_NAME}/stats/${NORMALSAMPLE}_exo.filt2012.dlrs "
	if [ $? -ne 0 ]
        then
                fails=1
        fi
	ssh ${USER}@${DATAMOVERIP} "rsync ${DIR}/${OFILE}_exo.filt2012.dlrs ${STARTDIR}/${PATIENT_NAME}/stats/${TUMORSAMPLE}_exo.filt2012.dlrs "
        if [ $? -ne 0 ]
        then
                fails=1
        fi
	ssh ${USER}@${DATAMOVERIP} "rsync ${DIR}/${OFILE}_exo.filt2016.dlrs ${STARTDIR}/${PATIENT_NAME}/stats/${NORMALSAMPLE}_exo.filt2016.dlrs "
        if [ $? -ne 0 ]
        then
                fails=1
        fi
	ssh ${USER}@${DATAMOVERIP} "rsync ${DIR}/${OFILE}_exo.filt2016.dlrs ${STARTDIR}/${PATIENT_NAME}/stats/${TUMORSAMPLE}_exo.filt2016.dlrs "
        if [ $? -ne 0 ]
        then
                fails=1
        fi
else
	ssh ${USER}@${DATAMOVERIP} "rm ${STARTDIR}/${PATIENT_NAME}/cna_manual_2016/${EXOMEPAIR}_exo/CNA_Manual_In_Progress ; \
		rm ${STARTDIR}/${PATIENT_NAME}/CNA_Manual_In_Progress ; \
		touch ${STARTDIR}/${PATIENT_NAME}/CNA_Manual_Fail ; \
		echo CNA pbs script failed for ${EXOMEPAIR} >> ${STARTDIR}/${PATIENT_NAME}/cna_manual_2016/${EXOMEPAIR}_exo/CNA_Manual_Fail ; \
		echo CNA pbs script failed for ${EXOMEPAIR} | mailx -s "Post_Medusa_Processing_Failed" ${USER}@tgen.org "
	exit 1
fi
if [ $fails -eq 0 ] && [ ${FAILED} = 0 ] 
then
	ssh ${USER}@${DATAMOVERIP} "rm ${STARTDIR}/${PATIENT_NAME}/cna_manual_2016/${EXOMEPAIR}_exo/CNA_Manual_In_Progress ; \
		touch ${STARTDIR}/${PATIENT_NAME}/cna_manual_2016/${EXOMEPAIR}_exo/CNA_Manual_Complete ; \
		COMPLETE=0 ; \
		for XPAIR in \`echo ${EXPECTEDPAIRS} | sed 's/@/\n/g'\` 
		do 
			if [ ! -f ${STARTDIR}/${PATIENT_NAME}/cna_manual_2016/\${XPAIR}/CNA_Manual_Complete ]
			then
				COMPLETE=1
			fi
		done ; \
		if [ \${COMPLETE} = 0 ]
		then
			rm ${STARTDIR}/${PATIENT_NAME}/CNA_Manual_In_Progress
			touch ${STARTDIR}/${PATIENT_NAME}/CNA_Manual_Complete
		fi "
else
	if [ $fails -ne 0 ] && [ ${FAILED} = 0 ]
	then
		ssh ${USER}@${DATAMOVERIP} "rm ${STARTDIR}/${PATIENT_NAME}/cna_manual_2016/${EXOMEPAIR}_exo/CNA_Manual_In_Progress ; \
        	        echo CNA pbs script failed to rsync back to isilon for ${EXOMEPAIR} >> ${STARTDIR}/${PATIENT_NAME}/cna_manual_2016/${EXOMEPAIR}_exo/CNA_Manual_Fail ; \
        	        echo CNA pbs script failed to rsync back to isilon for ${EXOMEPAIR} | mailx -s "Post_Medusa_Processing_Failed" ${USER}@tgen.org "
	fi
fi
