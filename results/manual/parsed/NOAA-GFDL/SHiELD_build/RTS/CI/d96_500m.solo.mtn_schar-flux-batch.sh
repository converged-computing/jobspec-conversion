#!/bin/bash
#FLUX: --job-name=chunky-milkshake-9986
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
MEMO="solo.mtn_schar"
TYPE="nh"          # choices:  nh, hydro (affects USE_COND and MOIST_CAPPA)
MODE="64bit"      # choices:  32bit, 64bit
MONO="non-mono"        # choices:  mono, non-mono
GRID="d96_500m"
HYPT="on"         # choices:  on, off  (controls hyperthreading)
COMP="repro"       # choices:  debug, repro, prod
WORKDIR=${SCRATCHDIR:-${BUILDDIR}}/CI/BATCH-CI/${GRID}.${MEMO}/
executable=${BUILDDIR}/Build/bin/SOLO_${TYPE}.${COMP}.${MODE}.${COMPILER}.x
    # dycore definitions
    npx="385"
    npy="5"
    npz="40"
    layout_x="4"
    layout_y="1"
    io_layout="1,1"
    nthreads="4"
    # doubly-periodic domain
    dd_const=500.
    # time step parameters
    k_split="2"
    n_split="12"
    dt_atmos="15"
    # blocking factor used for threading and general physics performance
    blocksize="16"
    # run length
    months="0"
    days="0"
    hours="5"
    minutes="0"
    seconds="0"
    #initialization options
    # set the pre-conditioning of the solution
    # =0 implies no pre-conditioning
    # >0 means new adiabatic pre-conditioning
    # <0 means older adiabatic pre-conditioning
    na_init=0
    print_freq="-15"
    # variables for gfs diagnostic output intervals and time to zero out time-accumulated data
    # set various debug options
    no_dycore=".F."
    # set variables in input.nml for initial run
    mountain=".F."
    external_ic=".F."
    warm_start=".F."
    add_noise=0.0
    curr_date="0,0,0,0"
    if [ ${TYPE} = "nh" ]; then
      # non-hydrostatic options
      make_nh=".T."
      hydrostatic=".F."
      consv_te="0." # Use 0 in doubly-periodic
    else
      # hydrostatic options
      make_nh=".F."
      hydrostatic=".T."
      consv_te="0." # Use 0 in doubly-periodic
    fi
    if [ ${MONO} = "mono" ] || [ ${MONO} = "monotonic" ] ; then
      # monotonic options
      d_con="1."
      do_vort_damp=".false."
      vtdm4="0.00"
      if [ ${TYPE}="nh" ] ; then
        # non-hydrostatic
        hord_mt=" 8"
        hord_xx=" 8"
        hord_tr=" 8"
      else
        # hydrostatic
        hord_mt=" 10"
        hord_xx=" 10"
        hord_tr=" 10"
      fi
      kord=9
      dddmp=0.
    else
      # non-monotonic options
      d_con="1.0"
      do_vort_damp=".true."
      if [ ${TYPE}="nh" ] ; then
        # non-hydrostatic
        hord_mt=" 5"
        hord_xx=" 5"
        hord_tr="-5"
        vtdm4="0.06"
      else
        # hydrostatic
        hord_mt=" 5"
        hord_xx=" 5"
        hord_tr="-5"
        vtdm4="0.06"
      fi
        kord=11
        dddmp=0.2
    fi
if [ ${HYPT} = "on" ] ; then
  hyperthread=".true."
  div=2
else
  hyperthread=".false."
  div=1
fi
skip=`expr ${nthreads} \/ ${div}`
npes=`expr ${layout_x} \* ${layout_y}`
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
${GRID}.${MEMO}
0 0 0 0 0 0
"grid_spec",              -1,  "months",   1, "days",  "time"
"atmos_static",           -1,  "hours",    1, "hours", "time"
"atmos_hourly",            1,  "hours",    1, "hours", "time"
 "dynamics", "grid_lon", "grid_lon", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_lat", "grid_lat", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_lont", "grid_lont", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_latt", "grid_latt", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "area",     "area",     "grid_spec", "all", .false.,  "none", 2,
 "dynamics",  "ucomp",   "ucomp",      "atmos_hourly",  "all",  .false.,  "none",  2
 "dynamics",  "vcomp",   "vcomp",      "atmos_hourly",  "all",  .false.,  "none",  2
 "dynamics",  "temp",    "temp",      "atmos_hourly",  "all",  .false.,  "none",  2
 "dynamics",  "pfnh",   "pfnh",      "atmos_hourly",  "all",  .false.,  "none",  2
 "dynamics",  "delp",   "delp",      "atmos_hourly",  "all",  .false.,  "none",  2
 "dynamics",  "delz",   "delz",      "atmos_hourly",  "all",  .false.,  "none",  2
 "dynamics",  "hght",   "hght",      "atmos_hourly",  "all",  .false.,  "none",  2
 "dynamics",  "w",       "w",         "atmos_hourly",  "all",  .false.,  "none",  2
 "dynamics",  "ps",          "ps",     "atmos_hourly", "all", .false., "none", 2
 "dynamics",      "pk",          "pk",           "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "bk",          "bk",           "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "hyam",        "hyam",         "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "hybm",        "hybm",         "atmos_static",      "all", .false.,  "none", 2
 "dynamics",      "zsurf",       "zsurf",          "atmos_static",      "all", .false.,  "none", 2
EOF
cat > field_table <<EOF
 "TRACER", "atmos_mod", "sphum"
           "longname",     "specific humidity"
           "units",        "kg/kg"
       "profile_type", "fixed", "surface_value=1.e30" /
EOF
cat > input.nml <<EOF
 &atmos_model_nml
     blocksize = $blocksize
     chksum_debug = .false.
/
&diag_manager_nml
     flush_nc_files = .false.
     prepend_date = .F.
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
       domains_stack_size = 10000000,
       print_memory_usage = .F.
/
 &fv_grid_nml
!       grid_file = 'INPUT/grid_spec.nc'
/
 &fv_core_nml
    !Domain and layout parameters
       layout   = $layout_x,$layout_y
       io_layout = $io_layout
       npx      = $npx
       npy      = $npy
       ntiles   = 1,
       npz    = $npz
       npz_type = 'lowtop'
       grid_type = 4
       dx_const = ${dd_const}
       dy_const = ${dd_const}
       deglat   = 0.
    !Solver options
       k_split  = $k_split
       n_split  = $n_split
       z_tracer = .T.
       hydrostatic = $hydrostatic
       nwat = 0
       dnats = 1
       hord_mt = $hord_mt
       hord_vt = $hord_xx
       hord_tm = $hord_xx
       hord_dp = $hord_xx
       hord_tr = $hord_tr
       kord_tm = -${kord}
       kord_mt =  ${kord}
       kord_wz =  ${kord}
       kord_tr =  ${kord}
    !Initialization options
       make_nh = $make_nh
       na_init = $na_init
       nudge_qv = .F.
       external_ic = ${external_ic}
       is_ideal_case = .T.
       add_noise = ${add_noise}
       mountain = $mountain
    !Damping options
       nord =  3
       d4_bg = 0.15
       do_vort_damp = ${do_vort_damp}
       vtdm4 = 0.03
       delt_max = 0.01
       d_con = ${d_con}
       dddmp = ${dddmp}
       d_ext = 0.0
    !Upper boundary options
       n_sponge = 0
       fv_sg_adj = -1
       tau =  1.0
       rf_cutoff = 250.e2
       d2_bg_k1 = 0.2
       d2_bg_k2 = 0.1
     !Physics options
       consv_te = $consv_te
       fill = .T.
       phys_hydrostatic = .F.
    !Debugging and diagnostics
       print_freq = $print_freq
       warm_start = $warm_start
       no_dycore = $no_dycore
       fv_debug = .F.
       range_warn = .F.
/
 &integ_phys_nml
       do_inline_mp = .F.
       do_sat_adj = .F.
/
&gfdl_mp_nml
/
&test_case_nml ! cold start
    test_case = 21
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
EOF
${run_cmd} | tee fms.out || exit
