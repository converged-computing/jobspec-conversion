#!/bin/bash
#FLUX: --job-name=ref_F150A
#FLUX: --queue=mf_ilg2.3
#FLUX: -t=259200
#FLUX: --urgency=16

pdbfile="F150A_autoWAT.pdb"
psffile="F150A_autoWAT.psf"
fepfile="F150A_autoWAT.fep"
fepsource="fep.tcl"
protpar="par_all36_prot.prm"
lippar="par_all36_lipid.prm"
cgfpar="par_all36_cgenff.prm"
watpar="toppar_water_ions.jaf2.str"
gbipar="gbi_final.str"
dLambda="0.025" # 40 Lambda Windows
temp="300"
nMinSteps=25000
eqSteps=500000  # 1ns 
nSteps=2500000  # 5ns
module load namd/2.11-OpenMPI_gcc_ilg
module list
cd $SLURM_SUBMIT_DIR
echo "Working Directory:" pwd
echo 'Array ID number:' $SLURM_ARRAY_TASK_ID
lambda=$SLURM_ARRAY_TASK_ID
if (( $(echo "$dLambda > 0" | bc -l) )); then 
   wdir="FEP_F"
   mkdir $wdir; cd $wdir
   lambdalist=()
   for L in $(seq 0 $dLambda 1); do
      lambdalist+=("$L")
   done
   if [ $lambda -eq 1 ]; then
      FEPcmd="runFEPmin     0   ${lambdalist[$lambda]}   $dLambda  $nSteps  $nMinSteps $temp"
   else 
      FEPcmd="runFEPmin     ${lambdalist[$lambda-1]}   ${lambdalist[$lambda]}   $dLambda   $nSteps  $nMinSteps $temp"
   fi
else
   wdir="FEP_R"
   mkdir $wdir; cd $wdir
   lambdalist=()
   for L in $(seq 1 $dLambda 0); do
      lambdalist+=("$L")
   done
   if [ $lambda -eq 1 ]; then
      FEPcmd="runFEPmin     1   ${lambdalist[$lambda]}   $dLambda  $nSteps  $nMinSteps $temp" 
   else
      FEPcmd="runFEPmin     ${lambdalist[$lambda-1]}   ${lambdalist[$lambda]}   $dLambda   $nSteps  $nMinSteps $temp" 
   fi
fi
if [ $lambda -lt 10 ]; then
   lambda_dir=`printf "lambda_0%s" $lambda`
   fname="alchemy0$lambda"
else
   lambda_dir=`printf "lambda_%s" $lambda`
   fname="alchemy$lambda"
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
sed -i '6iparameters             /work/cluster/limvt/toppar/'$lippar  $fname.inp
sed -i '7iparameters             /work/cluster/limvt/toppar/'$protpar   $fname.inp
sed -i '8iparameters             /work/cluster/limvt/toppar/'$cgfpar   $fname.inp
sed -i '9iparameters             /work/cluster/limvt/toppar/'$watpar   $fname.inp
sed -i '10iparameters             /work/cluster/limvt/toppar/'$gbipar   $fname.inp
sed -i "11iset temp               ${temp}\n"     $fname.inp
echo "source                   ../../00_main/$fepsource" >> $fname.inp
echo "alchFile                 ../../00_main/$fepfile"   >> $fname.inp
echo "alchEquilSteps           $eqSteps"   >> $fname.inp
echo "set nMinSteps            $nMinSteps" >> $fname.inp
echo "$FEPcmd"                             >> $fname.inp
echo "#                     dLambda nSteps nMinSteps temp" >> $fname.inp
HOSTFILE=./hosts.${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}
srun hostname -s > $HOSTFILE
opt="--hostfile $HOSTFILE
     --bind-to core
     --map-by core:pe=1
     --report-bindings
     -mca btl openib,sm,self"
cpuset=$(cat /proc/self/status | grep Cpus_allowed_list | awk '{print $2;}')
echo "Rank $OMPI_COMM_WORLD_RANK bound to core(s) $cpuset"
mpirun $opt namd2 +setcpuaffinity +isomalloc_sync $fname.inp > $fname.log
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
