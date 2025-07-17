#!/bin/bash
#FLUX: --job-name=outstanding-nunchucks-4755
#FLUX: --queue=haswell
#FLUX: -t=28800
#FLUX: --urgency=16

export VENDOR_DIR='/usr/projects/draco/vendors'
export CXX='`which mpiicpc`'
export CC='`which mpiicc`'
export FC='`which mpiifort`'
export MPIEXEC='`which mpirun`'
export OMP_NUM_THREADS='8'
export OMP_PROC_BIND='true'
export work_dir='${base_dir}/${subproj}/${dashboard_type}_${comp}/${build_type}'
export scratch_dir='${scratch_dir}/${subproj}/${dashboard_type}_${comp}/${build_type}'

if test "${subproj}x" == "x"; then
   echo "Fatal Error, subproj not found in environment."
   exit 1
fi
if test "${regdir}x" == "x"; then
   echo "Fatal Error, regdir not found in environment."
   exit 1
fi
if test "${build_type}x" == "x"; then
   echo "Fatal Error, build_type not found in environment."
   exit 1
fi
if test "${logdir}x" == "x"; then
   echo "Fatal Error, logdir not found in environment."
   exit 1
fi
umask 0002
ulimit -a
unset http_proxy
unset HTTP_PROXY
unset https_proxy
unset HTTPS_PROXY
export VENDOR_DIR=/usr/projects/draco/vendors
moniker=`whoami`
fn_exists()
{
    type $1 2>/dev/null | grep -q 'is a function'
    res=$?
    echo $res
    return $res
}
run () {
    echo $1
    if ! [ $dry_run ]; then eval $1; fi
}
machine=`uname -n`
case $machine in
cn*)
    ctestparts=Configure,Build,Test
    # Force new log file (vs appending)
    echo "     " > ${logdir}/darwin-${build_type}-${extra_params}${epdash}${subproj}-cbt.log
    ;;
darwin-*)
    ctestparts=Submit ;;
esac
echo "==========================================================================="
echo "Darwin regression: ${ctestparts} from ${machine}."
echo "                   ${subproj}-${build_type}${epdash}${extra_params}"
echo "==========================================================================="
run "ulimit -a"
run "module use --append /usr/projects/draco/vendors/Modules"
run "module purge &> /dev/null"
run "module load intel/15.0.3 impi/5.1.1.109"
run "module load cmake/3.5.1 numdiff/5.8.1 subversion random123 eospac/6.2.4"
run "module load ndi ParMetis/4.0.3 SuperLU_DIST/4.1 trilinos/12.0.1"
run "module list"
export CXX=`which mpiicpc`
export CC=`which mpiicc`
export FC=`which mpiifort`
export MPIEXEC=`which mpirun`
export OMP_NUM_THREADS=8
export OMP_PROC_BIND=true
comp=`basename $CXX`
printenv
case $extra_params in
"")
    # no-op
    ;;
cuda)
    run "module load cudatoolkit/5.0"
    comp="intel-cuda"
    ;;
*)
    echo "FATAL ERROR"
    echo "Extra parameter = ${extra_param} requested but is unknown to"
    echo "the regression system."
    exit 1
    ;;
esac
run "module list"
if test "${dashboard_type}x" = "x"; then
   dashboard_type=Nightly
fi
if test "${base_dir}x" = "x"; then
  if test "${regress_mode}" = "off"; then
    scratch_dir=/mnt/local/hdd1/${moniker}/cdash/darwin
    base_dir=${scratch_dir}
  else
    scratch_dir=/usr/projects/draco/regress/cdash/darwin
    base_dir=/usr/projects/draco/regress/cdash/darwin
    #scratch_dir=/mnt/local/hdd1/draco-regress/cdash/darwin
    #base_dir=/projects/opt/draco/regress/cdash/darwin
  fi
  mkdir -p $scratch_dir
  mkdir -p $base_dir
  if ! test -d ${scratch_dir}; then
    echo "Fatal Error, scratch_dir=${scratch_dir} not found.."
    exit 1
  fi
fi
echo " "
echo "darwin-regress.msub: dashboard_type = $dashboard_type"
echo "darwin-regress.msub: base_dir       = $base_dir"
echo "darwin-regress.msub: build_type     = $build_type"
echo "darwin-regress.msub: comp           = $comp"
echo "darwin-regress.msub: machine        = $machine"
echo "darwin-regress.msub: subproj        = $subproj"
echo "darwin-regress.msub: regdir         = $regdir"
if test "${subproj}" == draco; then
    script_dir=${regdir}/draco/regression
    script_name=Draco_Linux64.cmake
elif test "${subproj}" == jayenne; then
    script_dir=${regdir}/jayenne/regression
    script_name=Jayenne_Linux64.cmake
elif test "${subproj}" == capsaicin; then
    script_dir=${regdir}/capsaicin/scripts
    script_name=Capsaicin_Linux64.cmake
elif test "${subproj}" == asterisk; then
    script_dir=${regdir}/asterisk/regression
    script_name=Asterisk_Linux64.cmake
fi
export work_dir=${base_dir}/${subproj}/${dashboard_type}_${comp}/${build_type}
export scratch_dir=${scratch_dir}/${subproj}/${dashboard_type}_${comp}/${build_type}
echo "darwin-regress.msub: work_dir       = ${work_dir}"
echo "darwin-regress.msub: scratch_dir    = ${scratch_dir}"
echo " "
setup_dirs=`echo $ctestparts | grep Configure`
if ! test "${setup_dirs}x" = "x"; then
   if ! test -d ${work_dir}/source; then
      run "/usr/bin/install -d ${work_dir}/source"
   fi
   # See notes above where scratch_dir is set concerning why these
   # are soft links.
   if ! test -d ${scratch_dir}/build; then
      run "/usr/bin/install -d ${scratch_dir}/build"
   fi
   if ! test -d ${work_dir}/build; then
      run "ln -s ${scratch_dir}/build ${work_dir}/build"
   fi
   if ! test -d ${scratch_dir}/target; then
      run "/usr/bin/install -d ${scratch_dir}/target"
   fi
   if ! test -d ${work_dir}/target; then
      run "ln -s ${scratch_dir}/target ${work_dir}/target"
   fi
   # clean the installation directory to remove any files that might
   # no longer be generated.
   if test -d ${work_dir}/target/lib; then
       run "rm -rf ${work_dir}/target/*"
   fi
   if test -f ${work_dir}/build/CMakeCache.txt; then
       run "rm -rf ${work_dir}/build/*"
   fi
fi
echo " "
echo "--------------------(environment)------------------------------"
set
echo "--------------------(end environment)--------------------------"
echo ctest -VV -S ${script_dir}/${script_name},${dashboard_type},${build_type},${ctestparts}
ctest -VV -S ${script_dir}/${script_name},${dashboard_type},${build_type},${ctestparts}
echo "All done."
