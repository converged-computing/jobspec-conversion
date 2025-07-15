#!/bin/bash
#FLUX: --job-name=fly-kine-compensation
#FLUX: -n=80
#FLUX: -t=18000
#FLUX: --urgency=16

export MAKEFLAGS='-j8'
export HDF_ROOT='/gpfslocalsup/spack_soft/hdf5/1.10.5/intel-19.0.4-lnysdcbocfokaq4yxc72wiplpfknw7e6'

set -x
cd ${SLURM_SUBMIT_DIR}
module purge
module load hdf5/1.10.5/intel-19.0.4-mpi intel-mpi/19.0.4 intel-mkl/19.0.4
module load intel-compilers/19.0.4 intel-all/19.0.4
export MAKEFLAGS="-j8"
export HDF_ROOT=/gpfslocalsup/spack_soft/hdf5/1.10.5/intel-19.0.4-lnysdcbocfokaq4yxc72wiplpfknw7e6
RUN="srun"
INIFILE="PARAMS.ini"
MEMORY="384.0GB"
AUTO_RESUB=1
MAX_RESUB=20
JOBFILE="jobwabbit.sh"
simulation_watchdog.py --ID=${BRIDGE_MSUB_JOBID} --dir=${BRIDGE_MSUB_PWD} --jobfile=${JOBFILE} &
${RUN} ./wabbit ${INIFILE} --memory=${MEMORY}
if [ "$AUTO_RESUB" == "1" ]; then
	automatic_resubmission.sh "$JOBFILE" "$INIFILE" "$MAX_RESUB"
fi
