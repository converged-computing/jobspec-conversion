#!/bin/bash
#FLUX: --job-name=moolicious-truffle-2283
#FLUX: --queue=batch
#FLUX: -t=21600
#FLUX: --urgency=16

module load kallisto/0.43.1-foss-2016b
module load SAMtools/1.3.1-foss-2016b
IDX=/data/biorefs/reference_genomes/ensembl-release-96/danio_rerio/kallisto/Danio_rerio.GRCz11.96.cdna.primary_assembly.with_unspliced_genes.idx
PROJROOT=/fast/users/a1647910/20190122_Q96K97_NoStress_RNASeq
TRIMDATA=${PROJROOT}/1_trimmedData
ALIGNDATA=${PROJROOT}/3_kallisto
F1=$1
F2=${F1%_1.fq.gz}_2.fq.gz
OUTDIR=${ALIGNDATA}/$(basename ${F1%_1.fq.gz})
echo -e "Creating ${OUTDIR}"
mkdir -p ${OUTDIR}
OUTBAM=${OUTDIR}/$(basename ${F1%_1.fq.gz}.bam)
echo -e "Currently aligning:\n\t${F1}\n\t${F2}"
echo -e "Output will be written to ${OUTDIR}"
echo -e "Bam file will be ${OUTBAM}"
kallisto quant \
	-b 50 \
	--pseudobam \
	--rf-stranded \
	-i ${IDX} \
	-o ${OUTDIR} \
	${F1} ${F2} | \
	samtools view -F4 -bS - > ${OUTBAM}
