#!/bin/bash
#FLUX: --job-name=hairy-peas-3676
#FLUX: -n=384
#FLUX: --urgency=16

export OMP_STACKSIZE='256m'

if [ -z ${BUILDDIR} ] ; then
  echo -e "\nERROR:\tset BUILDDIR to the base path /<path>/SHiELD_build/ \n"
  exit 99
fi
if [ -z "$1" ] ; then
  CONTAINER=""
else
  CONTAINER=$1
  echo -e "\nThis test will be run inside of a container with the command $1"
fi
COMPILER=${COMPILER:-intel}
. ${BUILDDIR}/site/environment.${COMPILER}.sh
set -x
export OMP_STACKSIZE=256m
res=512r20
MEMO="solo.superC"
TYPE="nh"         # choices:  nh, hydro
MODE="64bit"      # choices:  32bit, 64bit
GRID="C$res"
HYPT="on"         # choices:  on, off  (controls hyperthreading)
COMP="repro"       # choices:  debug, repro, prod
WORKDIR=${SCRATCHDIR:-${BUILDDIR}}/CI/BATCH-CI/${GRID}.${MEMO}/
executable=${BUILDDIR}/Build/bin/SOLO_${TYPE}.${COMP}.${MODE}.${COMPILER}.x
    # dycore definitions
    npx="513"
    npy="513"
    npz="50"
    layout_x="8"
    layout_y="8"
    io_layout="1,1" #Want to increase this in a production run??
    nthreads="2"
    # run length
    days="0"
    hours="0"
    minutes="30"
    seconds="0"
    dt_atmos="15"
    # set variables in input.nml for initial run
    ecmwf_ic=".F."
    mountain=".F."
    external_ic=".F."
    warm_start=".F."
    na_init=1
    curr_date="0,0,0,0"
if [ ${TYPE} = "nh" ] ; then
  # non-hydrostatic options
  make_nh=".T."
  hydrostatic=".F."
  phys_hydrostatic=".F."     # can be tested
  use_hydro_pressure=".F."   # can be tested
  consv_te="1."
else
  # hydrostatic options
  make_nh=".F."
  hydrostatic=".T."
  phys_hydrostatic=".F."     # will be ignored in hydro mode
  use_hydro_pressure=".T."   # have to be .T. in hydro mode
  consv_te="0."
fi
if [ ${HYPT} = "on" ] ; then
  hyperthread=".true."
  div=2
else
  hyperthread=".false."
  div=1
fi
skip=`expr ${nthreads} \/ ${div}`
npes=`expr ${layout_x} \* ${layout_y} \* 6 `
LAUNCHER=${LAUNCHER:-srun}
if [ ${LAUNCHER} = 'srun' ] ; then
    export SLURM_CPU_BIND=verbose
    run_cmd="${LAUNCHER} --label --ntasks=$npes --cpus-per-task=$skip $CONTAINER ./${executable##*/}"
else
    export MPICH_ENV_DISPLAY=YES
    run_cmd="${LAUNCHER} -np $npes $CONTAINER ./${executable##*/}"
fi
\rm -rf $WORKDIR
mkdir -p $WORKDIR
cd $WORKDIR
mkdir -p RESTART
mkdir -p INPUT
cp $executable .
touch data_table
cat > diag_table << EOF
${GRID}.${MODE}
0 0 0 0 0 0
"grid_spec",     -1,  "days",  1, "days", "time",
"atmos_1min",  1,  "minutes", 1, "days", "time",
"atmos_1min_ave",  1,  "minutes", 1, "days", "time",
"atmos_5min",  5,  "minutes", 1, "days", "time",
"dynamics", "grid_lon", "grid_lon", "grid_spec", "all", .false.,  "none", 2,
"dynamics", "grid_lat", "grid_lat", "grid_spec", "all", .false.,  "none", 2,
"dynamics",  "ps",     "ps",      "atmos_1min", "all", .false.,  "none", 2,
"dynamics",  "tb",     "tb",      "atmos_1min", "all", .false.,  "none", 2,
"dynamics",  "qn",     "qn",      "atmos_1min", "all", .false.,  "none", 2,
"dynamics",  "qp",     "qp",      "atmos_1min", "all", .false.,  "none", 2,
"dynamics",  "prec",        "prec", "atmos_1min_ave", "all", sum,  "none", 2
"dynamics", "ps",    "ps",       "atmos_5min", "all", .false.,  "none", 2,
"dynamics", "lw",     "lw",      "atmos_5min", "all", .false.,  "none", 2,
"dynamics", "u850", "u850",  "atmos_5min", "all", .false.,  "none", 2,
"dynamics", "v850", "v850",  "atmos_5min", "all", .false.,  "none", 2,
"dynamics", "w850", "w850",  "atmos_5min", "all", .false.,  "none", 2,
"dynamics", "vort850", "vort850",  "atmos_5min", "all", .false.,  "none", 2,
 "dynamics", "w",     "w",       "atmos_5min", "all", .false.,  "none", 2,
 "dynamics", "temp",    "temp",    "atmos_5min", "all", .false.,  "none", 2,
 "dynamics", "rainwat", "rainwat", "atmos_5min", "all", .false.,  "none", 2,
 "dynamics", "liq_wat", "liq_wat", "atmos_5min", "all", .false.,  "none", 2,
 "dynamics", "uh25", "uh25", "atmos_5min", "all", .false.,  "none", 2
EOF
cat > field_table <<EOF
 "TRACER", "atmos_mod", "sphum"
           "longname",     "specific humidity"
           "units",        "kg/kg"
       "profile_type", "fixed", "surface_value=1.e30" /
 "TRACER", "atmos_mod", "liq_wat"
           "longname",     "cloud water mixing ratio"
           "units",        "kg/kg"
       "profile_type", "fixed", "surface_value=1.e30" /
 "TRACER", "atmos_mod", "rainwat"
           "longname",     "rain mixing ratio"
           "units",        "kg/kg"
       "profile_type", "fixed", "surface_value=1.e30" /
 "TRACER", "atmos_mod", "ice_wat"
           "longname",     "cloud ice mixing ratio"
           "units",        "kg/kg"
       "profile_type", "fixed", "surface_value=1.e30" /
 "TRACER", "atmos_mod", "snowwat"
           "longname",     "snow mixing ratio"
           "units",        "kg/kg"
       "profile_type", "fixed", "surface_value=1.e30" /
 "TRACER", "atmos_mod", "graupel"
           "longname",     "graupel mixing ratio"
           "units",        "kg/kg"
       "profile_type", "fixed", "surface_value=1.e30" /
 "TRACER", "atmos_mod", "o3mr"
           "longname",     "ozone mixing ratio"
           "units",        "kg/kg"
       "profile_type", "fixed", "surface_value=1.e30" /
 "TRACER", "atmos_mod", "cl"
           "longname",     "cl"
           "units",        "kg/kg"
       "profile_type", "fixed", "surface_value=1.e30" /
 "TRACER", "atmos_mod", "cl2"
           "longname",     "cl2"
           "units",        "kg/kg"
       "profile_type", "fixed", "surface_value=1.e30" /
 "TRACER", "atmos_mod", "cld_amt"
           "longname",     "cloud amount"
           "units",        "1"
       "profile_type", "fixed", "surface_value=1.e30" /
EOF
if [[ -x $(command -v data-table-to-yaml) ]] ; then
  data-table-to-yaml -f data_table
  field-table-to-yaml -f field_table
else
  echo "You must first install fms_yaml_tools prior to running this executable"
  echo "To do this: you will need Python3 installed, then:"
  echo "git clone https://github.com/NOAA-GFDL/fms_yaml_tools.git"
  echo "python3 -m pip install --target=./installdir ./fms_yaml_tools"
  echo "add the location of the install to your PATH"
  exit
fi
cat > input.nml <<EOF
 &diag_manager_nml
    flush_nc_files = .false.
    prepend_date = .F.
! this diag table creates a lot of files
! next three lines are necessary
    max_num_axis_sets = 100
    max_files = 100
    max_axes = 240
    !do_diag_field_log = .T.
/
 &fms_affinity_nml
    affinity = .false.
/
 &fms_io_nml
       checksum_required   = .false.
       max_files_r = 100,
       max_files_w = 100,
/
 &fms_nml
       clock_grain = 'ROUTINE',
       domains_stack_size = 16000000,
       print_memory_usage = .false.
/
 &fv_grid_nml
!       grid_file = 'INPUT/grid_spec.nc'
/
 &fv_core_nml
       layout   = $layout_x,$layout_y
       io_layout = $io_layout
       npx      = $npx
       npy      = $npy
       ntiles   = 6
       npz    = $npz
       npz_type = 'superC'
       grid_type = 0
       make_nh = $make_nh
       fv_debug = .F.
       range_warn = .F.
       w_limiter = .F.
       reset_eta = .F.
       n_sponge = 0
       nudge_qv = .F.
       RF_fast = .F.
       tau_h2o = 0.
       tau = -1
       rf_cutoff = -1
       d2_bg_k1 = 0.20
       d2_bg_k2 = 0.10
       kord_tm = -9
       kord_mt = 9
       kord_wz = 9
       kord_tr = 9
       hydrostatic = $hydrostatic
       phys_hydrostatic = $phys_hydrostatic
       use_hydro_pressure = $use_hydro_pressure
       beta = 0.
       a_imp = 1.
       p_fac = 0.05
       k_split = 1
       n_split = 12
       nwat = 6
       na_init = 0
       d_ext = 0.0
       dnats = 0
       fv_sg_adj = -1
       d2_bg = 0.
       nord = 1
       dddmp = 0.5
       d4_bg = 0.15
       vtdm4 = 0.005
       delt_max = 0.002
       convert_ke = .F.
       ke_bg = 0.
       do_vort_damp = .T.
       external_ic = .F. !COLD START
       is_ideal_case = .T.
       mountain = .F.
       d_con = 1.0
       hord_mt = 8
       hord_vt = 8
       hord_tm = 8
       hord_dp = 8
       hord_tr = 8
       adjust_dry_mass = .F.
       consv_te = 0.
       consv_am = .F.
       fill = .F.
       dwind_2d = .F.
       print_freq = -4
       warm_start = $warm_start
       z_tracer = .T.
       fill_dp = .F.
       adiabatic = .F. !this is important
       do_Held_Suarez = .F.
       do_schmidt = .true.
       target_lat = 35.4
       target_lon = 262.4
       stretch_fac = 20.       ! 1000-m
/
 &integ_phys_nml
       do_inline_mp = .T.
       do_sat_adj = .F.
/
&test_case_nml
    test_case = 30
/
 &main_nml
       days  = $days
       hours = $hours
       minutes = $minutes
       seconds = $seconds
       dt_atmos = $dt_atmos
       current_time =  $curr_date
       atmos_nthreads = $nthreads
       use_hyper_thread = $hyperthread
/
 &external_ic_nml
       filtered_terrain = .T.
       levp = 64
       gfs_dwinds = .T.
       checker_tr = .F.
       nt_checker = 0
/
 &gfdl_mp_nml
       do_sedi_heat = .false.
       do_sedi_w = .false.
       prog_ccn = .false.
       tau_l2v = 45.
       do_warm_rain_mp = .T.
       rthresh = 6.e-6
       dw_ocean = 0.10
       rh_inc = 0.0
       rh_inr = 0.0
       rh_ins = 0.3 !not used
       ccn_l = 300.
       ccn_o = 100.
       z_slope_liq  = .false.
       z_slope_ice  = .false.
       fix_negative = .true.
       icloud_f = 0
       do_cond_timescale = .false.
/
!# From LJZ mar 2019
 &cld_eff_rad_nml
       reiflag        = 4
        rewmin = 5.0
        rewmax = 10.0
        reimin = 10.0
        reimax = 150.0
/
EOF
${run_cmd} | tee fms.out || exit
