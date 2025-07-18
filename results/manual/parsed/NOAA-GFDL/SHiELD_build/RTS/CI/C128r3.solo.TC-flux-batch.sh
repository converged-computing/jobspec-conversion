#!/bin/bash
#FLUX: --job-name=gassy-kerfuffle-0724
#FLUX: -n=96
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
MEMO="solo.TC" # trying repro executable
res=128r3
TYPE="nh"         # choices:  nh, hydro
MODE="64bit"      # choices:  32bit, 64bit
GRID="C$res"
HYPT="on"         # choices:  on, off  (controls hyperthreading)
COMP="repro"       # choices:  debug, repro, prod
WORKDIR=${SCRATCHDIR:-${BUILDDIR}}/CI/BATCH-CI/${GRID}.${MEMO}/
executable=${BUILDDIR}/Build/bin/SOLO_${TYPE}.${COMP}.${MODE}.${COMPILER}.x
    # dycore definitions
    npx="129"
    npy="129"
    npz="63"
    layout_x="4"
    layout_y="4"
    io_layout="1,1" #Want to increase this in a production run??
    nthreads="2"
    # run length
    days="1"
    hours="0"
    minutes="0"
    seconds="0"
    dt_atmos="600"
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
"grid_spec",              -1,  "months",   1, "days",  "time"
"atmos_static",           -1,  "hours",    1, "hours", "time"
"atmos_4xdaily",           6, "hours",  1, "days",  "time"
"atmos_4xdaily_ave",       6, "hours",  1, "days",  "time"
 "dynamics", "grid_lon", "grid_lon", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_lat", "grid_lat", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_lont", "grid_lont", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_latt", "grid_latt", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "area",     "area",     "grid_spec", "all", .false.,  "none", 2,
 "dynamics",  "vort850",        "vort850",       "atmos_4xdaily", "all", .false.,  "none", 2
 "dynamics",  "u850",        "u850",       "atmos_4xdaily", "all", .false.,  "none", 2
 "dynamics",  "v850",        "v850",       "atmos_4xdaily", "all", .false.,  "none", 2
 "dynamics",  "us",          "us",        "atmos_4xdaily", "all", .false., "none", 2
 "dynamics",  "vs",          "vs",        "atmos_4xdaily", "all", .false., "none", 2
 "dynamics",  "tb",          "tb",        "atmos_4xdaily", "all", .false., "none", 2
 "dynamics",  "tq",          "PWAT",        "atmos_4xdaily", "all", .false., "none", 2
 "dynamics",  "lw",          "VIL",         "atmos_4xdaily", "all", .false., "none", 2
 "dynamics",  "iw",          "iw",          "atmos_4xdaily", "all", .false., "none", 2
 "dynamics",  "ps",          "PRESsfc",     "atmos_4xdaily", "all", .false., "none", 2
 "dynamics",  "ctp",         "PRESctp",      "atmos_4xdaily", "all", .false., "none", 2
 "dynamics",  "tm",          "TMP500_300", "atmos_4xdaily", "all", .false.,  "none", 2
 "dynamics",  "cond",        "condensation", "atmos_4xdaily", "all", .false.,  "none", 2
 "dynamics",  "reevap",      "evaporation", "atmos_4xdaily", "all", .false.,  "none", 2
 "dynamics",  "prec",        "prec", "atmos_4xdaily_ave", "all", .true.,  "none", 2
 "dynamics",  "wmaxup",      "wmaxup", "atmos_4xdaily_ave", "all", "max",  "none", 2
 "dynamics",      "pk",          "pk",           "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "bk",          "bk",           "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "hyam",        "hyam",         "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "hybm",        "hybm",         "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "zsurf",       "HGTsfc",          "atmos_static",      "all", .false.,  "none", 2
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
 "TRACER", "atmos_mod", "cld_amt"
           "longname",     "cloud amount"
           "units",        "1"
       "profile_type", "fixed", "surface_value=1.e30" /
EOF
cat > input.nml <<EOF
 &diag_manager_nml
    !flush_nc_files = .false.
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
       !grid_file = 'INPUT/grid_spec.nc'
/
 &fv_core_nml
       layout   = $layout_x,$layout_y
       io_layout = $io_layout
       npx      = $npx
       npy      = $npy
       ntiles   = 6
       npz    = $npz
       npz_type = 'gfs'
       grid_type = 0
       make_nh = $make_nh
       fv_debug = .F.
       range_warn = .T.
       reset_eta = .F.
       sg_cutoff = 150.e2 !replaces old "n_sponge"
       fv_sg_adj = 3600
       nudge_qv = .T.
       RF_fast = .F.
       tau_h2o = 0.
       tau = 10.
       rf_cutoff = 30.e2
       d2_bg_k1 = 0.20
       d2_bg_k2 = 0.10 ! z2: increased
       kord_tm = -8
       kord_mt = 8
       kord_wz = 8
       kord_tr = 8
       hydrostatic = $hydrostatic
       phys_hydrostatic = $phys_hydrostatic
       use_hydro_pressure = $use_hydro_pressure
       beta = 0.
       a_imp = 1.
       p_fac = 0.05
       k_split = 2
       n_split = 8
       nwat = 6
       na_init = $na_init
       d_ext = 0.0
       dnats = 1
       d2_bg = 0.
       nord = 3 ! z8: 2 --> 3
       dddmp = 0.5
       d4_bg = 0.15 ! z8: increased with nord change
       vtdm4 = 0.06 ! z10: increased
       delt_max = 0.002
       convert_ke = .true.
       ke_bg = 0.
       do_vort_damp = .T.
       external_ic = .F. !COLD START
       is_ideal_case = .T.
       mountain = .F.
       d_con = 1.
       hord_mt = 5
       hord_vt = 5
       hord_tm = 5
       hord_dp = -5
       hord_tr = -5 ! z2: changed
       adjust_dry_mass = .F.
       consv_te = 0.0
       fill = .F.
       dwind_2d = .F.
       print_freq = 6
       warm_start = $warm_start
       z_tracer = .T.
       fill_dp = .T.
       adiabatic = .F.
       do_cube_transform = .true. !Replaces do_schmidt
       target_lat = 17.5
       target_lon = 172.5
       stretch_fac = 3.0
/
 &integ_phys_nml
       do_inline_mp = .T.
       do_sat_adj = .F.
/
&fv_diag_plevs_nml
    nplev=7
    levs = 50,200,300,500,700,850,1000
    levs_ave = 10,100,300,500,700,850,1000
/
&test_case_nml ! cold start
    test_case = 55
/
 &sim_phys_nml
  do_reed_sim_phys = .T.
!  do_gfdl_sim_phys = .T.
/
&reed_sim_phys_nml
   do_reed_cond = .F.
   reed_test = 0 !uniform SST
/
&gfdl_sim_phys_nml
  sst0 = 302.15
  !mixed_layer = .T.
  uniform_sst = .T.
  !do_abl = .T.
  do_mon_obkv = .T.
/
 &ocean_rough_nml
        do_highwind = .T.
        do_cap40 = .T.
        v10m = 32.5
        v10n = 17.5
        do_init = .T.
        zcoh1 = 0.
        zcoq1 = 0. !  1.3e-4
        rough_scheme = 'beljaars'
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
       do_sedi_heat = .F.
       do_sedi_w = .F.
       rad_snow = .true.
       rad_graupel = .true.
       rad_rain = .true.
       const_vi = .F.
       const_vs = .F.
       const_vg = .F.
       const_vr = .F.
       vi_max = 1.
       vs_max = 2.
       vg_max = 16.
       vr_max = 16.
       qi_lim = 1.
       prog_ccn = .false.
       do_qa = .true.
       tau_l2v = 300.
       tau_v2l = 90. ! z7: enabled
       do_cond_timescale = .true. ! z7: enabled
       rthresh = 10.e-6  !   10.e-6  ! This is a key parameter for cloud water
      dw_land  = 0.15
      dw_ocean = 0.10
       ql_gen = 1.0e-3
    ql_mlt = 2.0e-3
    qs_mlt = 1.e-6
       qi0_crt = 8.E-5
       qs0_crt = 3.0e-3
       tau_i2s = 1000.
       c_psaci = 0.05
       c_pgacs = 0.01
       rh_inc = 0.0
       rh_inr = 0.0
       rh_ins = 0.0
       ccn_l = 300.
       ccn_o = 100.
       c_paut =  0.55
       z_slope_liq  = .T.
       z_slope_ice  = .T.
       fix_negative = .true.
       irain_f = 0
       icloud_f = 0
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
