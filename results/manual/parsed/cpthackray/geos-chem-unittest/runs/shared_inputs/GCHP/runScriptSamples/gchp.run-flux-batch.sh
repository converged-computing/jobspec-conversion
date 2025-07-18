#!/bin/bash
#FLUX: --job-name=sticky-ricecake-9786
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
    # Set and source your bashrc. Change this to whatever env file
    # used during GCHP compilation. You can copy or adapt sample bashrc
    # files located in ./bashrcSamples subdirectory.
    BASHRC=./set_your_gchp_env.bashrc
    if [ ! -f $BASHRC ] 
    then
       echo "ERROR: BASHRC environment variable in run script is not set!"
       echo "Copy or adapt a bashrc from the ./bashrcSamples subdirectory"
       echo "prior to running. Use the same environment file used for compilation."
       echo "Exiting."
       exit 1
    fi
    echo "WARNING: You are using environment settings in $BASHRC"
    source $BASHRC
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
    # Start the simulation
    time srun -n ${coreCount} -N ${SLURM_NNODES} -m plane=${planeCount} --mpi=pmi2 ./geos >> ${log}
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
