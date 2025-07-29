#!/bin/bash
#FLUX: --job-name=step2-saige
#FLUX: -c=4
#FLUX: --queue=short
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo "SGE job ID: "$SLURM_JOB_ID
echo "SGE task ID: 66"
echo "Running on host: "$SLURM_JOB_NODELIST
echo "Output file: "$SLURM_JOB_NAME".o"$SLURM_JOB_ID".66"
echo "Script argument: "$1 $2 $3 $5
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
STEM=$1
WDIR=$2/saige
UKBDEDIR=$3
UKBDIR=$4
SAIGEDIR=$5
SAMP=${UKBDEDIR}/ukb41482.imp.bgen.eid.txt
GMMAT=${WDIR}/step1.${STEM}.rda
VARRAT=${WDIR}/step1.${STEM}.varianceRatio.txt
OUT=${WDIR}/${STEM}.batch66.temp.txt
OUTGZ=${OUT}.gz
OUTSUM=${OUT}.sum.gz
TMP=/well/bag/clme1992/tmp
BATCH=${UKBDEDIR}/batch/batch66.v3.txt
SCHR=`cut -f1 $BATCH`
CHR=`expr ${SCHR} + 0`
XCHR="X"
PAR1="PAR1"
if [ "$SCHR" = "$XCHR" ]; then
	CHR="X"
	SAMP=${UKBDEDIR}/ukb41482.imp-X.bgen.eid.txt
fi
if [ "$SCHR" = "$PAR1" ]; then
	CHR="XY"
	SAMP=${UKBDEDIR}/ukb41482.imp-XY.bgen.eid.txt
fi
echo "Chromosome names, internal ${SCHR} and filename ${CHR}"
BGEN=${UKBDIR}/v3/imputation/ukb_imp_chr${CHR}_v3.bgen
cd $WDIR
if [ "$SCHR" = "$PAR1" ]; then
	time singularity run -B ${UKBDEDIR} -B ${UKBDIR} -B ${WDIR} step2_SPAtests.R  --bgenFile=$BGEN  --bgenFileIndex=${BGEN}.bgi  --minMAF=0  --minMAC=0  --sampleFile=$SAMP  --GMMATmodelFile=$GMMAT  --varianceRatioFile=$VARRAT  --SAIGEOutputFile=$OUT  --numLinesOutput=100  --IsOutputAFinCaseCtrl=TRUE --chrom=${CHR} --LOCO=FALSE
elif [ "$SCHR" = "$XCHR" ]; then
	time singularity run -B ${UKBDEDIR} -B ${UKBDIR} -B ${WDIR}  ${SAIGEDIR} step2_SPAtests.R  --bgenFile=$BGEN  --bgenFileIndex=${BGEN}.bgi  --rangestoIncludeFile=$BATCH  --minMAF=0  --minMAC=0  --sampleFile=$SAMP  --GMMATmodelFile=$GMMAT  --varianceRatioFile=$VARRAT  --SAIGEOutputFile=$OUT  --numLinesOutput=100  --IsOutputAFinCaseCtrl=TRUE --chrom=${CHR} --LOCO=FALSE
else
	time singularity run -B ${UKBDEDIR} -B ${UKBDIR} -B ${WDIR}  ${SAIGEDIR} step2_SPAtests.R  --bgenFile=$BGEN  --bgenFileIndex=${BGEN}.bgi  --rangestoIncludeFile=$BATCH  --minMAF=0  --minMAC=0  --sampleFile=$SAMP  --GMMATmodelFile=$GMMAT  --varianceRatioFile=$VARRAT  --SAIGEOutputFile=$OUT  --numLinesOutput=100  --IsOutputAFinCaseCtrl=TRUE --chrom=${CHR}
fi
ONE="1"
if [ "66" = "$ONE" ]; then
	cut -f1,2,3,7,13 -d' ' $OUT | tail -n +1 | gzip > $OUTSUM
	cat $OUT | tail -n +1 | gzip > $OUTGZ
else
	cut -f1,2,3,7,13 -d' ' $OUT | tail -n +2 | gzip > $OUTSUM
	cat $OUT | tail -n +2 | gzip > $OUTGZ
fi
rm -f $OUT
