#!/bin/bash
#FLUX: --job-name=bumfuzzled-spoon-5837
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
res=768
MEMO="sw.BTwave" # trying repro executable
TYPE="sw"         # choices:  nh, hydro
MODE="64bit"      # choices:  32bit, 64bit
GRID="C$res"
HYPT="on"         # choices:  on, off  (controls hyperthreading)
COMP="repro"       # choices:  debug, repro, prod
WORKDIR=${SCRATCHDIR:-${BUILDDIR}}/CI/BATCH-CI/${GRID}.${MEMO}/
executable=${BUILDDIR}/Build/bin/SOLO_${TYPE}.${COMP}.${MODE}.${COMPILER}.x
    # dycore definitions
    npx="769"
    npy="769"
    npz="1" #Shallow water
    layout_x="8"
    layout_y="8"
    io_layout="1,1" #Want to increase this in a production run??
    nthreads="2"
    # run length
    days="7"
    hours="0"
    minutes="0"
    seconds="0"
    dt_atmos="1200"
    # set variables in input.nml for initial run
    na_init=0 # TRY 1
    curr_date="0,0,0,0"
    make_nh=".F."
    hydrostatic=".T."
    phys_hydrostatic=".F."     # will be ignored in hydro mode
    use_hydro_pressure=".T."   # have to be .T. in hydro mode
    consv_te="0."
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
cat > field_table <<EOF
 "TRACER", "atmos_mod", "sphum"
           "longname",     "specific humidity"
           "units",        "kg/kg"
           "profile_type", "fixed", "surface_value=3.e-6" /
EOF
cat > diag_table << EOF
${GRID}.${MODE}
0 0 0 0 0 0
"grid_spec",    -1,  "hours",  1, "days", "time",
"atmos_daily",  0,  "hours",  1, "days", "time",
"dynamics", "grid_lon", "grid_lon", "grid_spec", "all", .false.,  "none", 2,
"dynamics", "grid_lat", "grid_lat", "grid_spec", "all", .false.,  "none", 2,
"dynamics", "area", "area", "grid_spec", "all", .false.,  "none", 2,
"dynamics", "ps_ic", "ps_ic",   "atmos_daily", "all", .false.,  "none", 2,
"dynamics", "ps",    "ps",      "atmos_daily", "all", .false.,  "none", 2,
"dynamics", "ua_ic", "ua_ic",   "atmos_daily", "all", .false.,  "none", 2,
"dynamics", "va_ic", "va_ic",   "atmos_daily", "all", .false.,  "none", 2,
"dynamics", "ucomp", "ucomp",   "atmos_daily", "all", .false.,  "none", 2,
"dynamics", "vcomp", "vcomp",   "atmos_daily", "all", .false.,  "none", 2,
"dynamics", "vort", "vort",   "atmos_daily", "all", .false.,  "none", 2,
"dynamics", "pv", "pv",   "atmos_daily", "all", .false.,  "none", 2,
"dynamics", "delp", "delp",   "atmos_daily", "all", .false.,  "none", 2,
"dynamics", "sphum", "sphum",   "atmos_daily", "all", .false.,  "none", 2,
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
 &fms_affinity_nml
    affinity = .false.
/
 &fms_io_nml
       checksum_required   = .false.
/
 &fms_nml
       clock_grain = 'ROUTINE',
       domains_stack_size = 20000000,
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
       beta = 0.
       n_split = 32
       k_split = 2
       nwat = 0
       na_init = $na_init
       nord = 2
       d4_bg = 0.12
       mountain = .F.
       hord_mt = 8
       hord_vt = 8
       hord_tm = 8
       hord_dp = 8
       hord_tr = 8
       print_freq = 24
       warm_start = .F.
       do_schmidt = .false.
       adiabatic = .true.
       external_ic = .F. !COLD START
       is_ideal_case = .T.
/
 &test_case_nml
    test_case = 7
    alpha = 0.
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
