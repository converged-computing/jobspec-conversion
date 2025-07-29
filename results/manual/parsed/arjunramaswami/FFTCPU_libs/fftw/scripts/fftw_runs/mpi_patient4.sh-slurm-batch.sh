#!/bin/bash
#SBATCH --job-name=mpi_patient
#SBATCH --account=pc2-mitarbeiter
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=2

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
iter=10
batch=1
echo "SLURM_JOB_ID = $SLURM_JOB_ID"
echo "N         : $@"
echo "Threads per process   : 16"
echo "Processes : $SLURM_NTASKS"
echo "Iter   : ${iter}"
echo "Batch  : ${batch}"
echo ""
echo "Passed $# FFT3d Sizes"
for arg in "$@"
do
  echo "FFT Size : $arg $arg $arg"
  for thread in {16..16}
  do
    echo "Running with number of threads : $thread"
    outfile="${outdir}/fftw_${arg}_p4_t${thread}_b${batch}.log"
    wisdomfile="${wisdir}/fftw_${arg}_p4_t${thread}_b${batch}.patient"
    echo "Writing to file : ${outfile}"
    #srun ../build/hybrid_many --num=$arg -i ${iter} -t ${thread} --batch=${batch} --wisdomfile=${wisdomfile} > ${outfile}
    #mpirun --map-by ppr:1:socket --bind-to socket --report-bindings ../build/hybrid_many --num=$arg -i ${iter} -t ${thread} --batch=${batch} --wisdomfile=${wisdomfile} > ${outfile}
    mpirun --map-by ppr:1:socket --bind-to socket --report-bindings ../debug/hybrid_many --num=$arg -i ${iter} -t ${thread} --batch=${batch} --wisdomfile=${wisdomfile}
  done
done
