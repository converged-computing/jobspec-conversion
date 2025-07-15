#!/bin/bash
#FLUX: --job-name=hello-pedo-0101
#FLUX: --urgency=16

log="gchp.log"
source runConfig.sh > ${log}
checkpoint_file=OutputDir/gcchem_internal_checkpoint
if [[ -e $checkpoint_file ]]; then
    rm $checkpoint_file
fi
if [ -f cap_restart ]; then
   restart_datetime=$(echo $(cat cap_restart) | sed 's/ /_/g')
   restart_file=$checkpoint_file.restart.${restart_datetime}.nc4
   if [[ ! -e $restart_file ]]; then
      echo "cap_restart exists but restart file does not!"
      exit 72
   fi
else
   nCS=$( grep CS_RES= runConfig.sh | cut -d= -f 2 | awk '{print $1}' )
   restart_file=initial_GEOSChem_c${nCS}_Hg.nc
fi
if [[ -L GCHP_restart.nc4 ]]; then
   unlink GCHP_restart.nc4
fi
ln -s $restart_file GCHP_restart.nc4
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
    # Run the simulation
    echo '===> Run started at' `date` >> ${log}
    time mpirun -n ${coreCount} -N ${planeCount} ./gchp >> ${log}
    echo '===> Run ended at' `date` >> ${log}
    # Rename the restart (checkpoint) file to include datetime
    if [ -f cap_restart ]; then
       restart_datetime=$(echo $(cat cap_restart) | sed 's/ /_/g')
       mv OutputDir/gcchem_internal_checkpoint OutputDir/gcchem_internal_checkpoint.restart.${restart_datetime}.nc4
    fi
else
    cat ${log}
fi
exit 0
