#!/bin/bash
#FLUX: --job-name=Unbias401
#FLUX: -c=7
#FLUX: -t=86400
#FLUX: --urgency=16

export KMP_BLOCKTIME='0'
export KMP_HW_SUBSET='1T'
export KMP_AFFINITY='verbose,compact,1,0,granularity=fine'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export SCRATCH='${SCRATCHDIR}/wd-${SLURM_JOB_ID}'
export LAMMPS_DIR='${SCRATCHDIR}/apps/lammps/src'
export DIR='$(dirname `pwd`/$0)'

module load intel/19.4 intelmpi/2019.4.243 gcc/8.3.0 idb/19.4 hwloc/1.11.0 automake/1.14 cmake/3.9.0
source /opt/software/common/intel/compilers_and_libraries_2019.4.243/linux/tbb/bin/tbbvars.sh intel64
export KMP_BLOCKTIME=0
export KMP_HW_SUBSET=1T
export KMP_AFFINITY=verbose,compact,1,0,granularity=fine
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "THREADS: $SLURM_CPUS_PER_TASK"
ulimit -s unlimited
cycles=11
nn=0
file=start.lmp
export SCRATCH=${SCRATCHDIR}/wd-${SLURM_JOB_ID}
export LAMMPS_DIR=${SCRATCHDIR}/apps/lammps/src
export DIR=$(dirname `pwd`/$0)
echo "[..go] $SLURM_JOB_ID $SCRATCH $DIR [${SLURM_NTASKS}]" >> $HOME/slurm.log
echo "Creating temporal directory: ${SCRATCH}"
echo "[ from ${DIR}, cycle ${nn} ]"
mkdir -p $SCRATCH || exit $?
echo "Copying files"
cp -ra $SLURM_SUBMIT_DIR/*  $SCRATCH || exit $?
sleep 0.5
cd $SCRATCH
 time srun ${LAMMPS_DIR}/lmp_intel_cpu_intelmpi -in ${file} > log 2>&1
 wait 10 
cd $SLURM_SUBMIT_DIR
sleep 0.5
cp -ra ${SCRATCH}/*  ${SLURM_SUBMIT_DIR} || exit $?
sleep 0.5
echo "Removing $SCRATCH"
rm -rf $SCRATCH || exit $?
echo "[done] $SLURM_JOB_ID $SCRATCH" >> $HOME/slurm.log
exit 0
