#!/bin/bash
#FLUX: --job-name=scruptious-chair-5667
#FLUX: --urgency=16

gchplog="gchp.log"
multirunlog="multirun.log"
runconfiglog="runConfig.log"
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
BASHRC=./set_your_gchp_env.bashrc
if [ ! -f ${BASHRC} ] 
then
   echo "ERROR: BASHRC environment variable in run script is not set!"
   echo "Copy or adapt a bashrc from the ./bashrcSamples subdirectory"
   echo "prior to running. Use the same environment file used for compilation."
   echo "Exiting."
   exit 1
fi
echo "WARNING: You are using environment settings in ${BASHRC}"
source ${BASHRC}
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
Monthly_Diag=0
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
   # Echo start date
   echo '===> Run started at' `date` >> ${gchplog}
   # Run the simulation
   # SLURM_NTASKS is #SBATCH -n and SLURM_NNODES is #SBATCH -N above
   time srun -n ${coreCount} -N ${SLURM_NNODES} -m plane=${planeCount} --mpi=pmi2 ./geos >> ${gchplog}
   # Echo end date
   echo '===> Run ended at' `date` >> ${gchplog}
fi
if [ -f cap_restart ]; then    
   new_cap_rst=$(cat cap_restart)
   echo " "
   echo "cap_restart after run: ${new_cap_rst}" | tee -a ${multirunlog}
   if [ "${new_cap_rst}" = "${cap_rst}" ]; then
      echo " "
      echo "Error: cap_restart did not update to different date!" >> ${multirunlog}
      echo "Cancelling all jobs." >> ${multirunlog}
      cancel_all_jobs
   fi
else
   echo " "
   echo "Error: cap_restart does not exist after GCHP run!" >> ${multirunlog}
   echo "Cancelling all jobs." >> ${multirunlog}
   cancel_all_jobs
fi
exit 0
