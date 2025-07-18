#!/bin/bash
#FLUX: --job-name=sticky-chair-0429
#FLUX: -n=24
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
res=96
MEMO="solo.mtn_rest.nonmono.diff2" # name of test
TYPE="nh"         # choices:  nh, hydro
MODE="64bit"      # choices:  32bit, 64bit
GRID="C$res"
HYPT="on"          # choices:  on, off  (controls hyperthreading)
COMP="repro"       # choices:  debug, repro, prod
WORKDIR=${SCRATCHDIR:-${BUILDDIR}}/CI/BATCH-CI/${GRID}.${MEMO}/
executable=${BUILDDIR}/Build/bin/SOLO_${TYPE}.${COMP}.${MODE}.${COMPILER}.x
    # dycore definitions
    npx="97"
    npy="97"
    npz="30"
    layout_x="2"
    layout_y="2"
    io_layout="1,1" #Want to increase this in a production run??
    nthreads="2"
    # run length
    days="4"
    hours="0"
    minutes="0"
    seconds="0"
    dt_atmos="1800"
    # set variables in input.nml for initial run
    ecmwf_ic=".F."
    mountain=".F."
    external_ic=".F."
    warm_start=".F."
    na_init=0
    curr_date="0,0,0,0"
if [ ${TYPE} = "nh" ]; then
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
    run_cmd="${LAUNCHER} -prepend-rank -np $npes $CONTAINER ./${executable##*/}"
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
"atmos_4xdaily",            6, "hours",  1, "days",  "time"
 "dynamics", "grid_lon", "grid_lon", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_lat", "grid_lat", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_lont", "grid_lont", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_latt", "grid_latt", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "area",     "area",     "grid_spec", "all", .false.,  "none", 2,
 "dynamics",  "ucomp",   "ucomp",      "atmos_4xdaily",  "all",  .false.,  "none",  2
 "dynamics",  "vcomp",   "vcomp",      "atmos_4xdaily",  "all",  .false.,  "none",  2
 "dynamics",  "temp",    "temp",      "atmos_4xdaily",  "all",  .false.,  "none",  2
 "dynamics",  "pfnh",   "pfnh",      "atmos_4xdaily",  "all",  .false.,  "none",  2
 "dynamics",  "delp",   "delp",      "atmos_4xdaily",  "all",  .false.,  "none",  2
 "dynamics",  "delz",   "delz",      "atmos_4xdaily",  "all",  .false.,  "none",  2
 "dynamics",  "hght",   "hght",      "atmos_4xdaily",  "all",  .false.,  "none",  2
 "dynamics",  "omega",   "omega",      "atmos_4xdaily",  "all",  .false.,  "none",  2
 "dynamics",  "w",       "w",         "atmos_4xdaily",  "all",  .false.,  "none",  2
 "dynamics",  "omg500",    "omg500",       "atmos_4xdaily", "all", .false.,  "none", 2
 "dynamics",  "w500",        "w500",       "atmos_4xdaily", "all", .false.,  "none", 2
 "dynamics",  "temp500",  "temp500",       "atmos_4xdaily", "all", .false.,  "none", 2
 "dynamics",  "ps",          "ps",     "atmos_4xdaily", "all", .false., "none", 2
 "dynamics",      "pk",          "pk",           "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "bk",          "bk",           "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "hyam",        "hyam",         "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "hybm",        "hybm",         "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "zsurf",       "zsurf",          "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "area",        "area",     "atmos_static", "all", .false.,  "none", 2,
EOF
cat > field_table << EOF
 "TRACER", "atmos_mod", "sphum"
           "longname",     "specific humidity"
           "units",        "kg/kg"
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
/
 &fms_nml
       clock_grain = 'ROUTINE',
       domains_stack_size = 16000000,
       print_memory_usage = .false.
/
 &fv_core_nml
       layout   = $layout_x,$layout_y
       io_layout = $io_layout
       npx      = $npx
       npy      = $npy
       ntiles   = 6
       npz    = $npz
       grid_type = 0
       make_nh = $make_nh
       fv_debug = .F.
       range_warn = .T.
       reset_eta = .F.
       sg_cutoff = -1
       fv_sg_adj = -1
       nudge_qv = .F.
       RF_fast = .F.
       tau_h2o = 0.
       tau = -1
       rf_cutoff = -1
       d2_bg_k1 = 0.20
       d2_bg_k2 = 0.06 ! z2: increased
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
       nwat = 0
       na_init = $na_init
       d_ext = 0.0
       dnats = 0
       d2_bg = 0.
       nord = 3
       dddmp = 0.0
       d4_bg = 0.15
       do_vort_damp = .F.
       external_ic = .F. !COLD START
       mountain = .F.
       hord_mt = 5
       hord_vt = 5
       hord_tm = 5
       hord_dp = 5
       hord_tr = -5
       adjust_dry_mass = .F.
       consv_te = 0.
       do_sat_adj = .F.
       do_inline_mp = .F.
       fill = .F.
       dwind_2d = .F.
       print_freq = 6
       warm_start = $warm_start
       z_tracer = .T.
       fill_dp = .T.
/
&fv_diag_plevs_nml
    nplev=7
    levs = 50,200,300,500,700,850,1000
    levs_ave = 10,100,300,500,700,850,1000
/
&test_case_nml
    test_case = 52
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
    do_qa = .false.
/
 &sim_phys_nml
  do_GFDL_sim_phys = .F.
/
EOF
${run_cmd} | tee fms.out || exit
