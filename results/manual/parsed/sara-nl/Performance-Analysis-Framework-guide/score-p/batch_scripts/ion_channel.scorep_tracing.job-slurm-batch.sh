#!/bin/bash
#FLUX: --job-name=gromacs-scorep
#FLUX: -N=2
#FLUX: -n=16
#FLUX: -c=4
#FLUX: --queue=broadwell
#FLUX: -t=14400
#FLUX: --urgency=16

export GROMACSINSTALLDIR='/home/$USER/gromacs-2019.3/install_scorep'
export GROMACSTESTCASEDIR='/home/$USER/gromacs_testcase'
export NNODES='$SLURM_JOB_NUM_NODES'
export NPROC='$SLURM_NTASKS'
export NTHREADS='$SLURM_CPUS_PER_TASK'
export TESTCASE='ion_channel'
export INPUTFILENAME='ion_channel.tpr'
export RESULTDIR='${SLURM_SUBMIT_DIR}/${SLURM_JOB_ID}_gromacs_$TESTCASE_${NNODES}N_${NPROC}P_${NTHREADS}T_scorep_tracing'
export WORKDIR='/scratch-shared/${USER}/${SLURM_JOB_ID}'
export FILTERFILENAME='scorep-gromacs.filt'
export SCOREP_PROFILING='true'
export SCOREP_TRACING='true'
export SCOREP_MEM='1GB'

module load 2019
module load foss/2018b
export GROMACSINSTALLDIR=/home/$USER/gromacs-2019.3/install_scorep
export GROMACSTESTCASEDIR=/home/$USER/gromacs_testcase
export NNODES=$SLURM_JOB_NUM_NODES
export NPROC=$SLURM_NTASKS
export NTHREADS=$SLURM_CPUS_PER_TASK
export TESTCASE=ion_channel
export INPUTFILENAME=ion_channel.tpr
export RESULTDIR=${SLURM_SUBMIT_DIR}/${SLURM_JOB_ID}_gromacs_$TESTCASE_${NNODES}N_${NPROC}P_${NTHREADS}T_scorep_tracing
export WORKDIR=/scratch-shared/${USER}/${SLURM_JOB_ID}
export FILTERFILENAME=scorep-gromacs.filt
export SCOREP_PROFILING=true
export SCOREP_TRACING=true
export SCOREP_MEM="1GB"
if [ `echo $PAPI_METRICS | wc -m` == 1 ]
then
  export PAPI_METRICS="PAPI_TOT_INS,PAPI_TOT_CYC,PAPI_REF_CYC,PAPI_SP_OPS,PAPI_DP_OPS,PAPI_VEC_SP,PAPI_VEC_DP"
fi
mkdir -p $WORKDIR
cp ${GROMACSINSTALLDIR}/bin/gmx_mpi ${GROMACSTESTCASEDIR}/${INPUTFILENAME} ${WORKDIR}
cp ${GROMACSTESTCASEDIR}/${FILTERFILENAME} ${WORKDIR}
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
SCOREP_ENABLE_TRACING=${SCOREP_TRACING} \
SCOREP_TOTAL_MEMORY=${SCOREP_MEM} \
SCOREP_FILTERING_FILE=${FILTERFILENAME} \
SCOREP_METRIC_PAPI=${PAPI_METRICS} \
SCOREP_ENABLE_PROFILING=${SCOREP_PROFILING} \
SCOREP_EXPERIMENT_DIRECTORY=${SLURM_JOB_ID}_gromacs_${TESTCASE}_${NNODES}N_${NPROC}P_${NTHREADS}T_scorep_tracing \
OMP_NUM_THREADS=$NTHREADS \
srun -N $NNODES -n $NPROC gmx_mpi mdrun \
    -s ${INPUTFILENAME} -maxh 0.50 -resethway -noconfout -nsteps 10000 \
    -g ${SLURM_JOB_ID}_gromacs_${TESTCASE}_${NNODES}N_${NPROC}P_${NTHREADS}T_scorep_tracing.log \
&> ${SLURM_JOB_ID}_stdouterr_gromacs_${TESTCASE}_${NNODES}N_${NPROC}P_${NTHREADS}T_scorep_tracing.log
mkdir ${RESULTDIR}
cp -r ${SLURM_JOB_ID}_*  ${RESULTDIR}
