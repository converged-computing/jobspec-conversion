#!/bin/bash
#FLUX: --job-name=gromacs
#FLUX: -N=2
#FLUX: -n=16
#FLUX: -c=4
#FLUX: --queue=broadwell
#FLUX: -t=3600
#FLUX: --urgency=16

export GROMACSINSTALLDIR='/home/$USER/gromacs-2019.3/install'
export GROMACSTESTCASEDIR='/home/$USER/gromacs_testcase'
export NNODES='$SLURM_JOB_NUM_NODES'
export NPROC='$SLURM_NTASKS'
export NTHREADS='$SLURM_CPUS_PER_TASK'
export TESTCASE='ion_channel'
export INPUTFILENAME='ion_channel.tpr'
export RESULTDIR='${SLURM_SUBMIT_DIR}/${SLURM_JOB_ID}_gromacs_ipm_$TESTCASE_${NNODES}N_${NPROC}P_${NTHREADS}T'
export WORKDIR='/scratch-shared/${USER}/${SLURM_JOB_ID}'
export IPM_REPORT='full'
export IPM_LOGDIR='$RESULTDIR'
export IPM_HPM='$PAPI_METRICS'

module load 2019
module load foss/2018b
module load IPM/2.0.6-foss-2018b
export GROMACSINSTALLDIR=/home/$USER/gromacs-2019.3/install
export GROMACSTESTCASEDIR=/home/$USER/gromacs_testcase
export NNODES=$SLURM_JOB_NUM_NODES
export NPROC=$SLURM_NTASKS
export NTHREADS=$SLURM_CPUS_PER_TASK
export TESTCASE=ion_channel
export INPUTFILENAME=ion_channel.tpr
export RESULTDIR=${SLURM_SUBMIT_DIR}/${SLURM_JOB_ID}_gromacs_ipm_$TESTCASE_${NNODES}N_${NPROC}P_${NTHREADS}T
export WORKDIR=/scratch-shared/${USER}/${SLURM_JOB_ID}
set -x
mkdir ${RESULTDIR}
mkdir -p $WORKDIR
cp ${GROMACSINSTALLDIR}/bin/gmx_mpi ${GROMACSTESTCASEDIR}/${INPUTFILENAME} ${WORKDIR}
cd $WORKDIR
echo "========================================================="
echo "Using gromacs executable ${GROMACSINSTALLDIR}/bin/gmx_mpi"
echo "on test case ${TESTCASE} (input file ${INPUTFILENAME}) located in ${GROMACSTESTCASEDIR}"
echo "The test will run in ${WORKDIR}"
echo "and the output will be copied to ${RESULTDIR}"
echo "========================================================="
echo "Running testcase ${TESTCASE} on ${NNODES} nodes / ${NPROC} MPI processes / ${NTHREADS} OpenMP threads per process"
echo "========================================================="
echo ""
export IPM_REPORT=full
export IPM_LOGDIR=$RESULTDIR
COUNT=``
if [ `echo $PAPI_METRICS | wc -m` == 1 ]
then
  export PAPI_METRICS="PAPI_TOT_INS,PAPI_TOT_CYC,PAPI_REF_CYC,PAPI_SP_OPS,PAPI_DP_OPS,PAPI_VEC_SP,PAPI_VEC_DP"
fi
export IPM_HPM=$PAPI_METRICS
OMP_NUM_THREADS=$NTHREADS \
srun -N $NNODES -n $NPROC gmx_mpi mdrun \
    -s ${INPUTFILENAME} -maxh 0.50 -resethway -noconfout -nsteps 10000 \
    -g ${SLURM_JOB_ID}_gromacs_ipm_${TESTCASE}_${NNODES}N_${NPROC}P_${NTHREADS}T.log \
&> ${SLURM_JOB_ID}_stdouterr_gromacs_ipm_${TESTCASE}_${NNODES}N_${NPROC}P_${NTHREADS}T.log
cp -r ${SLURM_JOB_ID}_*  ${RESULTDIR}
