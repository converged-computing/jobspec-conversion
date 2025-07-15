#!/bin/bash
#FLUX: --job-name=mpi_patient
#FLUX: -N=2
#FLUX: -n=64
#FLUX: --queue=all
#FLUX: --priority=16

export OMP_PLACES='cores     '
export OMP_PROC_BIND='close'

module reset
module load devel/CMake
module load toolchain/gompi
module load numlib/FFTW
export OMP_PLACES=cores     
export OMP_PROC_BIND=close
outdir="../data/patient/mpi2nodes/result"
wisdir="../wisdom/mpi2nodes"
iter=100
batch=1
echo "SLURM_JOB_ID = $SLURM_JOB_ID"
echo "N         : $@"
echo "Threads per process   : 1"
echo "Processes : $SLURM_NTASKS"
echo "Iter   : ${iter}"
echo "Batch  : ${batch}"
echo ""
echo "Passed $# FFT3d Sizes"
for arg in "$@"
do
  echo "FFT Size : $arg $arg $arg"
  for thread in {1..1}
  do
    echo "Running with number of threads : $thread"
    outfile="${outdir}/fftw_${arg}_p64_t${thread}_b${batch}.log"
    wisdomfile="${wisdir}/fftw_${arg}_p64_t${thread}_b${batch}.patient"
    echo "Writing to file : ${outfile}"
    #srun ../build/hybrid_many --num=$arg -i ${iter} -t ${thread} --batch=${batch} --wisdomfile=${wisdomfile} > ${outfile}
    mpirun --map-by ppr:16:socket --bind-to socket ../build/hybrid_many --num=$arg -i ${iter} -t ${thread} --batch=${batch} --wisdomfile=${wisdomfile} > ${outfile}
  done
done
