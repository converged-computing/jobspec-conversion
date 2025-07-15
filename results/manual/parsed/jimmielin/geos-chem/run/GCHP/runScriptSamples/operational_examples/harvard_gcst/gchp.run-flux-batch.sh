#!/bin/bash
#FLUX: --job-name=peachy-peanut-butter-2588
#FLUX: --priority=16

log="gchp.log"
if [[ -e cap_restart ]]; then
   rm cap_restart
fi
source runConfig.sh > ${log}
if [[ $? == 0 ]]; then
    # Source your environment file. This requires first setting the gchp.env
    # symbolic link using script setEnvironment in the run directory. 
    # Be sure gchp.env points to the same file for both compilation and run.
    gchp_env=$(readlink -f gchp.env)
    if [ ! -f ${gchp_env} ] 
    then
       echo "ERROR: gchp.env symbolic link is not set!"
       echo "Set symbolic link to env file using setEnvironment.sh."
       echo "Exiting."
       exit 1
    fi
    echo " " >> ${log}
    echo "WARNING: You are using environment settings in ${gchp_env}" >> ${log}
    source ${gchp_env} >> ${log}
    # Use SLURM to distribute tasks across nodes
    NX=$( grep NX GCHP.rc | awk '{print $2}' )
    NY=$( grep NY GCHP.rc | awk '{print $2}' )
    coreCount=$(( ${NX} * ${NY} ))
    planeCount=$(( ${coreCount} / ${SLURM_NNODES} ))
    if [[ $(( ${coreCount} % ${SLURM_NNODES} )) > 0 ]]; then
	${planeCount}=$(( ${planeCount} + 1 ))
    fi
    echo "# of CPUs : ${coreCount}" >> ${log}
    echo "# of nodes: ${SLURM_NNODES}" >> ${log}
    echo "-m plane  : ${planeCount}" >> ${log}
    echo ' ' >> ${log}
    # Cannon-specific setting to get around connection issues at high # cores
    export OMPI_MCL_btl=openib
    # Run the simulation
    echo '===> Run started at' `date` >> ${log}
    time srun -n ${coreCount} -N ${SLURM_NNODES} -m plane=${planeCount} --mpi=pmix ./gchp >> ${log}
    echo '===> Run ended at' `date` >> ${log}
    # Rename the restart (checkpoint) file to include datetime
    if [ -f cap_restart ]; then
       restart_datetime=$(echo $(cat cap_restart) | sed 's/ /_/g')
       mv gcchem_internal_checkpoint gcchem_internal_checkpoint.restart.${restart_datetime}.nc4
    fi
else
    cat ${log}
fi
exit 0
