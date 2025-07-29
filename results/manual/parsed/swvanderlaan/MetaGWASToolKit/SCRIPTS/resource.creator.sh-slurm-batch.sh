#!/bin/bash
#FLUX: --job-name=resource.creator
#FLUX: -t=10800
#FLUX: --urgency=16

                                                                    # or ALL (equivalent to BEGIN, END, FAIL, INVALID_DEPEND, REQUEUE, and STAGE_OUT), 
                                                                    # Multiple type values may be specified in a comma separated list. 
NONE='\033[00m'
OPAQUE='\033[2m'
FLASHING='\033[5m'
BOLD='\033[1m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'
STRIKETHROUGH='\033[9m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
function echobold { #'echobold' is the function name
    echo -e "${BOLD}${1}${NONE}" # this is whatever the function needs to execute, note ${1} is the text for echo
}
function echoitalic { 
    echo -e "${ITALIC}${1}${NONE}" 
}
function echonooption { 
    echo -e "${OPAQUE}${RED}${1}${NONE}"
}
function echoerrorflash { 
    echo -e "${RED}${BOLD}${FLASHING}${1}${NONE}" 
}
function echoerror { 
    echo -e "${RED}${1}${NONE}"
}
function echoerrornooption { 
    echo -e "${YELLOW}${1}${NONE}"
}
function echoerrorflashnooption { 
    echo -e "${YELLOW}${BOLD}${FLASHING}${1}${NONE}"
}
script_copyright_message() {
	echo ""
	THISYEAR=$(date +'%Y')
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "+ The MIT License (MIT)                                                                                 +"
	echo "+ Copyright (c) 2015-${THISYEAR} Sander W. van der Laan                                                        +"
	echo "+                                                                                                       +"
	echo "+ Permission is hereby granted, free of charge, to any person obtaining a copy of this software and     +"
	echo "+ associated documentation files (the \"Software\"), to deal in the Software without restriction,         +"
	echo "+ including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, +"
	echo "+ and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, +"
	echo "+ subject to the following conditions:                                                                  +"
	echo "+                                                                                                       +"
	echo "+ The above copyright notice and this permission notice shall be included in all copies or substantial  +"
	echo "+ portions of the Software.                                                                             +"
	echo "+                                                                                                       +"
	echo "+ THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT     +"
	echo "+ NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                +"
	echo "+ NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES  +"
	echo "+ OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN   +"
	echo "+ CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                            +"
	echo "+                                                                                                       +"
	echo "+ Reference: http://opensource.org.                                                                     +"
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}
echobold "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echobold "                                      MetaGWASToolKit: Resource Creator"
echobold ""
echobold "* Version:      v1.1.3"
echobold ""
echobold "* Last update:  2022-11-01"
echobold "* Written by:   Sander W. van der Laan | s.w.vanderlaan@gmail.com."
echobold "* Testers:      Jessica van Setten; M.M.M. Baksi."
echobold "* Description:  Downloads, parses and creates the necessary resources for MetaGWASToolKit."
echobold ""
echobold "* REQUIRED: "
echobold "  - A high-performance computer cluster with a qsub system"
echobold "  - R v3.2+, Python 3.7+, Perl."
echobold "  - Required Python 3.7+ modules: [pandas], [scipy], [numpy]."
echobold "  - Required Perl modules: [YAML], [Statistics::Distributions], [Getopt::Long]."
echobold "  - Note: it will also work on a Mac OS X system with R and Python installed."
echobold ""
echobold "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	# Where GWASToolKit resides
	SOFTWARE="/hpc/local/CentOS7/dhl_ec/software"
	QCTOOL="${SOFTWARE}/qctool_v1.5"
	METAGWASTOOLKIT="${SOFTWARE}/MetaGWASToolKit"
	SCRIPTS=${METAGWASTOOLKIT}/SCRIPTS
	RESOURCES=${METAGWASTOOLKIT}/RESOURCES
	POPULATION="EUR"
	POPULATION1Gp3="EUR"
	POPULATION1Gp3GONL5="PAN"
	DBSNPVERSION="151"
	echobold "#########################################################################################################"
	echobold "### DOWNLOADING dbSNP GRCh37 v147 hg19 Feb2009"
	echobold "#########################################################################################################"
	echobold "#"
	echo ""
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "Downloading and parsing 'dbSNP GRCh37 v147 hg19 Feb2009'. "
	echo ""
	echo "* downloading [ dbSNP ] ..."
	wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/snp${DBSNPVERSION}.txt.gz -O ${RESOURCES}/dbSNP${DBSNPVERSION}_GRCh37_hg19_Feb2009.allVariants.txt.gz
	### HEAD
	### zcat dbSNP${DBSNPVERSION}_GRCh37_hg19_Feb2009.allVariants.txt.gz | head
	### 585	chr1	10019	10020	rs775809821	0	+	A	A	-/A	genomic	deletion	unknown	0	0	near-gene-5	exact	1		1	SSMP,	0
	### 585	chr1	10055	10055	rs768019142	0	+	-	-	-/A	genomic	insertion	unknown	0	0	near-gene-5	between	1		1	SSMP,	0
	### 585	chr1	10107	10108	rs62651026	0	+	C	C	C/T	genomic	single	unknown	0	0	near-gene-5	exact	1		1	BCMHGSC_JDW,	0
	echo "* parsing [ dbSNP ] ..."
	echo "Chr ChrStart ChrEnd VariantID Strand Alleles VariantClass VariantFunction" > ${RESOURCES}/dbSNP${DBSNPVERSION}_GRCh37_hg19_Feb2009.txt
	zcat ${RESOURCES}/dbSNP${DBSNPVERSION}_GRCh37_hg19_Feb2009.allVariants.txt.gz | awk '{ print $2, $3, $4, $5, $7, $10, $12, $16 }' >> ${RESOURCES}/dbSNP${DBSNPVERSION}_GRCh37_hg19_Feb2009.txt
	cat ${RESOURCES}/dbSNP${DBSNPVERSION}_GRCh37_hg19_Feb2009.txt | awk '{ print $4, $8 }' > ${RESOURCES}/dbSNP${DBSNPVERSION}_GRCh37_hg19_Feb2009.attrib.txt
	echo "gzip -fv ${RESOURCES}/dbSNP${DBSNPVERSION}_GRCh37_hg19_Feb2009.txt " > ${RESOURCES}/resource.dbSNP.parser.sh
	echo "rm -fv ${RESOURCES}/dbSNP${DBSNPVERSION}_GRCh37_hg19_Feb2009.allVariants.txt.gz " >> ${RESOURCES}/resource.dbSNP.parser.sh
	echo "gzip -vf ${RESOURCES}/dbSNP${DBSNPVERSION}_GRCh37_hg19_Feb2009.attrib.txt " >> ${RESOURCES}/resource.dbSNP.parser.sh
	qsub -S /bin/bash -N dbSNPparser -o ${RESOURCES}/resource.dbSNP.parser.log -e ${RESOURCES}/resource.dbSNP.parser.errors -l h_vmem=8G -l h_rt=01:00:00 -wd ${RESOURCES} ${RESOURCES}/resource.dbSNP.parser.sh
	echo ""	
	echo "All done submitting jobs for downloading and parsing dbSNP reference! 🖖"
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	# Note: we exclude this option, as no-one is using this anymore
	# echo ""
	# echobold "#########################################################################################################"
	# echobold "### *** WARNING *** NOT IMPLEMENTED YET DOWNLOADING HapMap 2 reference b36 hg18"
	# echobold "#########################################################################################################"
	# echobold "#"
	# echo ""
	# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	# echo "Downloading and parsing 'HapMap 2 b36 hg18'. "
	# 
	# echo ""	
	# echo "All done submitting jobs for downloading and parsing HapMap 2 reference! 🖖"
	# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo ""
	echobold "#########################################################################################################"
	echobold "### DOWNLOADING 1000G phase 1, phase 3, and phase 3 + GoNL5"
	echobold "#########################################################################################################"
	echobold "#"
	echo ""
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "Downloading and parsing '1000G phase 1 and phase 3'. "
	echo "* downloading [ 1000G phase 1 ] ..."
	# echo "* parsing 1000G phase 3."
	# echo "perl ${SCRIPTS}/resource.VCFparser.pl --file ${RESOURCES}/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf.gz --ref 1Gp3 --pop ${POPULATION1Gp3} --out ${RESOURCES}/1000Gp3v5_20130502_integrated_ALL_snv_indels_sv " > ${RESOURCES}/resource.VCFparser.1kGp3.sh
	# echo "gzip -fv ${RESOURCES}/1000Gp3v5_20130502_integrated_ALL_snv_indels_sv.${POPULATION1Gp3}.INFO.txt " >> ${RESOURCES}/resource.VCFparser.1kGp3.sh
	# echo "gzip -fv ${RESOURCES}/1000Gp3v5_20130502_integrated_ALL_snv_indels_sv.${POPULATION1Gp3}.FREQ.txt " >> ${RESOURCES}/resource.VCFparser.1kGp3.sh
	# echo "gzip -fv ${RESOURCES}/1000Gp3v5_20130502_integrated_ALL_snv_indels_sv.${POPULATION1Gp3}.FUNC.txt " >> ${RESOURCES}/resource.VCFparser.1kGp3.sh
	# qsub -S /bin/bash -N VCFparser1Gp3 -hold_jid ThousandGp3downloader -o ${RESOURCES}/resource.VCFparser.1kGp3.log -e ${RESOURCES}/resource.VCFparser.1kGp3.errors -l h_vmem=16G -l h_rt=03:00:00 -wd ${RESOURCES} ${RESOURCES}/resource.VCFparser.1kGp3.sh
	# echo ""
	# echo "* updating 1000G phase 3."
	# echo "perl ${SCRIPTS}/mergeTables.pl --file1 ${RESOURCES}/dbSNP147_GRCh37_hg19_Feb2009.attrib.txt.gz --file2 ${RESOURCES}/1000Gp3v5_20130502_integrated_ALL_snv_indels_sv.${POPULATION1Gp3}.FUNC.txt.gz --index VariantID --format GZIPB --replace > ${RESOURCES}/1000Gp3v5_20130502_integrated_ALL_snv_indels_sv.${POPULATION1Gp3}.FUNC.txt " > ${RESOURCES}/resource.VCFplusdbSNP.1kGp3.sh
	# echo "gzip -fv ${RESOURCES}/1000Gp3v5_20130502_integrated_ALL_snv_indels_sv.${POPULATION1Gp3}.FUNC.txt " >> ${RESOURCES}/resource.VCFplusdbSNP.1kGp3.sh
	# qsub -S /bin/bash -N VCF1Gp3plusdbSNP -hold_jid VCFparser1Gp3 -o ${RESOURCES}/resource.VCFplusdbSNP.1kGp3.log -e ${RESOURCES}/resource.VCFplusdbSNP.1kGp3.errors -l h_vmem=128G -l h_rt=04:00:00 -wd ${RESOURCES} ${RESOURCES}/resource.VCFplusdbSNP.1kGp3.sh
	echo ""
	echobold "#########################################################################################################"
	echobold "### DOWNLOADING GENCODE and refseq gene lists"
	echobold "#########################################################################################################"
	echobold "#"
	echo ""
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "Downloading and parsing 'GENCODE and refseq gene lists'. "
	echo "* downloading [ GENCODE ] ... "
	wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/wgEncodeGencodeBasicV41lift37.txt.gz -O ${RESOURCES}/GENCODE_wgEncodeBasicV41_GRCh37_hg19_Feb2009.txt.gz
	### HEAD
	### 585	ENST00000456328.2	chr1	+	11868	14409	11868	11868	3	11868,12612,13220,	12227,12721,14409,	0	DDX11L1	none	none	-1,-1,-1,
	### 585	ENST00000607096.1	chr1	+	30365	30503	30365	30365	1	30365,	30503,	0	MIR1302-11	none	none	-1,
	### 585	ENST00000417324.1	chr1	-	34553	36081	34553	34553	3	34553,35276,35720,	35174,35481,36081,	0	FAM138A	none	none	-1,-1,-1,
	### 585	ENST00000335137.3	chr1	+	69090	70008	69090	70008	1	69090,	70008,	0	OR4F5	cmpl	cmpl	0,
	echo "* parsing [ GENCODE ] ... "
	zcat ${RESOURCES}/GENCODE_wgEncodeBasicV41_GRCh37_hg19_Feb2009.txt.gz | awk '{ print $3, $5, $6, $13 }' | awk -F" " '{gsub(/chr/, "", $1)}1' | awk -F" " '{gsub(/X/, "23", $1)}1' | awk -F" " '{gsub(/Y/, "24", $1)}1' | awk -F" " '{gsub(/M/, "26", $1)}1' > ${RESOURCES}/gencode_v41_GRCh37_hg19_Feb2009.txt 
	mv -v ${RESOURCES}/gencode_v41_GRCh37_hg19_Feb2009.txt foo
	touch ${RESOURCES}/gencode_v41_GRCh37_hg19_Feb2009.txt
	for CHR in $(seq 1 24); do
		cat foo | awk ' $1 == '$CHR' ' >> ${RESOURCES}/gencode_v41_GRCh37_hg19_Feb2009.txt
	done
	rm -fv ${RESOURCES}/GENCODE_wgEncodeBasicV41_GRCh37_hg19_Feb2009.txt.gz foo
	echo "* downloading [ refseq ] ... "
	wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/refGene.txt.gz -O ${RESOURCES}/refGene_GRCh37_hg19_Feb2009.txt.gz
	### HEAD
	### 585	NR_046018	chr1	+	11873	14409	14409	14409	3	11873,12612,13220,	12227,12721,14409,	0	DDX11L1	unk	unk	-1,-1,-1,
	### 585	NR_024540	chr1	-	14361	29370	29370	29370	11	14361,14969,15795,16606,16857,17232,17605,17914,18267,24737,29320,	14829,15038,15947,16765,17055,17368,17742,18061,18366,24891,29370,	0	WASH7P	unk	unk	-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
	echo "* parsing [ refseq ] ... "
	zcat ${RESOURCES}/refGene_GRCh37_hg19_Feb2009.txt.gz | awk '{ print $3, $5, $6, $13 }' | awk -F" " '{gsub(/chr/, "", $1)}1' | awk -F" " '{gsub(/X/, "23", $1)}1' | awk -F" " '{gsub(/Y/, "24", $1)}1' > ${RESOURCES}/refseq_GRCh37_hg19_Feb2009.txt
	mv -v ${RESOURCES}/refseq_GRCh37_hg19_Feb2009.txt foo
	touch ${RESOURCES}/refseq_GRCh37_hg19_Feb2009.txt
	for CHR in $(seq 1 24); do
		cat foo | awk ' $1 == '$CHR' ' >> ${RESOURCES}/refseq_GRCh37_hg19_Feb2009.txt
	done
	rm -fv ${RESOURCES}/refGene_GRCh37_hg19_Feb2009.txt.gz foo 
	echo ""	
	echo "All done submitting jobs for downloading and parsing gene lists! 🖖"
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  # NOTE: THE URLs ARE NOT 'LIVE' ANYMORE
  # We retain here the recombination rates from HapMap2 and 1000G phase 1 era.
	# echo ""
	# echobold "#########################################################################################################"
	# echobold "### DOWNLOADING Recombination Maps for b37"
	# echobold "#########################################################################################################"
	# echobold "#"
	# echo ""
	# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	# echo "Downloading and parsing 'Recombination Maps'. "
	# ### http://www.shapeit.fr/files/genetic_map_b37.tar.gz
	# ### http://hapmap.ncbi.nlm.nih.gov/downloads/recombination/2008-03_rel22_B36/rates
	# # wget http://www.shapeit.fr/files/genetic_map_b37.tar.gz -O ${RESOURCES}/genetic_map_b37.tar.gz
	# # tar -zxvf ${RESOURCES}/genetic_map_b37.tar.gz
	# # mv -v ${RESOURCES}/genetic_map_b37 ${RESOURCES}/RECOMB_RATES 
	# echo ""	
	# echo "All done submitting jobs for downloading and parsing Recombination Maps! 🖖"
	# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo ""
  echobold "#########################################################################################################"
  echobold "### DOWNLOADING LD-Hub reference variants"
  echobold "#########################################################################################################"
  echobold "#"
  echo ""
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo "Downloading and parsing 'LD-Score reference variant list'. "
  wget https://data.broadinstitute.org/alkesgroup/LDSCORE/w_hm3.snplist.bz2 -O ${RESOURCES}/w_hm3.noMHC.snplist.zip
  echo "snpid A1 A2" > ${RESOURCES}/w_hm3.noMHC.snplist.txt
  bunzip2 w_hm3.snplist.bz2 | tail -n +2 >> ${RESOURCES}/w_hm3.noMHC.snplist.txt
  gzip -fv ${RESOURCES}/w_hm3.noMHC.snplist.txt
  echo ""
  echo "All done submitting jobs for downloading and parsing LD-Score reference variant list! 🖖"
  echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
script_copyright_message
