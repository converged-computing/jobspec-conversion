#!/bin/bash
#FLUX: --job-name=goodbye-snack-8951
#FLUX: --urgency=16

usage ()
{
  cat 2>&1 << EOF
  Usage: $myname model_dir
  Required:
    model_dir : path to model dir of WW3 source
EOF
}
  if [ ! $# = 0 ]
  then
    main_dir="$1" ; shift
  else
    usage
    exit 1
  fi
  main_dir="`cd $main_dir 1>/dev/null 2>&1 && pwd`"
  modnetcdf='netcdf/4.7.4'
  modjasper='jasper/2.0.25'
  modzlib='zlib/1.2.11'
  modpng='libpng/1.6.37'
  modhdf5='hdf5/1.10.6'
  modbacio='bacio/2.4.1'
  modg2='g2/3.4.5'
  modw3emc='w3emc/2.9.2'
  modesmf='esmf/8.3.0b09'
  ishera=`hostname | grep hfe`
  isorion=`hostname | grep Orion`
  if [ $ishera ]
  then
    # If no other h, assuming Hera
    batchq='slurm'
    basemodcomp='intel/2022.1.2'
    basemodmpi='impi/2022.1.2'
    hpcstackpath='/scratch1/NCEPDEV/nems/role.epic/hpc-stack/libs/intel-2022.1.2/modulefiles/stack'
    hpcstackversion='hpc/1.2.0'
    modcomp='hpc-intel/2022.1.2'
    modmpi='hpc-impi/2022.1.2'
    scotchpath='/scratch1/NCEPDEV/climate/Matthew.Masarik/waves/opt/hpc-stack/scotch-v7.0.3/install'
    metispath='/scratch1/NCEPDEV/climate/Matthew.Masarik/waves/opt/hpc-stack/parmetis-4.0.3/install'
    modcmake='cmake/3.20.1'
  elif [ $isorion ]
  then
    batchq='slurm'
    basemodcomp='intel/2022.1.2'
    basemodmpi='impi/2022.1.2'
    hpcstackpath='/work/noaa/epic-ps/hpc-stack/libs/intel/2022.1.2/modulefiles/stack'
    hpcstackversion='hpc/1.2.0'
    modcomp='hpc-intel/2022.1.2'
    modmpi='hpc-impi/2022.1.2'
    scotchpath='/work2/noaa/marine/mmasarik/waves/opt/hpc-stack/scotch-v7.0.3/install'
    metispath='/work2/noaa/marine/mmasarik/waves/opt/hpc-stack/parmetis-4.0.3/install'
    modcmake='cmake/3.22.1'
  else
    batchq=
  fi
  export np='24'      #number of mpi tasks
  export npl='140'    #number of mpi tasks for ufs applications and large setups
  export npl1='100'   #number of mpi tasks for ufs/large setups (b4b check)
  export nr='4'       #number of mpi tasks for hybrid
  export nth='6'      #number of threads
  export nth1='4'     #number of threads (b4b check)
  echo '#!/bin/sh --login'                                   > matrix.head
  echo ' '                                                  >> matrix.head
  if [ $batchq = "slurm" ] && [ $isorion ]
  then
    echo "#SBATCH -n ${np}"                                 >> matrix.head
    echo "##SBATCH --cpus-per-task=${nth}"                  >> matrix.head
    echo '#SBATCH -q batch'                                 >> matrix.head
    echo '#SBATCH -t 08:00:00'                              >> matrix.head
    echo '#SBATCH -A marine-cpu'                            >> matrix.head
    echo '#SBATCH -J ww3_regtest'                           >> matrix.head
    echo '#SBATCH -o matrix.out'                            >> matrix.head
    echo '#SBATCH -p orion'                                 >> matrix.head
    echo '#SBATCH --exclusive'                              >> matrix.head
    echo ' '                                                >> matrix.head
    echo 'ulimit -s unlimited'                              >> matrix.head
    echo 'ulimit -c 0'                                      >> matrix.head
    echo 'export KMP_STACKSIZE=2G'                          >> matrix.head
    echo 'export FI_OFI_RXM_BUFFER_SIZE=128000'             >> matrix.head
    echo 'export FI_OFI_RXM_RX_SIZE=64000'                  >> matrix.head
  elif [ $batchq = "slurm" ]
  then
    echo "#SBATCH -n ${np}"                                 >> matrix.head
    echo "##SBATCH --cpus-per-task=${nth}"                  >> matrix.head
    echo '#SBATCH -q batch'                                 >> matrix.head
    echo '#SBATCH -t 08:00:00'                              >> matrix.head
    echo '#SBATCH -A marine-cpu'                            >> matrix.head
    echo '#SBATCH -J ww3_regtest'                           >> matrix.head
    echo '#SBATCH -o matrix.out'                            >> matrix.head
  else
    echo '#PBS -l procs=24'                                 >> matrix.head
    echo '#PBS -q batch'                                    >> matrix.head
    echo '#PBS -l walltime=08:00:00'                        >> matrix.head
    echo '#PBS -A marine-cpu'                               >> matrix.head
    echo '#PBS -N ww3_regtest'                              >> matrix.head
    echo '#PBS -j oe'                                       >> matrix.head
    echo '#PBS -o matrix.out'                               >> matrix.head
  fi
  echo ' '                                                  >> matrix.head
  echo "  cd $(dirname $main_dir)/regtests"                 >> matrix.head
  echo ' '                                                  >> matrix.head
  echo "  module purge"                                     >> matrix.head
  echo "  module load $modcmake"                            >> matrix.head
  if [ ! -z $basemodcomp ]; then
    echo "  module load $basemodcomp"                       >> matrix.head
  fi
  if [ ! -z $basemodmpi ]; then
    echo "  module load $basemodmpi"                        >> matrix.head
  fi
  echo "  module use  $hpcstackpath"                        >> matrix.head
  echo "  module load $hpcstackversion"                     >> matrix.head
  echo "  module load $modcomp"                             >> matrix.head
  echo "  module load $modmpi"                              >> matrix.head
  echo "  module load $modpng"                              >> matrix.head
  echo "  module load $modzlib"                             >> matrix.head
  echo "  module load $modjasper"                           >> matrix.head
  echo "  module load $modhdf5"                             >> matrix.head
  echo "  module load $modnetcdf"                           >> matrix.head
  echo "  module load $modbacio"                            >> matrix.head
  echo "  module load $modg2"                               >> matrix.head
  echo "  module load $modw3emc"                            >> matrix.head
  echo "  module load $modesmf"                             >> matrix.head
  echo "  export METIS_PATH=${metispath}"                   >> matrix.head
  echo "  export SCOTCH_PATH=${scotchpath}"                 >> matrix.head
  echo "  export path_build_root=$(dirname $main_dir)/regtests/buildmatrix" >> matrix.head
  echo '  [[ -d ${path_build_root} ]] && rm -rf ${path_build_root}'         >> matrix.head
  echo ' '
  if [ "$batchq" = 'slurm' ]
  then
    export  mpi='srun'
  else
    export  mpi='mpirun'
  fi
  opt="-o all -S -T"
  if [ "$batchq" = 'slurm' ]
  then
     opt="-b $batchq $opt"
  fi
  export rtst="./bin/run_cmake_test $opt"
  export  ww3='../model'
  export       shrd='y' # Do shared architecture tests
  export       dist='y' # Do distributed architecture (MPI) tests
  export        omp='y' # Threaded (OpenMP) tests
  export       hybd='y' # Hybrid options
  export     prop1D='y' # 1-D propagation tests (ww3_tp1.X)
  export     prop2D='y' # 2-D propagation tests (ww3_tp2.X)
  export       time='y' # time linmited growth
  export      fetch='y' # fetch linmited growth
  export     hur1mg='y' # Hurricane with one moving grid
  export      shwtr='y' # shallow water tests
  export      unstr='y' # unstructured grid tests
  export      pdlib='y' # unstr with pdlib for domain decomposition and implicit solver
  export      smcgr='y' # SMC grid test
  export        rtd='y' # Rotated pole test
  export     mudice='y' # Mud/Ice and wave interaction tests
  export     infgrv='y' # Second harmonic generation tests
  export       uost='y' # ww3_ts4 Unresolved Obstacles Source Term (UOST)
  export      assim='y' # Restart spectra update
  export      oasis='y' # Atmosphere, ocean, and ice coupling using OASIS
  export   calendar='y' # Calendar type
  export   confignc='y' # Configurable netCDF meta data (ww3_ounf)
  export    multi01='y' # mww3_test_01 (wetting and drying)
  export    multi02='y' # mww3_test_02 (basic two-way nesting test))
  export    multi03='y' # mww3_test_03 (three high and three low res grids).
  export    multi04='y' # mww3_test_04 (swell on sea mount and/or current)
  export    multi05='y' # mww3_test_05 (three-grid moving hurricane)
  export    multi06='y' # mww3_test_06 (curvilinear grid tests)
  export    multi07='y' # mww3_test_07 (unstructured grid tests)
  export    multi08='y' # mww3_test_08 (wind and ice tests)
  export    multi09='y' # mww3_test_09 (SMC multi grid test)
  export        ufs='y' # The Unified Forecast System
  export  ufscoarse='y' # Option for small PCs
  export       grib='y' # grib file field output
  export  rstrt_b4b='y' # Restart Reproducibility
  export    npl_b4b='y' # MPI task Reproducibility
  export    nth_b4b='y' # Thread Reproducibility
  export       esmf='n' # ESMF coupling
                      # The filter does a set of consecutive greps on the
                      # command lines generated by filter.base with the above
                      # selected options.
  $main_dir/../regtests/bin/matrix.base
  $main_dir/../regtests/bin/matrix_divider_cmake.sh
  echo "#submit all of the diveded matrix files" > msuball.sh
  if [ $batchq = "slurm" ]
  then
    files=`ls matrix??`
    for file in $files
    do
      echo "sbatch < $file"  >> msuball.sh
    done
  fi
