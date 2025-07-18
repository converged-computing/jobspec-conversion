#!/bin/bash
#FLUX: --job-name=placid-noodle-5308
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
MEMO="solo.bubble.nhK"
TYPE="nh"          # choices:  nh, hydro (affects USE_COND and MOIST_CAPPA)
GRID="d96_2k"
MODE="64bit"      # choices:  32bit, 64bit
MONO="non-mono"        # choices:  mono, non-mono
HYPT="on"         # choices:  on, off  (controls hyperthreading)
COMP="repro"       # choices:  debug, repro, prod
WORKDIR=${SCRATCHDIR:-${BUILDDIR}}/CI/BATCH-CI/${GRID}.${MEMO}/
executable=${BUILDDIR}/Build/bin/SOLO_hydro.${COMP}.${MODE}.${COMPILER}.x
    # dycore definitions
    npx="97"
    npy="97"
    npz="63"
    layout_x="2"
    layout_y="2"
    io_layout="1,1"
    nthreads="2"
    # doubly-periodic domain
    dd_const=2000.
    # time step parameters
    k_split="1"
    n_split="6"
    dt_atmos="15"
    # blocking factor used for threading and general physics performance
    blocksize="16"
    # run length
    months="0"
    days="0"
    hours="2"
    minutes="0"
    seconds="0"
    nruns="1"
    # set variables in input.nml for initial run
    mountain=".F."
    external_ic=".F."
    warm_start=".F."
    add_noise=0.1
    curr_date="0,0,0,0"
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
    if [ ${TYPE} = "nh" ] ; then
      # non-hydrostatic options
      make_nh=".T."
      hydrostatic=".F."
      consv_te="0." # Use 0 in doubly-periodic
    else
      # hydrostatic options
      make_nh=".F."
      hydrostatic=".T."
      consv_te="0." # use 0 in doubly-periodic
    fi
    if [ ${MONO} = "mono" ] || [ ${MONO} = "monotonic" ] ; then
      # monotonic options
      d_con="1."
      do_vort_damp=".false."
      vtdm4="0.00"
      if [ ${TYPE} = "nh" ] ; then
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
      dddmp=0
    else
      # non-monotonic options
      d_con="1."
      do_vort_damp=".true."
      if [ ${TYPE} = "nh" ] ; then
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
"atmos_hifreq",              5,  "minutes",  1, "seconds",  "time"
"atmos_hifreq_ave",          5,  "minutes",  1, "seconds",  "time"
 "dynamics", "grid_lon", "grid_lon", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_lat", "grid_lat", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_lont", "grid_lont", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "grid_latt", "grid_latt", "grid_spec", "all", .false.,  "none", 2,
 "dynamics", "area",     "area",     "grid_spec", "all", .false.,  "none", 2,
 "dynamics",  "vort850",        "VORT850",       "atmos_hifreq", "all", .false.,  "none", 2
 "dynamics",  "tq",          "PWAT",        "atmos_hifreq", "all", .false., "none", 2
 "dynamics",  "lw",          "VIL",         "atmos_hifreq", "all", .false., "none", 2
 "dynamics",  "iw",          "iw",          "atmos_hifreq", "all", .false., "none", 2
 "dynamics",  "ps",          "PRESsfc",     "atmos_hifreq", "all", .false., "none", 2
 "dynamics", "max_reflectivity",  "REFC",    "atmos_hifreq","all",.false., "none", 2
 "dynamics", "base_reflectivity", "REFD1km", "atmos_hifreq","all",.false., "none", 2
 "dynamics",  "echo_top",    "RETOP",        "atmos_hifreq", "all",.false., "none", 2
 "dynamics",  "ctz",         "HGTctp",      "atmos_hifreq", "all", .false., "none", 2
"dynamics",  "ucomp",        "ucomp",        "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "vcomp",        "vcomp",        "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "temp",         "temp",         "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "delp",        "delp",         "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "sphum",       "sphum",         "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "pfnh",         "nhpres",       "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "ppnh",         "nhpres_pert",  "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "w",            "w",            "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "delz",         "delz",         "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "ps",           "ps",           "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "reflectivity", "reflectivity", "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "qp",       "qp",      "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "qn",       "qn",      "atmos_hifreq",  "all",  .false.,  "none",  2
 "dynamics",  "uh25",             "MXUPHL2_5km",     "atmos_hifreq_ave", "all", max, "none", 2
 "dynamics",  "uh25",             "MNUPHL2_5km",     "atmos_hifreq_ave", "all", min, "none", 2
 "dynamics",  "wmaxup",           "MAXUVV",          "atmos_hifreq_ave", "all", max, "none", 2
 "dynamics",  "wmaxdn",           "MAXDVV",          "atmos_hifreq_ave", "all", min, "none", 2
 "dynamics",  "prec",             "prec",            "atmos_hifreq_ave", "all", sum,  "none", 2
 "dynamics",  "cond",             "condensation",    "atmos_hifreq_ave", "all", sum, "none", 2
 "dynamics",  "evaporation",      "evaporation",     "atmos_hifreq_ave", "all", sum, "none", 2
 "dynamics", "t_dt_gfdlmp",  "t_dt_gfdlmp",  "atmos_hifreq_ave",  "all",  .true.,  "none",  2
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
       grid_type = 4
       dx_const = ${dd_const}
       dy_const = ${dd_const}
       deglat   = 0.
    !Solver options
       k_split  = $k_split
       n_split  = $n_split
       z_tracer = .T.
       hydrostatic = $hydrostatic
       nwat = 6
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
       nudge_qv = .T.
       external_ic = ${external_ic}
       is_ideal_case = .T.
       add_noise = ${add_noise}
       mountain = $mountain
    !Damping options
       nord =  2
       d4_bg = 0.12
       do_vort_damp = $do_vort_damp
       vtdm4 = $vtdm4
       delt_max = 0.01
       d_con = ${d_con}
       dddmp = ${dddmp}
       d_ext = 0.0
    !Upper boundary options
       n_sponge = 4
       fv_sg_adj = 900
       tau =  1.0
       rf_cutoff = 20.e2
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
       do_inline_mp = .T.
       do_sat_adj = .F.
/
&test_case_nml ! cold start
    test_case = 17
    bubble_do = .T.
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
 &gfdl_mp_nml
       do_sedi_heat = .true.
       rad_snow = .true.
       rad_graupel = .true.
       rad_rain = .true.
       const_vi = .false.
       const_vs = .false.
       const_vg = .false.
       const_vr = .false.
       vi_fac = 1.
       vs_fac = 1.
       vg_fac = 1.
       vr_fac = 1.
       vi_max = 1.
       vs_max = 2.
       vg_max = 12.
       vr_max = 12.
       !qi_lim = 1.
       prog_ccn = .false.
       !do_qa = .true.
       tau_l2v = 180.
       tau_v2l =  90.
       rthresh = 10.e-6  ! This is a key parameter for cloud water
       dw_land  = 0.16
       dw_ocean = 0.10
       ql_gen = 1.0e-3
       ql_mlt = 1.0e-3
       qi0_crt = 8.0E-5
       qs0_crt = 1.0e-3
       tau_i2s = 1000.
       c_psaci = 0.05
       c_pgacs = 0.01
       rh_inc = 0.30
       rh_inr = 0.30
       rh_ins = 0.30
       ccn_l = 300.
       ccn_o = 200.
       c_paut = 0.5
       z_slope_liq  = .true.
       z_slope_ice  = .true.
       fix_negative = .true.
       icloud_f = 0
/
EOF
${run_cmd} | tee fms.out || exit
