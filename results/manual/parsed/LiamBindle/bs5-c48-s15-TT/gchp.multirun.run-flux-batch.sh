#!/bin/bash
#FLUX: --job-name=faux-noodle-2457
#FLUX: -n=30
#FLUX: --exclusive
#FLUX: --queue=huce_intel
#FLUX: -t=30
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
   echo "ERROR: gchp.rc symbolic link is not set!"
   echo "Copy or adapt an environment file from the ./envSamples "
   echo "subdirectory prior to running. Then set the gchp.env "
   echo "symbolic link to point to it using ./setEnvironment."
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
source runConfig.sh > /dev/null
if [ ${Monthly_Diag} = "1" ]; then
   if [ -e cap_restart ]; then    
      yr_str=${cap_rst:0:4}
      mo_str=$((10#${cap_rst:4:2}))
   else
      yr_str=${Start_Time:0:4}
      mo_str=$((10#${Start_Time:4:2}))
   fi
   feb_hrs=672
   if [ "$((yr_str%4))" = "0" ]; then
      if [ ! "$((yr_str%100))" = "0" ] | [ "$((yr_str%400))" = "0" ]; then
         feb_hrs=696   
      fi
      fi
   dpm=(744 $feb_hrs 744 720 744 720 744 744 720 744 720 744)
   hrs_str=${dpm[$((mo_str-1))]}
   sed -i "s|common_freq\=.*|common_freq\=\"${hrs_str}0000\"|" ./runConfig.sh
   sed -i "s|common_dur\=.*|common_dur\=\"${hrs_str}0000\"|"   ./runConfig.sh
fi
echo " "
echo "Settings from runConfig.sh: "
echo " "
source ./runConfig.sh
if [ -e cap_restart ]; then
   restart_datetime=$(echo $(cat cap_restart) | sed 's/ /_/g')
   sed -i "s|GIGCchem_INTERNAL_RESTART_FILE\:.*|GIGCchem_INTERNAL_RESTART_FILE\:     +gcchem_internal_checkpoint.restart.${restart_datetime}.nc4|" ./GCHP.rc
fi
if [[ $? == 0 ]]; then
   NX=$( grep NX GCHP.rc | awk '{print $2}' )
   NY=$( grep NY GCHP.rc | awk '{print $2}' )
   coreCount=$(( ${NX} * ${NY} ))
   # Note that $coreCount can be less than the requested cores in #SBATCH -n
   # Echo info from computational cores to log file for displaying results
   echo " "
   echo "Running GCHP:"
   echo "# of cores: ${coreCount}"
   echo "# of nodes: 1"
   # Echo start date
   echo '===> Run started at' `date`
   # Run the simulation
   # SLURM_NTASKS is #SBATCH -n and SLURM_NNODES is #SBATCH -N above
   mpirun -np 6 ./geos
   # Echo end date
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
      # If all went well, rename the restart (checkpoint) file for clarity
      # and to enable reuse as a restart file. MAPL cannot read in a file
      # with the same name as the output checkpoint filename configured in
      # GCHP.rc.
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
