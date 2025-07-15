#!/bin/bash
#FLUX: --job-name=phat-puppy-9261
#FLUX: --urgency=16

multirunlog="multirun.log"
cancel_all_jobs()
{
   msg="Submitted batch job"
   msgs=($(grep -hr "${msg}" ./${multirunlog}))
   for jobid in "${msgs[@]}"
   do
      if [[ ! "${msg}" = *"${jobid}"* ]]; then
         scancel ${jobid}
      fi
   done
}
gchp_env=$(readlink -f gchp.env)
if [ ! -f ${gchp_env} ] 
then
   echo "ERROR: gchp.env symbolic link is not set!"
   echo "Set symbolic link to env file using setEnvironment.sh."
   echo "Exiting."
   exit 1
fi
echo "WARNING: You are using environment settings in ${gchp_env}"
source ${gchp_env}
if [ -e cap_restart ]; then
   cap_rst=$(cat cap_restart)
   echo " "
   echo "Cap_restart prior to run: ${cap_rst}"
else
   cap_rst="none"
   echo " "
   echo "No cap_restart prior to run"
fi
source runConfig.sh --silent
echo " "
echo "Settings from runConfig.sh: "
echo " "
source runConfig.sh
if [ -e cap_restart ]; then
   restart_datetime=$(echo $(cat cap_restart) | sed 's/ /_/g')
   sed -i "s|GCHPchem_INTERNAL_RESTART_FILE\:.*|GCHPchem_INTERNAL_RESTART_FILE\:     +gcchem_internal_checkpoint.restart.${restart_datetime}.nc4|" ./GCHP.rc
fi
if [[ $? == 0 ]]; then
   NX=$( grep NX GCHP.rc | awk '{print $2}' )
   NY=$( grep NY GCHP.rc | awk '{print $2}' )
   coreCount=$(( ${NX} * ${NY} ))
   # Note that $coreCount can be less than the requested cores in #SBATCH -n
   # Use SLURM to distribute tasks across nodes
   planeCount=$(( ${coreCount} / ${SLURM_NNODES} ))
   if [[ $(( ${coreCount} % ${SLURM_NNODES} )) > 0 ]]; then
   	${planeCount}=$(( ${planeCount} + 1 ))
   fi
   # Echo info from computational cores to log file for displaying results
   echo " "
   echo "Running GCHP:"
   echo "# of cores: ${coreCount}"
   echo "# of nodes: ${SLURM_NNODES}"
   echo "cores per nodes: ${planeCount}"
   # Cannon-specific setting to get around connection issues at high # cores
   export OMPI_MCL_btl=openib
   # Run the simulation
   # SLURM_NTASKS is #SBATCH -n and SLURM_NNODES is #SBATCH -N above
   echo '===> Run started at' `date`
   time srun -n ${coreCount} -N ${SLURM_NNODES} -m plane=${planeCount} --mpi=pmix ./gchp
   echo '===> Run ended at' `date`
fi
if [ -f cap_restart ]; then    
   new_cap_rst=$(cat cap_restart)
   echo " "
   echo "cap_restart after run: ${new_cap_rst}" | tee -a ${multirunlog}
   if [[ "${new_cap_rst}" = "${cap_rst}" || "${new_cap_rst}" = "" ]]; then
      echo " "
      echo "Error: cap_restart did not update to different date!" >> ${multirunlog}
      echo "Cancelling all jobs." >> ${multirunlog}
      cancel_all_jobs
   else
      # Rename the restart (checkpoint) file to include datetime
      if [ -f cap_restart ]; then
         restart_datetime=$(echo $(cat cap_restart) | sed 's/ /_/g')
         mv gcchem_internal_checkpoint gcchem_internal_checkpoint.restart.${restart_datetime}.nc4
      fi
   fi
else
   echo " "
   echo "Error: cap_restart does not exist after GCHP run!" >> ${multirunlog}
   echo "Cancelling all jobs." >> ${multirunlog}
   cancel_all_jobs
fi
exit 0
