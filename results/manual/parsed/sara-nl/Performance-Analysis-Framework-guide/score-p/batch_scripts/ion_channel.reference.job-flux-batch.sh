#!/bin/bash
#FLUX: --job-name=expensive-snack-7810
#FLUX: --priority=16

export GROMACSINSTALLDIR='/home/$USER/gromacs-2019.3/install'
export GROMACSTESTCASEDIR='/home/$USER/gromacs_testcase'
export NNODES='$SLURM_JOB_NUM_NODES'
export NPROC='$SLURM_NTASKS'
export NTHREADS='$SLURM_CPUS_PER_TASK'
export TESTCASE='ion_channel'
export INPUTFILENAME='ion_channel.tpr'
export RESULTDIR='${SLURM_SUBMIT_DIR}/${SLURM_JOB_ID}_gromacs_$TESTCASE_${NNODES}N_${NPROC}P_${NTHREADS}T'
export WORKDIR='/scratch-shared/${USER}/${SLURM_JOB_ID}'

module load 2019
module load foss/2018b
export GROMACSINSTALLDIR=/home/$USER/gromacs-2019.3/install
export GROMACSTESTCASEDIR=/home/$USER/gromacs_testcase
export NNODES=$SLURM_JOB_NUM_NODES
export NPROC=$SLURM_NTASKS
export NTHREADS=$SLURM_CPUS_PER_TASK
export TESTCASE=ion_channel
export INPUTFILENAME=ion_channel.tpr
export RESULTDIR=${SLURM_SUBMIT_DIR}/${SLURM_JOB_ID}_gromacs_$TESTCASE_${NNODES}N_${NPROC}P_${NTHREADS}T
export WORKDIR=/scratch-shared/${USER}/${SLURM_JOB_ID}
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
OMP_NUM_THREADS=$NTHREADS \
srun -N $NNODES -n $NPROC gmx_mpi mdrun \
    -s ${INPUTFILENAME} -maxh 0.50 -resethway -noconfout -nsteps 10000 \
    -g ${SLURM_JOB_ID}_gromacs_${TESTCASE}_${NNODES}N_${NPROC}P_${NTHREADS}T.log \
&> ${SLURM_JOB_ID}_stdouterr_gromacs_${TESTCASE}_${NNODES}N_${NPROC}P_${NTHREADS}T.log
mkdir ${RESULTDIR}
cp -r ${SLURM_JOB_ID}_*  ${RESULTDIR}
