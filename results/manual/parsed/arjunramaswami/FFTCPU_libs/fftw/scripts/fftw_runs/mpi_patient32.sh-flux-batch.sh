#!/bin/bash
#FLUX: --job-name=mpi_patient
#FLUX: -N=8
#FLUX: -n=32
#FLUX: --queue=long
#FLUX: --priority=16

module reset
module load devel/CMake
module load toolchain/gompi
module load numlib/FFTW
outdir="../data/patient/mpi4nodes/result"
wisdir="../wisdom/mpi4nodes"
iter=100
batch=1
echo "SLURM_JOB_ID = $SLURM_JOB_ID"
echo "N         : $@"
echo "Threads per process   : 4"
echo "Processes : $SLURM_NTASKS"
echo "Iter   : ${iter}"
echo "Batch  : ${batch}"
echo ""
echo "Passed $# FFT3d Sizes"
for arg in "$@"
do
  echo "FFT Size : $arg $arg $arg"
  for thread in {4..4}
  do
    echo "Running with number of threads : $thread"
    outfile="${outdir}/fftw_${arg}_p32_t${thread}_b${batch}.log"
    wisdomfile="${wisdir}/fftw_${arg}_p32_t${thread}_b${batch}.patient"
    echo "Writing to file : ${outfile}"
    #srun ../build/hybrid_many --num=$arg -i ${iter} -t ${thread} --batch=${batch} --wisdomfile=${wisdomfile} > ${outfile}
    mpirun --map-by ppr:4:socket --bind-to socket --report-bindings ../build/hybrid_many --num=$arg -i ${iter} -t ${thread} --batch=${batch} --wisdomfile=${wisdomfile} > ${outfile}
  done
done
