#!/bin/bash
#FLUX: --job-name=dartParFlow
#FLUX: -n=48
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

export LOGNAME='$WORK/$1'
export LOGNAME_S='$WORK/rundart01'
export DART_DIR='$HOME/DART/lanai/models/terrsysmp/parflow/work'
export LD_LIBRARY_PATH='$EBROOTNETCDFMINFORTRAN/lib/":$LD_LIBRARY_PATH'
export numInst='$2'

export LOGNAME="$WORK/$1"
export LOGNAME_S="$WORK/rundart01"
export DART_DIR="$HOME/DART/lanai/models/terrsysmp/parflow/work"
export LD_LIBRARY_PATH="$EBROOTNETCDFMINFORTRAN/lib/":$LD_LIBRARY_PATH
cd $LOGNAME
source $LOGNAME/loadenvs
export numInst=$2
rm input.nml
rm pfb_soil.nc
rm filter_ics.*
rm P*Diag.nc
rm filter_res*
rm dart_log.*
rm obs_seq.*
rm log_file
rm err_file
rm ready.txt
rm pfl_press.pfb 
rm pfl_satur.pfb
rm pflgrid.nc
rm clm_restart.nc
rm clm_restart_s.nc
rm parflow_restart.pfb
cp $DART_DIR/input.nml .
cp $DART_DIR/filter .
cp $DART_DIR/dart_to_parflow .
cp $DART_DIR/parflow_to_dart .
for instance in {0..$(($numInst-1))}
do
  cd tsmp_instance_$instance
  rm input.nml
  rm pfb_soil.nc
  #rm pfidb_dz
  rm dart_log.*
  rm dart_posterior
  rm pfl_press.pfb
  rm pfl_satur.pfb
  rm pflgrid.nc
  rm clm_restart.nc
  rm clm_restart_s.nc
  rm parflow_restart.pfb
  rm parflow_prior_time.txt 
  rm dart_posterior_times.txt
  ln -s ../input.nml .
  prspfb=`ls -1 rurlaf.out.press*.pfb | tail -n -1` 
  satpfb=`ls -1 rurlaf.out.satur*.pfb | tail -n -1`
  clmrst=`ls -1 clmoas.clm2.r.*.nc | tail -n -2 | head -n 1`
  clmrst_s=`ls -1 $LOGNAME_S/tsmp_instance_${instance}/clmoas.clm2.r.*.nc | tail -n -2 | head -n 1`
  pflgrd=`ls grids.nc`
  #ln -s ../pfidb_dz .
  ln -s $prspfb pfl_press.pfb 
  ln -s $satpfb pfl_satur.pfb
  ln -s $pflgrd pflgrid.nc
  ln -s $clmrst clm_restart.nc
  ln -s $clmrst_s clm_restart_s.nc
  ln -s pfb*.nc pfb_soil.nc
  ../parflow_to_dart || exit 1
  dartinstance=$(( $instance + 1 ))
  filterName=`printf ../filter_ics.%04d $dartinstance`
  mv dart_prior $filterName 
  cd ..
done
wait
timefile_path="tsmp_instance_0"
dIndat=`grep defaultInitDate $timefile_path/parflow_prior_time.txt | cut -d' ' -f2`
ln -s $DART_DIR/obs_seq.$dIndat obs_seq.out || exit 2
ln -s tsmp_instance_0/$prspfb pfl_press.pfb 
ln -s tsmp_instance_0/$satpfb pfl_satur.pfb
ln -s tsmp_instance_0/$pflgrd pflgrid.nc
ln -s tsmp_instance_0/$clmrst clm_restart.nc
ln -s tsmp_instance_0/pfb_sID*.nc pfb_soil.nc
echo "CPS 2"
date
srun  -n $numInst  ./filter || exit 3  >> log_file 2>> err_file
date
for instance in {0..$(($numInst-1))}
do
  cd tsmp_instance_$instance
  dartinstance=$(( $instance + 1 ))
  filterRestartName=`printf ../filter_restart.%04d $dartinstance`
  ln -s $filterRestartName dart_posterior 
  ../dart_to_parflow || exit 4
  cd ..
done
wait
echo "ready" > ready.txt
exit 0
