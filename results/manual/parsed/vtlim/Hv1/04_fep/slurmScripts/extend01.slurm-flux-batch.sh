#!/bin/bash
#FLUX: --job-name="t0_s2r_rev"
#FLUX: -c=8
#FLUX: --queue=mf_nes2.8
#FLUX: -t=259200
#FLUX: --priority=16

lambda=$SLURM_ARRAY_TASK_ID
totalstep=5000000
printf "Start Time:$( date )\n"
module load namd/2.11-MPISMP
module list
cd $SLURM_SUBMIT_DIR
echo "Hostname:" $HOSTNAME
echo "Working Directory: $( pwd )"
printf "\nArray ID number: $SLURM_ARRAY_TASK_ID\n"
if [ $lambda -lt 10 ]; then
   lambda_dir=`printf "lambda_0%s" $lambda`
   fname="alchemy0$lambda"
else
   lambda_dir=`printf "lambda_%s" $lambda`
   fname="alchemy$lambda"
fi
cd $lambda_dir
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
stepline=$( tail -n 1000 "$fname.log" | grep "WRITING EXTENDED SYSTEM" | tail -1 )
if [ -z "$stepline" ]; then
   echo "Could not find last timestep."
   (( err++ ))
fi
if [ $err == 4 ]; then
   echo "Could not find checkpoint files. Restart the run manually."
   exit
fi
echo "Editing input files to restart from checkpoint..."
echo "Found: $stepline"
step=${stepline##* }
if ! [[ "$step" =~ ^[0-9]+$ ]]; then
   echo "Last timestep was not an integer. Check input file."
   exit 
fi
echo "Last timestep: $step"
cp $fname.inp $fname-cpt01.inp
sed -i "s/$fname/$fname-cpt01/"             $fname-cpt01.inp # outfile name* b4 input
sed -i "/set binfile/d"                     $fname-cpt01.inp # remove old inputname
sed -i "1iset binfile            $fname"    $fname-cpt01.inp # set new input
sed -i "s/temperature\t/\#temperature\t/"   $fname-cpt01.inp # comment temperature* \t
sed -i "s/#bincoordinates/bincoordinates/"  $fname-cpt01.inp # use binary coordinates
sed -i "s/#binvelocities/binvelocities/"    $fname-cpt01.inp # use binary velocities
sed -i "s/#extendedSystem/extendedSystem/"  $fname-cpt01.inp # use periodic cell
sed -i "s/cellBasis/\#cellBasis/"           $fname-cpt01.inp # comment cell sizes
sed -i "s/cellOrigin/\#cellOrigin/"         $fname-cpt01.inp # comment cell origin
sed -i "s/alchEquil/\#alchEquil/"           $fname-cpt01.inp # comment FEP Equil steps
fepline=$( tail -n 5 "$fname.inp" | grep "runFEP" )
if [ -z "$fepline" ]; then
   echo "Could not find total steps. Check input file."
   exit 
fi
echo "Found: $fepline"
let remstep="$totalstep-$step"
if ! [[ "$remstep" =~ ^[0-9]+$ ]]; then
   echo "Remaining steps was not an integer."
   exit 
fi
printf "Remaining FEP steps: $remstep\n\n"
start_stop_chg=$(grep runFEPmin $fname-cpt01.inp | tr -s ' ' | cut -d ' ' -f2-4)
sed -i "/runFEPmin/d" $fname-cpt01.inp
sed -i "/dLambda/d" $fname-cpt01.inp
echo "runFEP $start_stop_chg $remstep" >> $fname-cpt01.inp
echo "#      start stop dLambda nSteps" >> $fname-cpt01.inp
rm FFTW_NAMD*txt
cpt=$SLURM_CPUS_PER_TASK
srun --propagate=STACK --cpu_bind=v,sockets --cpus-per-task=$cpt \
     namd2 ++ppn $((cpt-1)) +isomalloc_sync $fname-cpt01.inp > $fname-cpt01.log
cd ..
echo "End Time:$( date )"
exit
