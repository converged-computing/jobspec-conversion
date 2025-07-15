#!/bin/bash
#FLUX: --job-name=urumqi
#FLUX: -c=10
#FLUX: --priority=16

export DYLD_FALLBACK_LIBRARY_PATH='${PROG_ROOTDIR}:${DYLD_FALLBACK_LIBRARY_PATH}	#for osX'
export LD_LIBRARY_PATH='${PROG_ROOTDIR}:${LD_LIBRARY_PATH}	#for Linux'

PARALLEL=N
MACHINEFILE=
NPROC=8
NCORES=2
BEGIN="2001-10-02T01:00"
END="2013-10-01T01:00"
PROG_ROOTDIR=../bin	#if you do not want to use Alpine3D from PATH, then point to where it is
REDIRECT_LOGS=Y
export DYLD_FALLBACK_LIBRARY_PATH=${PROG_ROOTDIR}:${DYLD_FALLBACK_LIBRARY_PATH}	#for osX
export LD_LIBRARY_PATH=${PROG_ROOTDIR}:${LD_LIBRARY_PATH}	#for Linux
EXE="${PROG_ROOTDIR}/alpine3d"
if [ ! -f ${EXE} ]; then
	EXE=`which alpine3d`
fi
N_EB=1
N_SN=1
if [ "${PARALLEL}" == "MPI" ]; then
	echo "Running with MPI"
	MPIEXEC=${MPIEXEC:="mpiexec"}
	MFILE=${MACHINEFILE:+"-machinefile ${MACHINEFILE}"}
	EXE="${MPIEXEC} -n ${NPROC} ${MFILE} ${EXE}"
	N_EB=1
	N_SN=1
elif [ "${PARALLEL}" == "MPI_SGE" ]; then
	echo "Running with MPI under SGE"
        MPIEXEC=${MPIEXEC:="mpiexec"}
        if [ $SLURM_TASKS_PER_NODE ]; then
        	export NSLOTS=$SLURM_TASKS_PER_NODE
        fi
        EXE="${MPIEXEC} -np ${NSLOTS} ${EXE}"
        N_EB=1
        N_SN=1
elif [ "${PARALLEL}" == "OPENMP" ]; then
	echo "Running with OPENMP"
	if [ $SLURM_CPUS_PER_TASK ]; then
		export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
	else
		export OMP_NUM_THREADS=${NSLOTS:=$NCORES}
	fi
	N_EB=$OMP_NUM_THREADS
	N_SN=$OMP_NUM_THREADS
else
	unset OMP_NUM_THREADS
	echo "Running sequentially"
fi
A3D_CMD="${TOOL} ${EXE} \
--iofile=./io.ini \
--enable-eb  \
--np-ebalance=${N_EB} \
--np-snowpack=${N_SN} \
--startdate=${BEGIN} --enddate=${END}"
date
if [[ ("${REDIRECT_LOGS}" == "Y") ||  ("${REDIRECT_LOGS}" == "y") ]]; then
	${A3D_CMD} > stdouterr.log 2>&1 $*
else
	${A3D_CMD} 2>&1 $*
fi
ret=$?
echo "Done Alpine3D Simulation. Return code=$ret"
date
echo
exit $ret
