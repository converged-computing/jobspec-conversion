#!/bin/bash
#FLUX: --job-name=icon
#FLUX: -N=8
#FLUX: --queue=amdrtx
#FLUX: -t=3600
#FLUX: --priority=16

export OMP_NUM_THREADS='16'
export ICON_THREADS='1'
export OMP_SCHEDULE='static,1'
export OMP_DYNAMIC='false'
export OMP_STACKSIZE='200M'
export EXPNAME='aquaplanet_04'
export START='mpirun --envall -env INJECTED_LATENCY ${INJECTED_LATENCY} -env MPICH_ASYNC_PROGRESS 1 -env UCX_RNDV_THRESH 256000 -env UCX_RC_VERBS_SEG_SIZE 256000 -env OMP_NUM_THREADS 16 -f /scratch/sshen/lgs-mpi-data/hosts -np $num_procs'
export MODEL='${basedir}/bin/icon'
export FI_MR_CACHE_MONITOR='memhooks'
export MPICH_OFI_NIC_POLICY='GPU'
export MPICH_GPU_SUPPORT_ENABLED='0'

set +x
ulimit -s unlimited
builder=generalgcc
export OMP_NUM_THREADS=16
export ICON_THREADS=1
export OMP_SCHEDULE=static,1
export OMP_DYNAMIC="false"
export OMP_STACKSIZE=200M
rankmap_file=""
num_procs=8
output_file="/scratch/sshen/lgs-mpi-data/run.out"
INJECTED_LATENCY=0
if [ $# -eq 1 ]; then
    num_procs="$1"
elif [ $# -eq 2 ]; then
    INJECTED_LATENCY="$2"
fi
echo "[INFO] Number of processes: ${num_procs}"
echo "[INFO] Injected latency: ${INJECTED_LATENCY}"
TRACE_LIB=/scratch/sshen/lgs-mpi-data/liballprof2/liballprof_f77.so
no_of_nodes=1
mpi_procs_pernode=16
((mpi_total_procs=no_of_nodes * mpi_procs_pernode))
nproma=32
nproma_sub=
nblocks_c=0
if [ -a ../setting ]
then
  echo "Load Setting"
  . ../setting
fi
export EXPNAME="aquaplanet_04"
thisdir=$(pwd)
basedir="/scratch/sshen/icon/icon-src"
echo $basedir
experiments_dir="/scratch/sshen/icon/results"
icon_data_rootFolder="/scratch/sshen/icon/data"
if [ -z "$rankmap_file" ]; then
    # If the rankmap file is not provided by the user
    # num_nodes=$(( num_procs / mpi_procs_pernode ))
    # rankmap="(0,${num_nodes},${mpi_procs_pernode})"
    rankmap=""
else
    # Otherwise, read from the rankmap file
    if [ -f "$rankmap_file" ]; then
	rankmap=$(<"$rankmap_file")
	IFS=',' read -ra ADDR <<< "$rankmap"
	rank_count=${#ADDR[@]}
	# Makes sure that the number of ranks in the rankmap file is equal
	# to the total number of processes
	if [ "$rank_count" -ne "$num_procs" ]; then
	    echo "Assertion failed: Expected $num_procs ranks in the rankmap file, but found $rank_count." >&2
	    exit 1
	fi
	rankmap="-rankmap $rankmap"
    else
	echo "[ERROR] The given rankmap file does not exist: ${rankmap_file}" >&2
	exit -1
    fi
fi
export START="mpirun --envall -env INJECTED_LATENCY ${INJECTED_LATENCY} -env MPICH_ASYNC_PROGRESS 1 -env UCX_RNDV_THRESH 256000 -env UCX_RC_VERBS_SEG_SIZE 256000 -env OMP_NUM_THREADS 16 -f /scratch/sshen/lgs-mpi-data/hosts -np $num_procs"
export MODEL="${basedir}/bin/icon"
set | grep SLURM
submit="mpirun"
job_name="icon.sh"
. ${basedir}/run/add_run_routines
export FI_MR_CACHE_MONITOR=memhooks
export MPICH_OFI_NIC_POLICY=GPU
export MPICH_GPU_SUPPORT_ENABLED=0
author_list="Marco Giorgetta, Sebastian Mueller, Sebastian Rast, MPIM"
grid_id=0013
grid_refinement=R02B04
grid_label=G
grid_name=icon_grid_${grid_id}_${grid_refinement}_${grid_label}
atmo_dyn_grids="'${grid_name}.nc',"
grids_folder=${icon_data_rootFolder}
start_date=${start_date:="2000-01-01T00:00:00Z"}
            end_date=${end_date:="2000-01-01T02:30:00Z"}
calendar="360 day year"
checkpoint_interval="P100D"
restart_interval="PT1H"
output_interval="PT1H"
output_interval_3d="PT3H"
file_interval="P1H"
output_interval_day="P1D"
file_interval_day_avg="P10D"
atmo_namelist=NAMELIST_${EXPNAME}_atm
mpi_atm_io_procs=0                 # for atmosphere (2d and 3d, lnd and dyamond) (8+14
output_atm_vgrid=no                # produces 1 atm file
output_atm_debug=no                # produces 1 atm file
output_atm_3d=no                   # produces 2 atm file
output_atm_2d=no                   # produces 4 atm file
output_phy_3d=no                   # produces 1 atm file
output_trc_3d=no                   # produces 1 atm file
cat > ${atmo_namelist} << EOF
!
&parallel_nml
 nproma           = ${nproma}
 num_io_procs      = ${mpi_atm_io_procs}
! num_restart_procs = 1
 io_process_stride = 1
 io_proc_chunk_size = 31
/
&grid_nml
 dynamics_grid_filename = ${atmo_dyn_grids}
/
&run_nml
 num_lev          = 90          ! number of full levels
 modelTimeStep    = "PT15M"
 ltestcase        = .TRUE.      ! run testcase
 ldynamics        = .TRUE.      ! dynamics
 ltransport       = .TRUE.      ! transport
 iforcing         = 2           ! 0: none, 1: HS, 2: AES, 3: NWP
 output           = 'nml'
 msg_level        = 15          ! level of details report during integration
! restart_filename = "${EXPNAME}_restart_atm_<rsttime>.nc"
 activate_sync_timers = .TRUE.
/
&nh_testcase_nml
 nh_test_name     = 'APE_aes'
 ape_sst_case     = 'sst_qobs'
 zp_ape           = 101325
 ztmc_ape         = 25.006
/
&nonhydrostatic_nml
 ndyn_substeps    = 5           ! dtime/dt_dyn
 damp_height      = 50000.      ! [m]
 rayleigh_coeff   = 0.10
 vwind_offctr     = 0.2
divdamp_fac      = 0.004
/
&interpol_nml
 rbf_scale_mode_ll = 1
/
&sleve_nml
 min_lay_thckn    = 25.         ! [m]
 max_lay_thckn    = 400.   ! maximum layer thickness below htop_thcknlimit
 htop_thcknlimit  = 14000  ! this implies that the upcoming COSMO-EU nest will have 60 levels
 top_height       = 75000.      ! [m]
 stretch_fac      = 0.9
 decay_scale_1    = 4000.       ! [m]
 decay_scale_2    = 2500.       ! [m]
 decay_exp        = 1.2
 flat_height      = 16000.      ! [m]
/
&initicon_nml
 pinit_seed       = 0           ! seed for perturbation of initial model state. no perturbation by default
 pinit_amplitude  = 0.          ! amplitude of perturbation
/
&diffusion_nml
/
&transport_nml
 tracer_names     = 'hus','clw','cli', 'qr', 'qs', 'qg'
 ivadv_tracer     =    3 ,   3 ,   3 ,   3 ,   3 ,   3
 itype_hlimit     =    3 ,   4 ,   4 ,   4 ,   4 ,   4
 ihadv_tracer     =   20 ,  20 ,  20 ,  20 ,  20 ,  20
/
&aes_phy_nml
!
! domain 1
! --------
!
! atmospheric phyiscs (""=never)
 aes_phy_config(1)%dt_rad = "PT60M"
 aes_phy_config(1)%dt_vdf = "PT15M"
 aes_phy_config(1)%dt_mig = "PT15M"
!
! surface (.TRUE. or .FALSE.)
 aes_phy_config(1)%ljsb   = .FALSE.
 aes_phy_config(1)%lamip  = .FALSE.
 aes_phy_config(1)%lice   = .FALSE.
 aes_phy_config(1)%lmlo   = .FALSE.
 aes_phy_config(1)%llake  = .FALSE.
/
&aes_rad_nml
!
! domain 1
! --------
!
 aes_rad_config(1)%isolrad    =  2
 aes_rad_config(1)%cecc       = 0.0
 aes_rad_config(1)%cobld      = 0.0
 aes_rad_config(1)%irad_h2o   =  1
 aes_rad_config(1)%irad_co2   =  2
 aes_rad_config(1)%irad_ch4   =  0
 aes_rad_config(1)%irad_n2o   =  0
 aes_rad_config(1)%irad_o3    =  4
 aes_rad_config(1)%irad_o2    =  0
 aes_rad_config(1)%irad_cfc11 =  0
 aes_rad_config(1)%irad_cfc12 =  0
 aes_rad_config(1)%irad_aero  =  0
/
&aes_vdf_nml
 aes_vdf_config(1)%pr0        =  0.7
 aes_vdf_config(1)%turb       =  2     ! Smagorinsky
/
&aes_cop_nml
 aes_cop_config(1)%cn1lnd     =  50.0
 aes_cop_config(1)%cn2lnd     = 220.0
 aes_cop_config(1)%cn1sea     =  50.0
 aes_cop_config(1)%cn2sea     = 100.0
 aes_cop_config(1)%cinhomi    =   1.0
 aes_cop_config(1)%cinhoml1   =   0.66
 aes_cop_config(1)%cinhoml2   =   0.66
 aes_cop_config(1)%cinhoml3   =   0.66
/
&aes_mig_nml
 aes_mig_config(1)%mu_rain        = 0.5
 aes_mig_config(1)%rain_n0_factor = 0.1
 aes_mig_config(1)%v0snow         = 25.
! aes_mig_config(1)%zvz0i          = 3.29  ! Terminal fall velocity of ice  (original value of Heymsfield+Donner 1990: 3.29)
/
&aes_cov_nml
 aes_cov_config(1)%icov       = 3     ! 0/1 cloud cover based on cloud water and ice
 aes_cov_config(1)%cqx        = 1.e-6
/
EOF
add_link_file ${basedir}/externals/rte-rrtmgp/rrtmgp/data/rrtmgp-data-lw-g128-210809.nc         ./coefficients_lw.nc
add_link_file ${basedir}/externals/rte-rrtmgp/rrtmgp/data/rrtmgp-data-sw-g112-210809.nc         ./coefficients_sw.nc
add_link_file ${basedir}/data/ECHAM6_CldOptProps_rrtmgp_lw.nc           ./rrtmgp-cloud-optics-coeffs-lw.nc
add_link_file ${basedir}/data/ECHAM6_CldOptProps_rrtmgp_sw.nc           ./rrtmgp-cloud-optics-coeffs-sw.nc
cp ${atmo_namelist} ${basedir}/run/${atmo_namelist}
add_required_file ${basedir}/run/${atmo_namelist}                       ./
dict_file="dict.${EXPNAME}"
cat ${basedir}/run/dict.iconam.mpim  > ${dict_file}
cp ${dict_file} ${basedir}/run/${dict_file}
add_required_file ${basedir}/run/${dict_file}                           ./
start_year=$(( ${start_date%%-*} - 1 ))
end_year=$(( ${end_date%%-*} + 1 ))
datadir=${basedir}/ozone/
add_link_file ${datadir}/bc_ozone_ape.nc                                ./bc_ozone.nc
cat >> ${atmo_namelist} << EOF
&io_nml
 output_nml_dict  = "${dict_file}"
 netcdf_dict      = "${dict_file}"
 lnetcdf_flt64_output = .TRUE.
 itype_pres_msl   = 4
 restart_file_type= 5
 restart_write_mode = "joint procs multifile"    !not necessary/useful in default r2b4 setup
/
EOF
if [[ "$output_atm_vgrid" == "yes" ]]; then
  #
  cat >> ${atmo_namelist} << EOF
&output_nml
 output_filename  = "${EXPNAME}_atm_vgrid"
 filename_format  = "<output_filename>_<levtype_l>"
 filetype         = 5
 remap            = 0
 output_grid      = .TRUE.
 output_start     = "${start_date}"       ! output_start = output_end
 output_end       = "${start_date}"       ! --> write once only irrespective of
 output_interval  = "${output_interval}"  !     the output interval and
 file_interval    = "${file_interval}"    !     the file interval
 ml_varlist       = 'zghalf'  , 'zg'      , 'dzghalf'
/
EOF
fi
if [[ "$output_atm_3d" == "yes" ]]; then
  #
  cat >> ${atmo_namelist} << EOF
&output_nml
 output_filename  = "${EXPNAME}_atm_3d"
 filename_format  = "<output_filename>_<levtype_l>_<datetime2>"
 filetype         = 5
 remap            = 0
 reg_lon_def      = -180.,3600,180.
 reg_lat_def      = -90.,1800,90.
 m_levels         = "30...(nlev-1)"
 output_grid      = .TRUE.
 output_start     = "${start_date}"
 output_end       = "${end_date}"
 output_interval  = "${output_interval_3d}"
 file_interval    = "${file_interval}"
 include_last     = .FALSE.
 ml_varlist       = 'pfull'   , 'zg'      ,
                    'rho'     , 'ta'      ,
                    'ua'      , 'va'      , 'wap'     ,
                    'hus'     , 'clw'     , 'cli'     ,
                    'qr'      , 'qs'      , 'qg'      ,
                    'cl'      ,
/
&output_nml
 output_filename  = "${EXPNAME}_dayavg_atm_3d"
 filename_format  = "<output_filename>_<levtype_l>_<datetime2>"
 filetype         = 5
 remap            = 0
 operation        = 'mean'
 output_grid      = .FALSE.
 output_start     = "${start_date}"
 output_end       = "${end_date}"
 output_interval  = "${output_interval_day}"
 file_interval    = "${file_interval_day_avg}"
 include_last     = .FALSE.
 ml_varlist       = 'pfull' , 'rho'   , 'ta'  ,
                    'ua'    , 'va'    , 'wap' ,
                    'hus'   , 'clw'   , 'cli' ,
                    'qr'    , 'qs'    , 'qg'  ,
                    'cl'    , 'cptgz' , 'rsd' ,
                    'rsu'   , 'rld'   , 'rlu' ,
/
EOF
fi
if [[ "$output_atm_2d" == "yes" ]]; then
  #
  cat >> ${atmo_namelist} << EOF
&output_nml
 output_filename  = "${EXPNAME}_dayavg_atm_2d"
 filename_format  = "<output_filename>_<levtype_l>_<datetime2>"
 filetype         = 5
 remap            = 0
 operation        = 'mean'
 output_grid      = .FALSE.
 output_start     = "${start_date}"
 output_end       = "${end_date}"
 output_interval  = "${output_interval_day}"
 file_interval    = "${file_interval_day_avg}"
 include_last     = .FALSE.
 ml_varlist       = 'ps'      , 
                    'uas'     , 'vas'     , 'tas'     ,
/
EOF
fi
if [[ "$output_phy_3d" == "yes" ]]; then
  #
  cat >> ${atmo_namelist} << EOF
&output_nml
 output_filename  = "${EXPNAME}_phy_3d"
 filename_format  = "<output_filename>_<levtype_l>_<datetime2>"
 filetype         = 5
 remap            = 0
 output_grid      = .TRUE.
 output_start     = "${start_date}"
 output_end       = "${end_date}"
 output_interval  = "${output_interval}"
 file_interval    = "${file_interval}"
 include_last     = .FALSE.
 ml_varlist       = 'ps'           , 'pfull'        , 'zg'           ,
                    'tend_ta'      , 'tend_ta_dyn'  , 'tend_ta_phy'  ,
                    'tend_ta_rlw'  , 'tend_ta_rsw'  ,
                    'tend_ta_vdf'  , 'tend_ta_gwd'  ,
                    'tend_ta_cnv'  , 'tend_ta_cld'  ,
                    'tend_ua'      , 'tend_ua_dyn'  , 'tend_ua_phy'  ,
                    'tend_ua_vdf'  , 'tend_ua_gwd'  ,
                    'tend_ua_cnv'  ,
                    'tend_va'      , 'tend_va_dyn'  , 'tend_va_phy'  ,
                    'tend_va_vdf'  , 'tend_va_gwd'  ,
                    'tend_va_cnv'  ,
                    'tend_qhus'    , 'tend_qhus_dyn', 'tend_qhus_phy',
                    'tend_qhus_cld', 'tend_qhus_cnv', 'tend_qhus_vdf',
                    !'tend_qhus_mox'
/
EOF
fi
if [[ "$output_trc_3d" == "yes" ]]; then
  #
  cat >> ${atmo_namelist} << EOF
&output_nml
 output_filename  = "${EXPNAME}_trc_3d"
 filename_format  = "<output_filename>_<levtype_l>_<datetime2>"
 filetype         = 5
 remap            = 0
 output_grid      = .TRUE.
 output_start     = "${start_date}"
 output_end       = "${end_date}"
 output_interval  = "${output_interval}"
 file_interval    = "${file_interval}"
 include_last     = .FALSE.
 ml_varlist       = 'ps'        , 'pfull'     , 'zg'        ,
                    'mairvi_phy',
                    'mdryvi_phy',
                    'mh2ovi_phy',
                    'qhus_phy'  , 'mhusvi_phy', 'tend_mhusvi_phy',
                    'qclw_phy'  , 'mclwvi_phy', 'tend_mclwvi_phy',
                    'qcli_phy'  , 'mclivi_phy', 'tend_mclivi_phy',
/
EOF
fi
final_status_file=${basedir}/run/${job_name}.final_status
rm -f ${final_status_file}
RUNSCRIPTDIR=${basedir}/run
if [ x$grids_folder = x ] ; then
   HGRIDDIR=${basedir}/grids
else
   HGRIDDIR=$grids_folder
fi
make_and_change_to_experiment_dir
final_status_file=${RUNSCRIPTDIR}/${job_name}.final_status
rm -f ${final_status_file}
if [ x$namelist_list = x ]; then
  minrank_list[0]=0
  maxrank_list[0]=65535
  incrank_list[0]=1
  if [ x$atmo_namelist != x ]; then
    # this is the atmo model
    namelist_list[0]="$atmo_namelist"
    modelname_list[0]="atmo"
    modeltype_list[0]=1
    run_atmo="true"
  elif [ x$ocean_namelist != x ]; then
    # this is the ocean model
    namelist_list[0]="$ocean_namelist"
    modelname_list[0]="oce"
    modeltype_list[0]=2
  elif [ x$psrad_namelist != x ]; then
    # this is the psrad model
    namelist_list[0]="$psrad_namelist"
    modelname_list[0]="psrad"
    modeltype_list[0]=3
  elif [ x$hamocc_namelist != x ]; then
    # this is the hamocc model
    namelist_list[0]="$hamocc_namelist"
    modelname_list[0]="hamocc"
    modeltype_list[0]=4
  elif [ x$jsbach_namelist != x ]; then
    # this is the jsbach standalone model
    namelist_list[0]="$jsbach_namelist"
    modelname_list[0]="jsbach"
    modeltype_list[0]=5
    run_jsbach_standalone="true"
  elif [ x$testbed_namelist != x ]; then
    # this is the testbed model
    namelist_list[0]="$testbed_namelist"
    modelname_list[0]="testbed"
    modeltype_list[0]=99
  else
    check_error 1 "No namelist is defined"
  fi 
fi
restart=${restart:=".false."}
restartSemaphoreFilename='isRestartRun.sem'
if [ -f ${restartSemaphoreFilename} ]; then
  restart=.true.
  #  do not delete switch-file, to enable restart after unintended abort
  #[[ -f ${restartSemaphoreFilename} ]] && rm ${restartSemaphoreFilename}
fi
if [ "x$restart" != 'x.false.' -a "x$submit" != 'x' ]; then
  if [ x$(df -T ${EXPDIR} | cut -d ' ' -f 2) = gpfs ]; then
    sleep 10;
  fi
fi
run_atmo=${run_atmo="false"}
if [ x$atmo_namelist != x ]; then
  run_atmo="true"
  run_jsbach_standalone="false"
fi
run_jsbach=${run_jsbach="false"}
if [ x$jsbach_namelist != x ]; then
  run_jsbach="true"
fi
run_ocean=${run_ocean="false"}
if [ x$ocean_namelist != x ]; then
  run_ocean="true"
fi
run_psrad=${run_psrad="false"}
if [ x$psrad_namelist != x ]; then
  run_psrad="true"
fi
run_hamocc=${run_hamocc="false"}
if [ x$hamocc_namelist != x ]; then
  run_hamocc="true"
fi
all_grids="${atmo_dyn_grids} ${atmo_rad_grids} ${ocean_grids}"
for gridfile in ${all_grids}; do
  #
  gridfile=${gridfile//\'/} # strip all ' in case ' is used to delimit the grid names
  gridfile=${gridfile//\"/} # strip all " in case " is used to delimit the grid names
  gridfile=${gridfile//\,/} # strip all , in case , is used to separate the grid names
  #
  grfinfofile=${gridfile%.nc}-grfinfo.nc
  #
  ls -l ${HGRIDDIR}/$gridfile
  check_error $? "${HGRIDDIR}/$gridfile does not exist."
  add_link_file ${HGRIDDIR}/${gridfile} ./
  if [ -f ${HGRIDDIR}/${grfinfofile} ]; then    
    add_link_file ${HGRIDDIR}/${grfinfofile} ./
  fi
done
copy_required_files
link_required_files
if  [ x$restart_atmo_from != "x" ] ; then
  rm -f restart_atm_DOM01.nc
  cp ${basedir}/experiments/${restart_from_folder}/${restart_atmo_from} cp_restart_atm.nc
  ln -s cp_restart_atm.nc restart_atm_DOM01.nc
  restart=".true."
fi
if  [ x$restart_ocean_from != "x" ] ; then
  rm -f restart_oce.nc
  cp ${basedir}/experiments/${restart_from_folder}/${restart_ocean_from} cp_restart_oce_DOM01.nc
  ln -s cp_restart_oce_DOM01.nc restart_oce_DOM01.nc
  restart=".true."
fi
read_restart_namelists=${read_restart_namelists:=".true."}
if [ -z "$dont_create_icon_master_namelist" ]; then
  master_namelist=icon_master.namelist
  calendar=${calendar:="proleptic gregorian"}
  calendar_type=${calendar_type:=1}
  {
    echo "&master_nml"
    echo " lrestart               =  $restart"
    echo " read_restart_namelists =  $read_restart_namelists"
    echo "/"
    if [ -z "$nsteps" ]; then
      echo "&master_time_control_nml"
      echo " calendar             = '$calendar'"
      echo " experimentStartDate  = '$start_date'"
      # echo " restartTimeIntval    = '$restart_interval'"
      # echo " checkpointTimeIntval = '$checkpoint_interval'"
      if [ -n "$end_date" ]; then
        echo " experimentStopDate = '$end_date'"
      fi
      echo "/"
      echo "&time_nml"
      echo " is_relative_time     = .false."
      echo "/"
    else # $nsteps is set -> use time_nml:ini_datetime_string
      echo "&time_nml"
      echo " calendar             =  $calendar_type"
      echo " ini_datetime_string  = '$start_date'"
      echo " dt_restart           =  $dt_restart"
      echo "/"
    fi
  } > $master_namelist
fi
add_component_to_master_namelist()
{
  model_namelist_filename=$1
  if [ x${dont_create_icon_master_namelist+set} != xset ]; then
    model_name=$2
    model_type=$3
    model_min_rank=$4
    model_max_rank=$5
    model_inc_rank=$6
    model_rank_group_size=$7
    cat >> $master_namelist << EOF
&master_model_nml
  model_name="$model_name"
  model_namelist_filename="$model_namelist_filename"
  model_type=$model_type
  model_min_rank=$model_min_rank
  model_max_rank=$model_max_rank
  model_inc_rank=$model_inc_rank
  model_rank_group_size=$model_rank_group_size
/
EOF
  fi
  #-----------
  #get namelist
  if [ -f ${RUNSCRIPTDIR}/$model_namelist_filename ] ; then
    mv -f ${RUNSCRIPTDIR}/$model_namelist_filename ${EXPDIR}
    check_error $? "mv -f ${RUNSCRIPTDIR}/$model_namelist_filename ${EXPDIR}"
  else
    check_error 1 "${RUNSCRIPTDIR}/$model_namelist_filename does not exist"
  fi
}
no_of_models=${#namelist_list[*]}
echo "no_of_models=$no_of_models"
rank_group_size=1
j=0
while [ $j -lt ${no_of_models} ]
do
  add_component_to_master_namelist "${namelist_list[$j]}" "${modelname_list[$j]}" ${modeltype_list[$j]} ${minrank_list[$j]} ${maxrank_list[$j]} ${incrank_list[$j]} ${rank_group_size}
  j=`expr ${j} + 1`
done
if [[ $run_jsbach == @(yes|true) ]]; then
  cat >> $master_namelist << EOF
&jsb_control_nml
 is_standalone      = .${run_jsbach_standalone:=false}.
 restart_jsbach     = ${restart}
 debug_level        = 0
 timer_level        = 0
EOF
if [[ ${run_jsbach_standalone} == true ]]; then
  cat >> $master_namelist << EOF
 l_force_from_obs   = .${l_force_from_obs:-false}.
EOF
fi
  cat >> $master_namelist << EOF
/
EOF
if [[ -n ${atmo_dyn_grids} ]]; then
  no_of_domains=${#atmo_dyn_grids[@]}
else
  no_of_domains=1
fi
echo "no_of_domains=$no_of_domains"
domain=""
domain_suffix=""
j=1
while [ $j -le ${no_of_domains} ]
do
  if [[ $no_of_domains -gt 1 ]]; then
    # no_of_domains < 10 !
    domain=" DOM0${j}"
    domain_suffix="_d${j}"
  fi
  cat >> $master_namelist << EOF
&jsb_model_nml
 model_id = $j
 model_name = "JSBACH${domain}"
 model_shortname = "jsb${domain_suffix}"
 model_description = 'JSBACH land surface model'
 model_namelist_filename = "${jsbach_namelist}${domain_suffix}"
/
EOF
  if [[ ${run_jsbach_standalone} != true ]]; then
    if [[ -f ${RUNSCRIPTDIR}/${jsbach_namelist}${domain_suffix} ]] ; then
      mv ${RUNSCRIPTDIR}/${jsbach_namelist}${domain_suffix} ${EXPDIR}
      check_error $? "mv ${RUNSCRIPTDIR}/${jsbach_namelist}${domain_suffix}"
    else
      check_error 1 "${RUNSCRIPTDIR}/${jsbach_namelist}${domain_suffix} does not exist"
    fi
  fi
  j=`expr ${j} + 1`
done
fi
ls -l ${MODEL}
check_error $? "${MODEL} does not exist?"
ldd ${MODEL}
rm -f finish.status
date
set -x
${START} ${MODEL}
set +x
date
if [ -r finish.status ] ; then
  check_final_status 0 "${START} ${MODEL}"
else
  check_final_status -1 "${START} ${MODEL}"
fi
finish_status=`cat finish.status`
echo $finish_status
echo "============================"
echo "Script run successfully: $finish_status"
echo "============================"
finish_status="DO NOT RESTART"
if [[ "x$use_hamocc" = "xyes" ]]; then
strg="$(ls -rt ${EXPNAME}_hamocc_EU*.nc* | tail -1 )"
prefx="${EXPNAME}_hamocc_EU_tendencies"
foo=${strg##${prefx}}
foo=${foo%%.*}
bgcout_file="bgcout_${foo}"
mv bgcout $bgcout_file
fi
namelist_list=""
if [ "$finish_status" = "RESTART" ] ; then
  echo "restart next experiment..."
  this_script="${RUNSCRIPTDIR}/${job_name}"
  echo 'this_script: ' "$this_script"
  touch ${restartSemaphoreFilename}
  cd ${RUNSCRIPTDIR}
  ${submit} $this_script $run_param_0
else
  [[ -f ${restartSemaphoreFilename} ]] && rm ${restartSemaphoreFilename}
fi
if [ "x${autoPostProcessing}" = "xtrue" ]; then
  # check if there is a postprocessing is available
  cd ${RUNSCRIPTDIR}
  targetPostProcessingScript="./post.${EXPNAME}.run"
  [[ -x $targetPostProcessingScript ]] && ${submit} ${targetPostProcessingScript}
  cd -
fi
cd $RUNSCRIPTDIR
exit 0
