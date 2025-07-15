#!/bin/bash
#FLUX: --job-name=fftw_openmp
#FLUX: --queue=long
#FLUX: --urgency=16

module reset
module load toolchain/intel/2021a
ITER=200
BATCH=1
OUTDIR="../../data/singlenodeicc_test1"
echo "SLURM_JOB_ID : $SLURM_JOB_ID"
echo "Iter         : ${ITER}"
echo "Batch        : ${BATCH}"
echo ""
fftsize=(256 512)
for arg in ${fftsize[@]}
do
  echo "FFT Size      : $arg $arg $arg"
  for THREAD in {1..40}
  do
    echo "Thread       : ${THREAD}"
    mkdir -p ${OUTDIR}/${arg}
    OUTFILE="${OUTDIR}/${arg}/mkl_${arg}_t${THREAD}_b${BATCH}.log"
    echo "Output path    : ${OUTFILE}"
    KMP_AFFINITY=granularity=core,compact ../../iccbuild/mkl_openmp_many --num=$arg -i ${ITER} -t ${THREAD} --expm=1 --batch=${BATCH} > ${OUTFILE}
  done
done
