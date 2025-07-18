#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: -N=25
#FLUX: --queue=normal
#FLUX: -t=43200
#FLUX: --urgency=16

TAU=1
INTEL=24
source ${HOME}/Software/env_frontera_intel${INTEL}.sh
module load petsc/3.20-ratel libceed ratel
if [ "${TAU}" = "1" ] ; then 
    # module use /opt/apps/intel19/impi19_0/modulefiles/
    echo "Loading tau"
    module load tau/2.33
    if [ -z "${TACC_TAU_DIR}" ] ; then 
	echo "ERROR could not load tau/2.33" && exit 1
    fi
    which tau_exec
fi 
RATEL_EXAMPLES=${TACC_RATEL_DIR}/examples
if [ ! -d ${RATEL_EXAMPLES} ] ; then
    echo "Can not find examples dir: <<${RATEL_EXAMPLES}>>"
    exit 1
else
    echo "Using examples directory: <<${RATEL_EXAMPLES}>>"
fi
example=ex02-quasistatic-elasticity-isochoric-neo-hookean-current-face-forces.yml
echo $example
if [ ! -f ${RATEL_EXAMPLES}/${example} ] ; then
    echo "Can not find example file: <<${RATEL_EXAMPLES}/${example}>>"
    exit 1
else 
    echo "Using example: $( ls -l ${example} )"
fi
np=4
box=12
if [ -z "${SLURM_NPROCS}" ] ; then 
    echo "Please run this only in an idev session" && exit 1 
fi
echo "Using max ${SLURM_NPROCS} cores"
profiledir=${STOCKYARD}/ratel-tau-${TACC_SYSTEM}
mkdir -p ${profiledir} && rm -rf ${profiledir}/*
while [ ${np} -lt ${SLURM_NPROCS} ] ; do
    echo "==============================================================="
    echo "==============================================================="
    optionsfile=options.yml
    cat ${RATEL_EXAMPLES}/${example} \
	| sed -e 's/4,4,4/'${box}','${box}','${box}'/' \
	> ${optionsfile}
    cat ${optionsfile}
    profdir=${profiledir}/profile${np}.dir && rm -rf $profdir && mkdir -p $profdir 
    export TAU_TRACE=1
    export PROFILEDIR=${profdir}
    # export TAU_CALLSITE=1 ## 
    export TAU_EBS_UNWIND=1
    export TAU_CALLPATH=1    
    export TAU_COMM_MATRIX=1
    export TAU_CALLPATH=1
    export TAU_CALLPATH_DEPTH=20
    time ibrun -np ${np} \
	$( if [ "${TAU}" = "1" ] ; then echo "${TACC_TAU_DIR}/x86_64/bin/tau_exec -ebs" ; fi ) \
	${TACC_RATEL_BIN}/ratel-quasistatic \
	-log_perfstubs \
        -options_file ${optionsfile} \
        -ksp_max_it 5 \
        -snes_max_it 4 -snes_monitor \
        -ts_max_steps 5 \
        -ts_max_snes_failures -1 \
	-ts_max_reject -1 \
        -log_view :rateljob${np}.out
    chmod -R g+rX,o+rX $profdir
    box=$(( 3 * box / 2 ))
    np=$(( 6 * np ))
done
echo && echo "See TAU profiles in ${profiledir}" && echo
ls ${profiledir}
chmod g+rX,o+rX ${profiledir}
