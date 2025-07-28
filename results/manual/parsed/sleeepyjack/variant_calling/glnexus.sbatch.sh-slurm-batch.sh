#!/bin/bash
#FLUX: --job-name=glnexus
#FLUX: --exclusive
#FLUX: --queue=nodelong
#FLUX: -t=360000
#FLUX: --urgency=16

set -e
GVCFDIR=$1
OUTDIR=glnexus_output
JOBDIR=/localscratch/${SLURM_JOB_ID}
echo "##################"
echo "#### GLNexus on MOGON"
echo "#### JOB ID:" ${SLURM_JOB_ID}
echo "#### NODE:" $(hostname)
echo "#### CORES:" $(nproc)
echo "#### INPUT DIRECTORY:" ${GVCFDIR}
echo "#### OUTPUT DIRECTORY:" ${OUTDIR}
echo "##################"
module load tools/Singularity/3.5.2-Go-1.13.1
module load tools/parallel/20190822
mkdir -p ${JOBDIR}/tmp
LOCAL_GVCFDIR=${JOBDIR}/gvcf
mkdir -p ${LOCAL_GVCFDIR}
find ${GVCFDIR}/ -type f -name "*.gvcf" -print0 | parallel -0 -j$(nproc) cp {} ${LOCAL_GVCFDIR}/
find ${LOCAL_GVCFDIR}/ -type f -name "*.gvcf" >> $JOBDIR/gvcf_list
echo "cd /tmp && LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so numactl --interleave=all glnexus_cli --config DeepVariantWGS --list $JOBDIR/gvcf_list | bcftools view - | bgzip -@ $(nproc) -c > $JOBDIR/output.cohort.vcf.gz" >> $JOBDIR/cmd.sh
cat $JOBDIR/cmd.sh
chmod +x $JOBDIR/cmd.sh
singularity exec \
    -B ${JOBDIR} \
    -B ${JOBDIR}/tmp:/tmp \
    environment.cpu.sif \
    $JOBDIR/cmd.sh
mkdir -p ${OUTDIR}
cp ${JOBDIR}/output.cohort.vcf.gz ${OUTDIR}/
