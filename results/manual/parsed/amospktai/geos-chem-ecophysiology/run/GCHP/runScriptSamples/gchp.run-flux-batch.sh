#!/bin/bash
#FLUX: --job-name=confused-fork-2316
#FLUX: --urgency=16

log="gchp.log"
if [[ -e gcchem_internal_checkpoint ]]; then
    rm gcchem_internal_checkpoint
fi
if [[ -e cap_restart ]]; then
   rm cap_restart
fi
source runConfig.sh > ${log}
if [[ $? == 0 ]]; then
    # Source your environment file. This requires first setting the gchp.env
    # symbolic link using script setEnvironment in the run directory. 
    # Be sure gchp.env points to the same file for both compilation and 
    # running. You can copy or adapt sample environment files located in 
    # ./envSamples subdirectory.
    gchp_env=$(readlink -f gchp.env)
    if [ ! -f ${gchp_env} ] 
    then
       echo "ERROR: gchp.env symbolic link is not set!"
       echo "Copy or adapt an environment file from the ./envSamples "
       echo "subdirectory prior to running. Then set the gchp.env "
       echo "symbolic link to point to it using ./setEnvironment.sh."
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
    # Echo info from computational cores to log file for displaying results
    echo "# of CPUs : ${coreCount}" >> ${log}
    echo "# of nodes: ${SLURM_NNODES}" >> ${log}
    echo "-m plane  : ${planeCount}" >> ${log}
    # Optionally compile 
    # Uncomment the line below to compile from scratch
    # See other compile options with 'make help'
    # make build_all
    # Echo start date
    echo ' ' >> ${log}
    echo '===> Run started at' `date` >> ${log}
    # Odyssey-specific setting to get around connection issues at high # cores
    export OMPI_MCL_btl=openib
    # Start the simulation
    time srun -n ${coreCount} -N ${SLURM_NNODES} -m plane=${planeCount} --mpi=pmix ./gchp >> ${log}
    # Rename the restart (checkpoint) file for clarity and to enable reuse as
    # a restart file. MAPL cannot read in a file with the same name as the
    # output checkpoint filename configured in GCHP.rc.
    if [ -f cap_restart ]; then
       restart_datetime=$(echo $(cat cap_restart) | sed 's/ /_/g')
       mv gcchem_internal_checkpoint gcchem_internal_checkpoint.restart.${restart_datetime}.nc4
    fi
    # Echo end date
    echo '===> Run ended at' `date` >> ${log}
else
    cat ${log}
fi
unset log
exit 0
