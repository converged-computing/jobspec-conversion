#!/bin/bash
#FLUX: --job-name=CTRL
#FLUX: -N=7
#FLUX: -n=476
#FLUX: --queue=development
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='cores'
export OMP_PROC_BIND='spread'
export CONFIG_FILE='/work2/04920/tg842199/stampede2/nonlinear_IR-DA/indian_ocean_osse/PSU_EnKF/scripts/config/CTRL'
export DATE='$DATE_START'
export PREVDATE='$DATE_START'
export NEXTDATE='$DATE_START'

export OMP_NUM_THREADS=1
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
source ~/.bashrc
export CONFIG_FILE=/work2/04920/tg842199/stampede2/nonlinear_IR-DA/indian_ocean_osse/PSU_EnKF/scripts/config/CTRL
. $CONFIG_FILE
cd $SCRIPT_DIR
. util.sh
if [[ ! -d $WORK_DIR ]]; then mkdir -p $WORK_DIR; fi
cd $WORK_DIR
if [[ ! -d run/$DATE_START ]]; then
  mkdir -p run/$DATE_START
  cd run/$DATE_START
  mkdir icbc perturb_ic wrf wrf_ens
  for f in `ls`; do
    echo complete > $f/stat
  done
fi
cd $WORK_DIR
if [[ $HOSTTYPE == "stampede" ]]; then
  export total_ntasks=$SLURM_NTASKS
fi
if [[ $HOSTTYPE == "jet" ]]; then
  export total_ntasks=$PBS_NP
fi
if [[ $HOSTTYPE == "cori-knl" ]]; then
  export total_ntasks=$SLURM_NTASKS
fi
if [[ $HOSTTYPE == "cori-login" ]]; then
  export total_ntasks=3400
fi
if [[ $HOSTTYPE == "cori-regular" ]]; then
  export total_ntasks=3400
fi
echo total_ntasks is $total_ntasks
export DATE=$DATE_START
export PREVDATE=$DATE_START
export NEXTDATE=$DATE_START
while [[ $NEXTDATE -le $DATE_CYCLE_END ]]; do
  export OWMAX=`min ${OBS_WIN_MAX[@]}`
  export OWMIN=`min ${OBS_WIN_MIN[@]}`
  export DT=$TIME_STEP
  export MPS=`min ${MINUTE_PER_SLOT[@]}`
  export FCSTM=`min ${FORECAST_MINUTES[@]}`
  export CP=`min ${CYCLE_PERIOD[@]}`
  if [[ $DATE == $DATE_START ]]; then
    export CP=`diff_time $DATE $DATE_CYCLE_START`
  fi
  if $RUN_4DVAR; then
    export start_date_cycle=$DATE
    export run_minutes_cycle=`echo $CP+$OWMAX |bc`
    if [[ $DATE -ge $DATE_CYCLE_START ]]; then
      export start_date_cycle=`advance_time $start_date_cycle $OWMIN`
      export run_minutes_cycle=`echo $run_minutes+$OWMIN |bc`
    fi
  else
    export start_date_cycle=$DATE
    export run_minutes_cycle=$CP
  fi
  if $RUN_DETERMINISTIC; then
    export run_minutes_forecast=`diff_time $DATE $DATE_END`
  else
    export run_minutes_forecast=`max $CP $FCSTM`
  fi
  export minute_off=`echo "(${start_date_cycle:8:2}*60+${start_date_cycle:10:2})%$LBC_INTERVAL" |bc`
  if [[ $DATE == `advance_time $start_date_cycle -$minute_off` ]]; then
    export LBDATE=`advance_time $start_date_cycle -$minute_off`
    #export LBDATE=$DATE_START
  fi
  export NEXTDATE=`advance_time $DATE $CP`
  echo "----------------------------------------------------------------------"
  echo "CURRENT CYCLE: `wrf_time_string $DATE` => `wrf_time_string $NEXTDATE`"
  mkdir -p {run,rc,fc,output,obs}/$DATE
  for d in `ls run/$DATE/`; do
    if [[ `cat run/$DATE/$d/stat` != "complete" ]]; then
      echo waiting > run/$DATE/$d/stat
    fi
  done
  #$SCRIPT_DIR/module_wps.sh &
  #$SCRIPT_DIR/module_real.sh &
  $SCRIPT_DIR/module_icbc.sh &
  if $RUN_ENKF && [ $DATE == $DATE_START ]; then
    $SCRIPT_DIR/module_perturb_ic.sh &
    $SCRIPT_DIR/module_update_bc.sh &
    $SCRIPT_DIR/module_wrf_ens.sh &
    wait
  fi
  if [ $DATE == $LBDATE ]; then
    $SCRIPT_DIR/module_perturb_ic.sh &
  fi
  if [ $DATE -ge $DATE_CYCLE_START ] && [ $DATE -le $DATE_CYCLE_END ]; then
    if $RUN_ENKF || $RUN_4DVAR; then
      $SCRIPT_DIR/module_obsproc.sh &
    fi
    $SCRIPT_DIR/module_enkf.sh &
    wait
    if $RUN_4DVAR; then
      $SCRIPT_DIR/module_4dvar.sh &
    fi
    if $RUN_ENKF || $RUN_4DVAR; then
      $SCRIPT_DIR/module_update_bc.sh &
    fi
    $SCRIPT_DIR/module_wrf.sh &
    $SCRIPT_DIR/module_wrf_ens.sh &
    wait
  fi
  wait
  date
  for d in `ls -t run/$DATE/`; do
    if [[ `cat run/$DATE/$d/stat` == "error" ]]; then
      echo CYCLING STOP DUE TO FAILED COMPONENT: $d
      exit 1
    fi
  done
  export PREVDATE=$DATE
  export DATE=$NEXTDATE
done
echo CYCLING COMPLETE
