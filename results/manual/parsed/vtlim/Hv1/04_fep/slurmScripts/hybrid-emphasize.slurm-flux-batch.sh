#!/bin/bash
#FLUX: --job-name="F182Ap_fwd"
#FLUX: -c=8
#FLUX: --queue=mf_nes2.8
#FLUX: -t=7200
#FLUX: --priority=16

pdbfile="15183_04-F182A.pdb"
psffile="15183_04-F182A.psf"
fepfile="15183_04-F182A.fep"
fepsource="fep.tcl"
protpar="par_all36_prot.prm"
lippar="par_all36_lipid.prm"
cgfpar="par_all36_cgenff.prm"
watpar="toppar_water_ions.jaf2.str"
gbipar="gbi_final.str"
dLambda="0.05" # 19 Lambda Windows
dLastLam="0.01" # break up last window (1-dLambda)
temp="300"
nMinSteps=1000
eqSteps=500000  # 1 ns
nSteps=5500000  # 11 ns
module load namd/2.11-MPISMP
module list
cd $SLURM_SUBMIT_DIR
echo "Working Directory:" pwd
echo 'Array ID number:' $SLURM_ARRAY_TASK_ID
window=$SLURM_ARRAY_TASK_ID
absDL=${dLambda//-}
normlast=$(echo "1 / $absDL" | bc -l)
lastlambda=$(echo "1-$absDL" | bc -l)
if (( $(echo "$dLambda > 0" | bc -l) )); then
   wdir="FEP_F"
   mkdir $wdir; cd $wdir
   ### Break the last window into smaller windows, by dLastLam. 
   if (( $(echo "$window >= $normlast" | bc -l) )); then
       ### Get list of lambda values for last window (e.g. 0.95 0.96 0.97 0.98 0.99 1.00)
       lastlist=()
       for K in $(seq $lastlambda $dLastLam 1); do
          lastlist+=("$K")
       done
       ### Get index of correct lambda to use in lastlist.
       ### E.g. if window is 24, lindex is 24-20+1 = 4, and lastlist[4]=0.99.
       lindex=$(echo "$window - $normlast + 1" | bc -l) 
       lindex=${lindex%.*} # remove trailing zeroes
       FEPcmd="runFEPmin     ${lastlist[$lindex-1]}   ${lastlist[$lindex]}   $dLastLam   $nSteps  $nMinSteps $temp"
   ### If window number < normlast, treat as normal.
   else
       lambdalist=()
       for L in $(seq 0 $dLambda $lastlambda); do
          lambdalist+=("$L")
       done
       FEPcmd="runFEPmin     ${lambdalist[$window-1]}   ${lambdalist[$window]}   $dLambda   $nSteps  $nMinSteps $temp"
   fi
else
   wdir="FEP_R"
   mkdir $wdir; cd $wdir
   ### Number of subwindows = dLambda / dLastLambda
   numSubWin=$(echo "$dLambda / $dLastLam" | bc -l)
   numSubWin=${numSubWin%.*} # remove trailing zeroes
   ### E.g. The first five windows of rev ~ the last five windows of fwd.
   if [ $window -le $numSubWin ]; then
       ### Get list of lambda values for last window (e.g. 1.00 0.99 0.98 0.97 0.96 0.95)
       lastlist=()
       for K in $(seq 1 $dLastLam $lastlambda); do
          lastlist+=("$K")
       done
       FEPcmd="runFEPmin     ${lastlist[$window-1]}   ${lastlist[$window]}   $dLastLam   $nSteps  $nMinSteps $temp"
   else
       lambdalist=()
       for L in $(seq $lastlambda $dLambda 0); do
          lambdalist+=("$L")
       done
       ### Get index of correct lambda to use in lastlist.
       ### E.g. if window is 6, lindex is 6-5-1 = 0, and lambdalist[0]=0.95.
       lindex=$(echo "$window - $numSubWin - 1" | bc -l) 
       lindex=${lindex%.*} # remove trailing zeroes
       FEPcmd="runFEPmin     ${lambdalist[$lindex]}   ${lambdalist[$lindex+1]}   $dLambda   $nSteps  $nMinSteps $temp" 
   fi
fi
if [ $window -lt 10 ]; then
   lambda_dir=`printf "lambda_0%s" $window`
   fname="alchemy0$window"
else
   lambda_dir=`printf "lambda_%s" $window`
   fname="alchemy$window"
fi
if [ ! -d "$lambda_dir" ]; then
   mkdir $lambda_dir
fi
slurm_startjob(){
cd $lambda_dir
cp ../../00_main/alchemy.inp ./$fname.inp
sed -i '2iset outfile            '$fname    $fname.inp
sed -i '3istructure              ../../00_main/'$psffile  $fname.inp
sed -i '4icoordinates            ../../00_main/'$pdbfile  $fname.inp
sed -i '5iparaTypeCharmm         on' $fname.inp
sed -i '6iparameters             /data12/cmf/limvt/toppar/'$lippar  $fname.inp
sed -i '7iparameters             /data12/cmf/limvt/toppar/'$protpar   $fname.inp
sed -i '8iparameters             /data12/cmf/limvt/toppar/'$cgfpar   $fname.inp
sed -i '9iparameters             /data12/cmf/limvt/toppar/'$watpar   $fname.inp
sed -i '10iparameters             /data12/cmf/limvt/toppar/'$gbipar   $fname.inp
sed -i "11iset temp               ${temp}\n"     $fname.inp
echo "source                   ../../00_main/$fepsource" >> $fname.inp
echo "alchFile                 ../../00_main/$fepfile"   >> $fname.inp
echo "alchEquilSteps           $eqSteps"   >> $fname.inp
echo "set nMinSteps            $nMinSteps" >> $fname.inp
echo "$FEPcmd"                             >> $fname.inp
echo "#          start stop dLambda nSteps nMinSteps temp" >> $fname.inp
cpt=$SLURM_CPUS_PER_TASK
srun --propagate=STACK --cpu_bind=v,sockets --cpus-per-task=$cpt \
     namd2 ++ppn $((cpt-1)) +isomalloc_sync $fname.inp > $fname.log
cd ..
echo "JOB DONE"
}
slurm_info_out(){
echo "=================================== SLURM JOB ==================================="
date
echo
echo "The job will be started on the following node(s):"
echo $SLURM_JOB_NODELIST
echo
echo "Slurm User:         $SLURM_JOB_USER"
echo "Run Directory:      $(pwd)"
echo "Job ID:             ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
echo "Job Name:           $SLURM_JOB_NAME"
echo "Partition:          $SLURM_JOB_PARTITION"
echo "Number of nodes:    $SLURM_JOB_NUM_NODES"
echo "Number of tasks:    $SLURM_NTASKS"
echo "Submitted From:     $SLURM_SUBMIT_HOST:$SLURM_SUBMIT_DIR"
echo "=================================== SLURM JOB ==================================="
echo
echo "--- SLURM job-script output ---"
}
copy_results(){
if [ ! -d results ]; then
   mkdir results
fi
cp $lambda_dir/$fname.fepout ./results/
}
slurm_startjob
copy_results
slurm_info_out
date
