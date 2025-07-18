#!/bin/bash
#FLUX: --job-name=pegasus_vcfMergerAC
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --urgency=16

beginTime=`date +%s`
machine=`hostname`
echo "### NODE: $machine"
echo "### SNPEFFPATH: ${SNPEFFPATH}"
echo "### SNPSIFT: ${SNPSIFT}"
echo "### RUNDIR: ${RUNDIR}"
echo "### NXT1: ${NXT1}"
echo "### MERGERDIR: ${MERGERDIR}"
echo "### SNPEFFPATH= $SNPEFFPATH"
echo "### SNPSIFT= $SNPSIFT"
echo "### SAMTOOLS= $SAMTOOLS"
echo "### VARSCAN= $VARSCAN"
echo "### REF= $REF"
echo "### DICT= $DICT"
echo "### COSMIC= $COSMIC"
echo "### SNPS= $SNPS"
echo "### INDELS= $INDELS"
echo "### GATK= $GATK"
echo "### VCFMERGER= $VCFMERGER"
echo "### VCFMERGER_DIR= $VCFMERGER_DIR"
echo "### VCFSORTER= $VCFSORTER"
echo "### RNA_VCF_HEADER= $RNA_VCF_HEADER"
echo "### POST_MERGE_VENN= $POST_MERGE_VENN"
echo "### DBSNP= $DBSNP"
echo "### DBVERSION= $DBVERSION"
echo "### MERGERDIR= $MERGERDIR"
echo "### RNABAM= $RNABAM"
echo "### ASSAYID= $ASSAYID"
echo "### RUNDIR= $RUNDIR"
echo "### D= $D"
echo "### BASENAME= $BASENAME"
echo "Generate RNA Pileup for DNA call positions"
module load BEDTools/2.26.0
module load R/3.2.1
grep -v "#" ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.vcf | awk '{print $1"-"$2"-"$3"-"$4"-"$5}' > ${MERGERDIR}/${BASENAME}_positions.txt
touch ${MERGERDIR}/${BASENAME}_positions_expanded.txt
for line in `cat ${MERGERDIR}/${BASENAME}_positions.txt`
do
    CHR=`echo ${line} | cut -d- -f1`
    POSITION=`echo ${line} | cut -d- -f2`
    if [ $POSITION -gt 25 ]; then
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-25}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-24}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-23}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-22}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-21}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-20}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-19}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-18}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-17}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-16}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-15}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-14}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-13}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-12}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-11}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-10}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-9}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-8}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-7}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-6}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-5}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-4}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-3}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-2}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2-1}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+1}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+2}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+3}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+4}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+5}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+6}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+7}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+8}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+9}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+10}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+11}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+12}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+13}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+14}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+15}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+16}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+17}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+18}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+19}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+20}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+21}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+22}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+23}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+24}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2+25}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
    else
        awk -v var1="$CHR" -v var2="$POSITION" 'BEGIN{OFS = "\t" ; print var1"-"var2}' >> ${MERGERDIR}/${BASENAME}_positions_expanded.txt
    fi
done
echo "The following is the top of the expanded positions list:"
cat ${MERGERDIR}/${BASENAME}_positions_expanded.txt | head
ORIGINAL_LINE_COUNT=`wc -l ${MERGERDIR}/${BASENAME}_positions_expanded.txt | awk '{print $1}'`
sort -n ${MERGERDIR}/${BASENAME}_positions_expanded.txt | uniq | awk '{gsub("-","\t",$0); print;}' > ${MERGERDIR}/${BASENAME}_positions_expanded_unique.txt
UNIQUE_LINE_COUNT=`wc -l ${MERGERDIR}/${BASENAME}_positions_expanded_unique.txt | awk '{print $1}'`
echo "The following is the top of the expanded unique positions list:"
cat ${MERGERDIR}/${BASENAME}_positions_expanded_unique.txt | head
echo "Found ${ORIGINAL_LINE_COUNT} lines in original positions list and ${UNIQUE_LINE_COUNT} in unique list"
${SAMTOOLS}/samtools mpileup -B -d10000000 -Q5 -f ${REF} -l ${MERGERDIR}/${BASENAME}_positions_expanded_unique.txt ${RNABAM} > ${MERGERDIR}/${BASENAME}.RNA.pileup
if [ $? -ne 0 ] ; then
    echo "### vcf merger allele count failed at mpileup stage"
    mv ${MERGERDIR}/${BASENAME}.vcfMergerACInQueue ${MERGERDIR}/${BASENAME}.vcfMergerACFail
    exit
fi
echo "Adding RNA calls to merged VCF"
echo "..."
cat ${RNA_VCF_HEADER} > ${MERGERDIR}/${BASENAME}.RNA.calls.vcf
for line in `cat ${MERGERDIR}/${BASENAME}_positions.txt`
do
    echo "${line}"
    CHR=`echo ${line} | cut -d- -f1`
    POSITION=`echo ${line} | cut -d- -f2`
    REF=`echo ${line} | cut -d- -f4`
    ALT=`echo ${line} | cut -d- -f5`
    echo "$CHR"
    echo "$POSITION"
    #Determine if the position is in the pileup
    LINE_COUNT=`awk -v var1="$CHR" -v var2="$POSITION" '{if($1 == var1 && $2 == var2) print $0}' ${MERGERDIR}/${BASENAME}.RNA.pileup | wc -l`
    if [ ${LINE_COUNT} -eq 0 ]
    then
        #This means the position is not in the pileup at all so the REF and ALT counts are then 0
        echo -e ${CHR}"\t"${POSITION}"\t"".""\t"${REF}"\t"${ALT}"\t"".""\t"".""\t""RNA_REF_COUNT=0;RNA_ALT_COUNT=0;RNA_ALT_FREQ=0.00" >> ${MERGERDIR}/${BASENAME}.RNA.calls.vcf
        echo "NOT FOUND IN RNA PILEUP - chr${CHR}:${POSITION}"
    else
        #This means the line is in the pileup, it does not tell if its just because of spanning reads due to splicing
        echo "Found chr${CHR}:${POSITION} in RNA pileup"
        #Add positions to a new list of variants to process out of the varscarn results file
        echo -e ${CHR}"-"${POSITION}"-.-"${REF}"-"${ALT} >> ${MERGERDIR}/${BASENAME}.RNA.calls.ToQueryPileup
    fi
    echo "---------------------------"
done
echo "Finished Creating RNA Pileup"
echo "Calculate RNA genotypes"
echo ...
java -jar ${VARSCAN}/VarScan.v2.3.7.jar mpileup2cns ${MERGERDIR}/${BASENAME}.RNA.pileup \
    --min-coverage 1 \
    --min-reads2 1 \
    --min-var-freq 0.02 \
    --min-freq-for-hom 0.9 \
    --min-avg-qual 5 \
    --strand-filter 0 \
    --output-vcf > ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.vcf
if [ $? -ne 0 ] ; then
        echo "### vcf merger allele count failed at calc RNA genotypes stage"
        mv ${MERGERDIR}/${BASENAME}.vcfMergerACInQueue ${MERGERDIR}/${BASENAME}.vcfMergerACFail
        exit 1
fi
echo "Finished Generating RNA Genotypes"
cd $MERGERDIR
cp ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.vcf varscan.vcf
java -jar ${SNPSIFT}/SnpSift.jar extractFields varscan.vcf CHROM POS REF ALT GEN[0].SDP GEN[0].RD GEN[0].AD > ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre.table
if [ $? -ne 0 ] ; then
        echo "### vcf merger allele count failed at converting to a table stage"
        mv ${MERGERDIR}/${BASENAME}.vcfMergerACInQueue ${MERGERDIR}/${BASENAME}.vcfMergerACFail
        exit 1
fi
cat ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre.table | cut -f7 | sed -e 's/^$/./g' > ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre2.table
cat ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre.table | cut -f6 | sed -e 's/^$/./g' > ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre3.table
cat ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre.table | cut -f5 | sed -e 's/^$/./g' > ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre4.table
cat ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre.table | cut -f4 | sed -e 's/^$/./g' > ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre5.table
cat ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre.table | cut -f3 | sed -e 's/^$/./g' > ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre6.table
cat ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre.table | cut -f2 | sed -e 's/^$/./g' > ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre7.table
cat ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre.table | cut -f1 | sed -e 's/^$/./g' > ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre8.table
paste ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre8.table ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre7.table ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre6.table ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre5.table ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre4.table ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre3.table ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.pre2.table > ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.table
echo "Starting to extract calls"
for line in `cat ${MERGERDIR}/${BASENAME}.RNA.calls.ToQueryPileup`
do
    echo "${line}"
    CHR=`echo ${line} | cut -d- -f1`
    POSITION=`echo ${line} | cut -d- -f2`
    REF=`echo ${line} | cut -d- -f4`
    ALT=`echo ${line} | cut -d- -f5`
    echo "$CHR"
    echo "$POSITION"
    #Determine if the position is in the tabulated varscan results
    LINE_COUNT=`awk -v var1="$CHR" -v var2="$POSITION" '{if($1 == var1 && $2 == var2) print $0}' ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.table | wc -l`
    if [ ${LINE_COUNT} -eq 0 ]
    then
        #This means the position was in the pileup but did not make it to the varscan tabulated results #### NEED A REASON FOR THIS!!! ####
        #These are added to the RNA calls as 0:0:0
        echo -e ${CHR}"\t"${POSITION}"\t"".""\t"${REF}"\t"${ALT}"\t"".""\t"".""\t""RNA_REF_COUNT=0;RNA_ALT_COUNT=0;RNA_ALT_FREQ=0.00" >> ${MERGERDIR}/${BASENAME}.RNA.calls.vcf
        echo "WARNING - NOT FOUND IN VARSCAN TABULATION - chr${CHR}:${POSITION}"
    elif [ ${LINE_COUNT} -eq 1 ]
    then
        #This means the line is in the VARSCAN TABULATION RESULTS
        echo "Found chr${CHR}:${POSITION} in Varscan tabulation"
        #Now we need to confirm the alternate is actually present as expected and get the values to add to the vcf
        #This gets the call line to a single
        awk -v var1="$CHR" -v var2="$POSITION" '{if($1 == var1 && $2 == var2) print $0}' ${MERGERDIR}/${BASENAME}.RNA.calls.varscan.table > temp.RNA.calls
        #ALT_READS=0  -  No alt reads detected
        #ALT_READS=1  -  Alt reads detected
        ALT_READS=`awk -v var1="$CHR" -v var2="$POSITION" -v var3="$REF" -v var4="$ALT" '{if($1 == var1 && $2 == var2 && $7 >= 1) print $0}' temp.RNA.calls | wc -l`
        if [ ${ALT_READS} -eq 1 ]
        then
            #Found expected variant allele
            REF_COUNT=`awk '{print $6}' temp.RNA.calls`
            ALT_COUNT=`awk '{print $7}' temp.RNA.calls`
            #Determine if the REF_COUNT variable is a "."
            if [ "${REF_COUNT}" == "." ]
            then
                #Reset variable to 0
                REF_COUNT=0
                echo "Found Reference allele count was empty, forcing to 0"
            else
                #Varialbe is good
                echo "Found ${REF_COUNT} bases"
                #Calculate the ratio
            fi
        ALT_FREQ=`echo "${REF_COUNT} ${ALT_COUNT}" | awk '{print $2/($1+$2)}'`
        echo "Calculated alternate allele frequency: ${ALT_FREQ}"
        #Print new lines to output
        echo -e ${CHR}"\t"${POSITION}"\t"".""\t"${REF}"\t"${ALT}"\t"".""\t"".""\t""RNA_REF_COUNT="${REF_COUNT}";RNA_ALT_COUNT="${ALT_COUNT}";RNA_ALT_FREQ="${ALT_FREQ} >> ${MERGERDIR}/${BASENAME}.RNA.calls.vcf
        elif [ ${ALT_READS} -eq 0 ]
        then
            #No alt reads found at all, just print ref counts and set alt to 0 ### NOT SO EASY ACTUALLY
            REF_COUNT=`awk '{print $6}' temp.RNA.calls`
            ALT_COUNT=0
            ALT_FREQ=0.00
            #Determine if the REF_COUNT variable is a "."
            if [ "${REF_COUNT}" == "." ]
            then
                #Reset variable to 0
                REF_COUNT=0
                echo "Found Reference allele count was empty, forcing to 0"
                else
                #Varialbe is good
                echo "Found ${REF_COUNT} bases"
            fi
            #Print new lines to output
            echo -e ${CHR}"\t"${POSITION}"\t"".""\t"${REF}"\t"${ALT}"\t"".""\t"".""\t""RNA_REF_COUNT="${REF_COUNT}";RNA_ALT_COUNT="${ALT_COUNT}";RNA_ALT_FREQ="${ALT_FREQ} >> ${MERGERDIR}/${BASENAME}.RNA.calls.vcf
        else
            #Unexpected
            echo "BAD THINGS ARE OCCURING.... chr${CHR}:${POSITION}"
        fi
    else
        #THIS IS UNEXPECTED
        echo "ERROR - The same variant is in the tabulated results more than once"
    fi
    echo "---------------------------"
done
${VCFSORTER} ${DICT} ${MERGERDIR}/${BASENAME}.RNA.calls.vcf > ${MERGERDIR}/${BASENAME}.RNA.calls.sorted.vcf
if [ $? -ne 0 ] ; then
        echo "### vcf merger allele count failed at vcfsorter stage"
        mv ${MERGERDIR}/${BASENAME}.vcfMergerACInQueue ${MERGERDIR}/${BASENAME}.vcfMergerACFail
        exit
fi
java -jar ${SNPSIFT}/SnpSift.jar annotate ${MERGERDIR}/${BASENAME}.RNA.calls.sorted.vcf ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.vcf > ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.rna.vcf
if [ $? -ne 0 ] ; then
        echo "### vcf merger allele count failed at add RNA values stage"
        mv ${MERGERDIR}/${BASENAME}.vcfMergerACInQueue ${MERGERDIR}/${BASENAME}.vcfMergerACFail
        exit
fi
echo "Finished Adding RNA Calls to VCF"
java -jar ${SNPSIFT}/SnpSift.jar dbnsfp \
    -v ${DBNSFP} \
    -a \
    -f Interpro_domain,Polyphen2_HVAR_pred,GERP++_NR,GERP++_RS,LRT_score,MutationTaster_score,MutationAssessor_score,FATHMM_score,Polyphen2_HVAR_score,SIFT_score,Polyphen2_HDIV_score \
    ${BASENAME}.merge.sort.clean.f2t.ann.rna.vcf > ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.rna.dbnsfp.vcf 2> ${MERGERDIR}/${BASENAME}.dbnsfpannote.perfOut
if [ $? -ne 0 ] ; then
    echo "### vcf merger failed at annotate with dbNSFP stage"
    mv ${MERGERDIR}/${BASENAME}.vcfMergerACInQueue ${MERGERDIR}/${BASENAME}.vcfMergerACFail
    exit 1
fi
java -Xmx4G -jar ${SNPEFFPATH}/snpEff.jar -canon -c ${SNPEFFPATH}/snpEff.config -v -noLog -lof ${DBVERSION} ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.rna.dbnsfp.vcf > ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.rna.dbnsfp.se74lofcan.vcf
java -Xmx4G -jar ${SNPEFFPATH}/snpEff.jar -c ${SNPEFFPATH}/snpEff.config -v -noLog -lof ${DBVERSION} ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.rna.dbnsfp.vcf > ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.rna.dbnsfp.se74lof.vcf
if [ $? -ne 0 ] ; then
    echo "### vcf merger failed at snpEff annotation stage"
    mv ${MERGERDIR}/${BASENAME}.vcfMergerACInQueue ${MERGERDIR}/${BASENAME}.vcfMergerACFail
    exit 1
fi
${POST_MERGE_VENN} --dirscript ${VCFMERGER_DIR} --vcf ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.rna.dbnsfp.se74lofcan.vcf --outprefix  ${MERGERDIR}/${BASENAME}_finalVenn  --maintitle ${BASENAME} --
if [ $? -ne 0 ] ; then
    echo "### vcf merger failed at venn diagram stage"
    mv ${MERGERDIR}/${BASENAME}.vcfMergerACInQueue ${MERGERDIR}/${BASENAME}.vcfMergerACFail
    exit 1
fi
mv ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.rna.dbnsfp.se74lofcan.vcf ${MERGERDIR}/${BASENAME}.merged.canonicalOnly.rna.final.vcf
mv ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.rna.dbnsfp.se74lof.vcf ${MERGERDIR}/${BASENAME}.merged.allTranscripts.rna.final.vcf
rm ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.rna.dbnsfp.vcf
rm ${MERGERDIR}/${BASENAME}.merge.sort.clean.vcf
rm ${MERGERDIR}/${BASENAME}.merge.sort.vcf
rm ${MERGERDIR}/${BASENAME}.RNA.calls.vcf
rm ${MERGERDIR}/${BASENAME}.merge.sort.clean.f2t.ann.rna.vcf
rm ${MERGERDIR}/varscan.vcf
rm -rf ${MERGERDIR}/${BASENAME}.vcfMergerACInQueue
touch ${MERGERDIR}/${BASENAME}.vcfMergerACPass
endTime=`date +%s`
elapsed=$(( $endTime - $beginTime ))
(( hours=$elapsed/3600 ))
(( mins=$elapsed%3600/60 ))
echo "RUNTIME:MERGEACALLELLECOUNT:$hours:$mins" > ${MERGERDIR}/${BASENAME}.vcfMergerAC.totalTime
time=`date +%d-%m-%Y-%H-%M` 
echo "Ending vcfMergerAC. "
