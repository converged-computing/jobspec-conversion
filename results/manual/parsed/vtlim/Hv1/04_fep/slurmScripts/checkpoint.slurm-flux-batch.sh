#!/bin/bash
#FLUX: --job-name=t1_r2s_fwd-01
#FLUX: -c=8
#FLUX: --queue=mf_nes2.8
#FLUX: -t=259200
#FLUX: --urgency=16

lambda=$SLURM_ARRAY_TASK_ID
printf "Start Time:$( date )\n"
module load namd/2.11-MPISMP
module list
cd $SLURM_SUBMIT_DIR
echo "Hostname:" $HOSTNAME
echo "Working Directory: $( pwd )"
printf "\nArray ID number:" $SLURM_ARRAY_TASK_ID
if [ $lambda -lt 10 ]; then
   lambda_dir=`printf "lambda_0%s" $lambda`
   fname="alchemy0$lambda"
else
   lambda_dir=`printf "lambda_%s" $lambda`
   fname="alchemy$lambda"
fi
finline=$( tail -5 "$lambda_dir"/"$fname.log" | grep "End of program" )
if [[ $finline == *"End of program"* ]]; then
   echo "$lambda_dir Complete"
   echo "End Time:$( date )"
   exit 
else
   echo "$lambda_dir Incomplete"
   cd $lambda_dir
   pwd
   # Look for restart files
   err=0
   bincoor="$fname.coor"
   if [ ! -f $bincoor ]; then
      echo "Could not find bincoor file."
      (( err++ ))
   fi
   binvel="$fname.vel"
   if [ ! -f $binvel ]; then
      echo "Could not find binvel file."
      (( err++ ))
   fi
   binxsc="$fname.xsc"
   if [ ! -f $binxsc ]; then
      echo "Could not find binxsc file."
      (( err++ ))
   fi
   # Get last timestep from which to restart
   stepline=$( tail -n 1000 "$fname.log" | grep "WRITING EXTENDED SYSTEM" | tail -1 )
   if [ -z "$stepline" ]; then
      echo "Could not find last timestep."
      (( err++ ))
   fi
   # Quit if restart files are not found
   if [ $err == 4 ]; then
      echo "Could not find checkpoint files. Restart the run manually."
      exit
   fi
   # Get the last time step
   # valid if outputfreq matches restartfreq
   echo "Editing input files to restart from checkpoint..."
   echo "Found: $stepline"
   step=${stepline##* }
   if ! [[ "$step" =~ ^[0-9]+$ ]]; then
      echo "Last timestep was not an integer. Check input file."
      exit 
   fi
   echo "Last timestep: $step"
   # Adjust input file to restart FEP from checkpoint
   cp $fname.inp $fname-cpt.inp
   sed -i "s/$fname/$fname-cpt/"               $fname-cpt.inp # outfile name* b4 input
   sed -i "/set binfile/d"                     $fname-cpt.inp # remove old inputname
   sed -i "1iset binfile            $fname"    $fname-cpt.inp # set new input
   #sed -i -e "s/#firsttimestep/firsttimestep $step/" $fname-cpt.inp # set firsttimestep, not allowed for fep
   sed -i "s/temperature\t/\#temperature\t/"   $fname-cpt.inp # comment temperature* \t
   sed -i "s/#bincoordinates/bincoordinates/"  $fname-cpt.inp # use binary coordinates
   sed -i "s/#binvelocities/binvelocities/"    $fname-cpt.inp # use binary velocities
   sed -i "s/#extendedSystem/extendedSystem/"  $fname-cpt.inp # use periodic cell
   sed -i "s/cellBasis/\#cellBasis/"            $fname-cpt.inp # comment cell sizes
   sed -i "s/cellOrigin/\#cellOrigin/"          $fname-cpt.inp # comment cell origin
   sed -i "s/alchEquil/\#alchEquil/"            $fname-cpt.inp # remove FEP Equil steps
   # Evaluate remaining FEP steps
   fepline=$( tail -n 5 "$fname.inp" | grep "runFEP" )
   if [ -z "$fepline" ]; then
      echo "Could not find total steps. Check input file."
      exit 
   fi
   echo "Found: $fepline"
   # Get the original total amount of steps
   totalstep=$( echo $fepline | awk '{print $5}' | bc )
   if ! [[ "$totalstep" =~ ^[0-9]+$ ]]; then
      echo "Total step was not an integer. Check input file."
      exit 
   fi   
   echo "Total Steps: $totalstep"
   # Subtract totalstep - laststep
   let remstep="$totalstep-$step"
   if ! [[ "$remstep" =~ ^[0-9]+$ ]]; then
      echo "Remaining steps was not an integer."
      exit 
   fi
   printf "Remaining FEP steps: $remstep\n"
   # runFEPmin to runFEP, keep first 28 chars, include remstep 
   sed -i -e "s/Pmin/P/" -r -e "s/runFEP(.{22}).*/runFEP\1 $remstep/" $fname-cpt.inp
   sed -i "/dLambda/d" $fname-cpt.inp
   echo "#          start stop dLambda nSteps" >> $fname-cpt.inp
   # Submit FEP run
   cpt=$SLURM_CPUS_PER_TASK
   #mpiname -a
   srun --propagate=STACK --cpu_bind=v,sockets --cpus-per-task=$cpt \
        namd2 ++ppn $((cpt-1)) +isomalloc_sync $fname-cpt.inp > $fname-cpt.log
   cd ..
fi
echo "End Time:$( date )"
exit
