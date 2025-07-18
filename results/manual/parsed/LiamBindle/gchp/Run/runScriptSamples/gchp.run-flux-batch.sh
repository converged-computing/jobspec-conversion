#!/bin/bash
#FLUX: --job-name=sticky-mango-9210
#FLUX: -n=6
#FLUX: --queue=huce_intel
#FLUX: -t=60
#FLUX: --urgency=16

log="gchp.log"
if [[ -e cap_restart ]]; then
   rm cap_restart
fi
./runConfig.sh > runConfig.log
if [[ $? == 0 ]]; then
    # Source your environment file. This requires first setting the gchp.env
    # symbolic link using script setEnvironment in the run directory. 
    # Be sure gchp.env points to the same file for both compilation and 
    # running. You can copy or adapt sample environment files located in 
    # ./envSamples subdirectory.
    gchp_env=$(readlink -f gchp.env)
    if [ ! -f ${gchp_env} ] 
    then
       echo "ERROR: gchp.rc symbolic link is not set!"
       echo "Copy or adapt an environment file from the ./envSamples "
       echo "subdirectory prior to running. Then set the gchp.env "
       echo "symbolic link to point to it using ./setEnvironment."
       echo "Exiting."
       exit 1
    fi
    echo "WARNING: You are using environment settings in ${gchp_env}"
    source ${gchp_env}
    # Use SLURM to distribute tasks across nodes
    NX=$( grep NX GCHP.rc | awk '{print $2}' )
    NY=$( grep NY GCHP.rc | awk '{print $2}' )
    coreCount=$(( ${NX} * ${NY} ))
    planeCount=$(( ${coreCount} / ${SLURM_NNODES} ))
    if [[ $(( ${coreCount} % ${SLURM_NNODES} )) > 0 ]]; then
	${planeCount}=$(( ${planeCount} + 1 ))
    fi
    # Echo info from computational cores to log file for displaying results
    echo "# of CPUs : $coreCount\n"
    echo "# of nodes: $SLURM_NNODES\n"
    echo "-m plane  : ${planeCount}"
    # Optionally compile 
    # Uncomment the line below to compile from scratch
    # See other compile options with 'make help'
    # make compile_clean
    # Echo start date
    echo '===> Run started at' `date` >> ${log}
    # If the shared memory option is on (USE_SHMEM: 1 in CAP.rc) then
    # clean up existing shared memory segments before and after running 
    # the model
    if grep -q "USE_SHMEM.*1" CAP.rc; then
        ipcs -a  # Show current shared memory segments
        ipcs -l  # Show shared memory limits
        /sbin/sysctl -A | grep shm
        memCleaner=./runScriptSamples/rmshmem.sh
        srun -w $SLURM_JOB_NODELIST -n $SLURM_NNODES --ntasks-per-node=1 ${memCleaner}
        ipcs -a  # Show current shared memory segments again (should be none)
    fi
    # Odyssey-specific setting to get around connection issues at high # cores
    export OMPI_MCL_btl=openib
    # Start the simulation
    time srun -n ${coreCount} -N ${SLURM_NNODES} -m plane=${planeCount} --mpi=pmix ./geos >> ${log}
    # Clean up any shared memory segments owned by this user
    if grep -q "USE_SHMEM.*1" CAP.rc; then
        srun -w $SLURM_JOB_NODELIST -n $SLURM_NNODES --ntasks-per-node=1 ${memCleaner}
    fi
    # Echo end date
    echo '===> Run ended at' `date` >> ${log}
else
    cat runConfig.log
fi
unset log
exit 0
