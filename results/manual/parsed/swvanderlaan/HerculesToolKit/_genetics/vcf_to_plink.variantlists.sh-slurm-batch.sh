#!/bin/bash
#FLUX: --job-name=vcf_to_plink_variantlists
#FLUX: -t=15300
#FLUX: --urgency=16

                                                                    														# or ALL (equivalent to BEGIN, END, FAIL, INVALID_DEPEND, REQUEUE, and STAGE_OUT), 
                                                                    														# Multiple type values may be specified in a comma separated list. 
echo ">-----------------------------------------------------------------------------------"
echo "                          MAKE VARIANT LISTS OF VCF-FILES"
echo "                               version 2.0 (20230131)"
echo ""
echo "* Written by  : Sander W. van der Laan"
echo "* E-mail      : s.w.vanderlaan-2@umcutrecht.nl"
echo "* Last update : 2023-01-31"
echo "* Version     : make_variant_lists"
echo ""
echo "* Description : This script will set some directories, make a variant list based on "
echo "                the VCF-files that were used for imputation (chr1-chr23, but "
echo "                including MT and Y) in a for loop, and will then submit this "
echo "                in a job."
echo ""
echo ">-----------------------------------------------------------------------------------"
echo "Today's: "`date`
echo ""
echo ">-----------------------------------------------------------------------------------"
echo "The following directories are set."
SOFTWARE="/hpc/local/CentOS7/dhl_ec/software"
REFERENCE="/hpc/dhl_ec/data/references/1000G"
PHASE3="/hpc/dhl_ec/data/references/1000G/Phase3"
VCFFORMAT="${PHASE3}/VCF_format"
IMPUTE2FORMAT="${PHASE3}/IMPUTE2_format"
PLINKFORMAT="${PHASE3}/PLINK_format"
echo "Software directory_________________ " ${SOFTWARE}
echo "1000G Phase3 directory_____________ " ${PHASE3}
echo "1kG, phase 3 VCF directory_________ " ${VCFFORMAT}
echo "1kG, phase 3 IMPUTE2  directory____ " ${IMPUTE2FORMAT}
echo "1kG, phase 3 PLINK  directory______ " ${PLINKFORMAT}
echo ""
echo ">-----------------------------------------------------------------------------------"
echo "Extracting some data in a for loop example and submitting this as a job."
echo "Processing VCF-formatted files."
cat $PHASE3/ALL.phase3_shapeit2_mvncall_integrated_v5b.20130502.VARIANTLIST.txt | tail -n +2 | grep -v "esv" | grep -v "ALU" | grep -v "CN" | grep -v "INS" | grep -v "," | awk '{if($2~ /rs*/) { print $1, $2 } else { print $1, $1 } }' | awk '!seen[$1]++' > $PHASE3/ALL.phase3_shapeit2_mvncall_integrated_v5b.20130502.VARIANTLIST.PLINKupdate.only_biallelic.txt
cat $PHASE3/ALL.phase3_shapeit2_mvncall_integrated_v5b.20130502.VARIANTLIST.txt | tail -n +2 | grep -v "esv" | grep -v "ALU" | grep -v "CN" | grep -v "INS" | grep -v "," | awk '{if($2~ /rs*/) { print $1, $2 } else { print $1, $1 } }' | grep "rs" | awk '!seen[$1]++' > $PHASE3/ALL.phase3_shapeit2_mvncall_integrated_v5b.20130502.VARIANTLIST.PLINKupdate.only_biallelic.only_rsIDs.txt
echo ""
echo ">-----------------------------------------------------------------------------------"
echo "Wow. I'm all done buddy. What a job! let's have a beer!"
echo "Today's: "`date`
