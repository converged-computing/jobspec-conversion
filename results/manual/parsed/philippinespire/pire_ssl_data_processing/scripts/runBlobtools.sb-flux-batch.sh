#!/bin/bash
#FLUX: --job-name=blob
#FLUX: --priority=16

export SINGULARITY_BIND='/home/e1garcia'

enable_lmod
module load container_env/0.1
module load busco/5.0.0
module load container_env blobtoolkit
export SINGULARITY_BIND=/home/e1garcia
blobDIR=$1	# directory were BLAST and BWA were previously ran
plotDIR=$2	# ourdir
ASSEM=$3	# assembly file
filtBAM=$4	# filt.bam files previously created by BWA
BUSCOdir=$5	# BUSCO dir with results for your assembly
if [[ blobDIR="." ]]
then
	blobDIR=$PWD
else
	blobDIR=$(echo $blobDIR | sed 's/\/$//')
fi
plotDIR=$(echo $plotDIR | sed 's/\/$//')
BUSCOdir=$(echo $BUSCOdir | sed 's/\/$//')
echo -e "\nRunning Blobtools create, and adding blast hits, taxonomy, busco and coverage\n"
echo -e "blobDIR=$blobDIR"
echo -e "plotDIR=plotDIR"
echo -e "ASSEM=$ASSEM"
echo -e "fltrBAM=$flterBAM"
echo -e "BUSCOdir=$BUSCOdir"
echo -e "\nRunning Blobtools create\n"
crun blobtools create \
	--fasta $ASSEM \
	${plotDIR}
echo -e "\nRunning Blobtools add --hits, --taxdump, --taxrule\n"
crun blobtools add \
 	--hits ${blobDIR}/blastn.out \
	--taxdump /home/e1garcia/shotgun_PIRE/denovo_genome_assembly/Blobtools/taxdump \
	--taxrule bestsumorder \
	${plotDIR}
echo -e "\nRunning Blobtools add --busco\n"
crun blobtools add \
	--busco	${BUSCOdir}/run_actinopterygii_odb10/full_table.tsv \
	${plotDIR}
echo -e "\nRunning Blobtools add --cov\n"
crun blobtools add \
	--cov ${blobDIR}/${filtBAM} \
	${plotDIR}
