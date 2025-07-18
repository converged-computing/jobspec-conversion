#!/bin/bash
#FLUX: --job-name=cB211.072.64_n64mpi16nt3_ndcloverratcor_ddalphaamg_intel_2021_4_0_intelmpi_mpirun_threadpin_close
#FLUX: -N=64
#FLUX: -c=3
#FLUX: --exclusive
#FLUX: -t=28800
#FLUX: --urgency=16

export OMP_NUM_THREADS='3'
export OMP_PROC_BIND='close'
export OMP_PLACES='cores'
export I_MPI_PIN_RESPECT_CPUSET='no'
export I_MPI_PIN='yes'
export I_MPI_PIN_DOMAIN='omp'
export I_MPI_DEBUG='4'

echo "Report: Slurm Configuration"
echo "Job ID: ${SLURM_JOBID}"
echo "Node list: ${SLURM_JOB_NODELIST}"
echo "Node cabinets and electric groups"
scontrol show nodes ${SLURM_JOB_NODELIST} | grep -i activefeatures | sort -u
bdir=$SCRATCH_fssh/kostrzewa2/bonna-2-benchmarks-testing/LQCD/MPP-benchmark-intel
exe=${bdir}/build/tmLQCD/hmc_tm
source ${bdir}/load_modules_skylake_avx512_intel2021_4_0_intelmpi.sh
module list
ulimit -c 0
echo `date`
export OMP_NUM_THREADS=3
export OMP_PROC_BIND=close
export OMP_PLACES=cores
export I_MPI_PIN_RESPECT_CPUSET=no
export I_MPI_PIN=yes
export I_MPI_PIN_DOMAIN=omp
export I_MPI_DEBUG=4
echo '1 1 conf.start' > nstore_counter
echo '# ndcloverrat3 ndcloveratcor ddalphaamg' >> output.data
srun ${exe} -f hmc_64n_16ppn_3tpt_cB211.072.64_ndcloverratcor_ddalphaamg.input
