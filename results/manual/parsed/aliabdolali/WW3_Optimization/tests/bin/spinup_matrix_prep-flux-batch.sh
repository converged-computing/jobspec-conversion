#!/bin/bash
#FLUX: --job-name=ornery-lettuce-5837
#FLUX: --urgency=16

export HOME_PATH='${HOME}'
export OPTDIR='${MAIN}'
export WW3_DIR='$( pwd -P )/model'
export WW3_BINDIR='${WW3_DIR}/bin'
export WW3_TMPDIR='${WW3_DIR}/tmp'
export WW3_EXEDIR='${WW3_DIR}/exe'
export WWATCH3_ENV='${WW3_BINDIR}/wwatch3.env'
export WW3_COMP='intel'
export WW3_CC='icc'
export WW3_F90='ifort'
export PRINTER='printer'

HOME=${PWD}
MAIN=${PWD%/*}
export HOME_PATH="${HOME}"
export OPTDIR="${MAIN}"
set +x
  cmplr=intel
  export cmplOption='y'
  ishera=`hostname | grep hfe`
  isorion=`hostname | grep Orion`
  if [ $ishera ]
  then
    # If no other h, assuming Hera 
    cmplr='hera.intel'
    batchq='slurm'
    hpcstackpath='/scratch2/NCEPDEV/nwprod/hpc-stack/libs/hpc-stack/modulefiles/stack'
    hpcstackversion='hpc/1.1.0'
    modcomp='hpc-intel/18.0.5.274'
    modmpi='hpc-impi/2018.0.4'
    modnetcdf='netcdf/4.7.4'
    metispath='/scratch2/COASTAL/coastal/save/Ali.Abdolali/hpc-stack/parmetis-4.0.3'
    modjasper='jasper/2.0.25'
    modzlib='zlib/1.2.11'
    modpng='png/1.6.35'
    modhdf5='hdf5/1.10.6'
    modbacio='bacio/2.4.1'
    modg2='g2/3.4.1'
    modw3nco='w3nco/2.4.1'
    modesmf='esmf/8_1_1'
  elif [ $isorion ]
  then
    cmplr='intel'
    batchq='slurm'
    hpcstackpath='/apps/contrib/NCEP/libs/hpc-stack/modulefiles/stack'
    hpcstackversion='hpc/1.1.0'
    modcomp='hpc-intel/2019.5'
    modmpi='hpc-impi/2019.6'
    modnetcdf='netcdf/4.7.4'
    metispath='/work/noaa/marine/ali.abdolali/Source/hpc-stack/parmetis-4.0.3'
    modjasper='jasper/2.0.25'
    modzlib='zlib/1.2.11'
    modpng='png/1.6.35'
    modhdf5='hdf5/1.10.6'
    modbacio='bacio/2.4.1'
    modg2='g2/3.4.1'
    modw3nco='w3nco/2.4.1'
    modesmf='esmf/8_1_1'
  else
    batchq=
  fi
set -x 
set +x
cd $OPTDIR/WW3
export WW3_DIR=$( pwd -P )/model
export WW3_BINDIR="${WW3_DIR}/bin"
export WW3_TMPDIR=${WW3_DIR}/tmp
export WW3_EXEDIR=${WW3_DIR}/exe
export WWATCH3_ENV=${WW3_BINDIR}/wwatch3.env
export WW3_COMP=intel
export WW3_CC=icc
export WW3_F90=ifort
export PRINTER=printer
rm  $WWATCH3_ENV
echo '#'                                              > $WWATCH3_ENV
echo '# ---------------------------------------'      >> $WWATCH3_ENV
echo '# Environment variables for wavewatch III'      >> $WWATCH3_ENV
echo '# ---------------------------------------'      >> $WWATCH3_ENV
echo '#'                                              >> $WWATCH3_ENV
echo "WWATCH3_LPR      $PRINTER"                      >> $WWATCH3_ENV
echo "WWATCH3_F90      $WW3_F90"                      >> $WWATCH3_ENV
echo "WWATCH3_CC       $WW3_CC"                       >> $WWATCH3_ENV
echo "WWATCH3_DIR      $WW3_DIR"                      >> $WWATCH3_ENV
echo "WWATCH3_TMP      $WW3_TMPDIR"                   >> $WWATCH3_ENV
echo 'WWATCH3_SOURCE   yes'                           >> $WWATCH3_ENV
echo 'WWATCH3_LIST     yes'                           >> $WWATCH3_ENV
echo ''                                               >> $WWATCH3_ENV
source ${WW3_BINDIR}/w3_setenv
  main_dir=$WWATCH3_DIR
  temp_dir=$WWATCH3_TMP
  source=$WWATCH3_SOURCE
  list=$WWATCH3_LIST
  echo "Main directory    : $main_dir"
  echo "Scratch directory : $temp_dir"
  echo "Save source codes : $source"
  echo "Save listings     : $list"
  export  np='440'     #number of mpi tasks
  export  nr='4'      #number of mpi tasks for hybrid
  export nth='6'      #number of threads
cd ${HOME}
  echo '#!/bin/sh --login'                                   > spinup.head
  echo ' '                                                  >> spinup.head
  if [ $batchq = "slurm" ] && [ $isorion ]
  then
    echo "#SBATCH -n ${np}"                                 >> spinup.head
    echo "#SBATCH --cpus-per-task=${nth}"                   >> spinup.head
    echo '#SBATCH -q batch'                                 >> spinup.head
    echo '#SBATCH -t 08:00:00'                              >> spinup.head
    echo '#SBATCH -A marine-cpu'                            >> spinup.head
    echo '#SBATCH -J ww3_optimization'                      >> spinup.head
    echo '#SBATCH -o spinup.out'                            >> spinup.head
    echo '#SBATCH -p orion'                                 >> spinup.head
  elif [ $batchq = "slurm" ]
  then
    echo "#SBATCH -n ${np}"                                 >> spinup.head
    echo "#SBATCH --cpus-per-task=${nth}"                   >> spinup.head
    echo '#SBATCH -q batch'                                 >> spinup.head
    echo '#SBATCH -t 08:00:00'                              >> spinup.head
    echo '#SBATCH -A marine-cpu'                            >> spinup.head
    echo '#SBATCH -J ww3_optimization'                      >> spinup.head
    echo '#SBATCH -o spinup.out'                            >> spinup.head
  else
    echo '#PBS -l procs=24'                                 >> spinup.head
    echo '#PBS -q batch'                                    >> spinup.head
    echo '#PBS -l walltime=08:00:00'                        >> spinup.head
    echo '#PBS -A marine-cpu'                               >> spinup.head
    echo '#PBS -N ww3_optimization'                         >> spinup.head
    echo '#PBS -j oe'                                       >> spinup.head
    echo '#PBS -o spinup.out'                               >> spinup.head
    echo ' '                                                >> spinup.head
  fi
  echo "  cd ${HOME}"                                       >> spinup.head
  echo ' '                                                  >> spinup.head
  echo "  module purge"                                     >> spinup.head
  echo "  module use $hpcstackpath"                         >> spinup.head
  echo "  module load $hpcstackversion"                     >> spinup.head
  echo "  module load $modcomp"                             >> spinup.head
  echo "  module load $modmpi"                              >> spinup.head
  echo "  module load $modnetcdf"                           >> spinup.head
  echo "  module load $modjasper"                           >> spinup.head
  echo "  module load $modzlib"                             >> spinup.head
  echo "  module load $modpng"                              >> spinup.head
  echo "  module load $modhdf5"                             >> spinup.head
  echo "  module load $modbacio"                            >> spinup.head
  echo "  module load $modg2"                               >> spinup.head
  echo "  module load $modw3nco"                            >> spinup.head
  echo "  module load $modesmf"                             >> spinup.head
  echo "  module load matlab"                               >> spinup.head
  echo "  export WWATCH3_NETCDF=NC4"                        >> spinup.head
  echo '  export NETCDF_CONFIG=$NETCDF_ROOT/bin/nc-config'  >> spinup.head
  echo "  export METIS_PATH=${metispath}"                   >> spinup.head
  echo '  export JASPER_LIB=$JASPER_ROOT/lib64/libjasper.a' >> spinup.head
  echo '  export PNG_LIB=$PNG_ROOT/lib64/libpng.a'          >> spinup.head
  echo '  export Z_LIB=$ZLIB_ROOT/lib/libz.a'               >> spinup.head
  echo '  export ESMFMKFILE=$ESMF_LIB/esmf.mk'              >> spinup.head
  echo "  export WW3_PARCOMPN=4"                            >> spinup.head
  echo ' ' 
  if [ "$batchq" = 'slurm' ]
  then
    export  mpi='mpirun'
  else
    export  mpi='mpirun'
  fi
  if [ "$cmplOption" = 'y' ]
  then
     opt="-c $cmplr -S -T"
  else
     opt="-S"
  fi
  if [ "$batchq" = 'slurm' ]
  then
     opt="-b $batchq $opt"
  fi
  export rtst="${HOME}/bin/run_test $opt"
  export  ww3="${WW3_DIR}"
  if [ ! -f spinup.head ]
  then
    echo "#!/bin/sh"  > spinup.head
  fi
  rm -f spinup.body
  rm -f spinup.tail
  echo "  echo ' '"                                                             >> spinup.head
  echo "  echo '             **********************************************'"   >> spinup.head
  echo "  echo '           ***     WAVEWATCH III spinup tests             ***'" >> spinup.head
  echo "  echo '             **********************************************'"   >> spinup.head
  echo "  echo ' '"                                                             >> spinup.head
if [ ! -f opt_table_Err_norm ] && [ ! -f opt_table_Err_unnorm ]
then
  cp bin/default_x_norm bin/x_opt
  echo "# GlobalError RegionalError var1 var2 var3 var4 var5 var6 var7 var8 var9 var11 var12 var13 var14 var15 var16 var17 var18"  >  opt_table_Err_norm
  echo "# GlobalError RegionalError var1 var2 var3 var4 var5 var6 var7 var8 var9 var11 var12 var13 var14 var15 var16 var17 var18 " >  opt_table_Err_unnorm
fi
  echo "$rtst -w work_spinup -i input_spinup -m grdset_a -f -p $mpi -n $np -t $nth -o both -N $ww3 test1_GFSv16"  >> spinup.body             
  echo "  echo ' '"                                                                > spinup.tail
  echo "  echo '       *****************************************************'"    >> spinup.tail
  echo "  echo '     ***     end of WAVEWATCH III spinup tests             ***'"  >> spinup.tail
  echo "  echo '       *****************************************************'"    >> spinup.tail
  echo "  echo ' '"                                                               >> spinup.tail
    mv spinup.head spinup
    cat spinup.body >> spinup
    rm -f spinup.body
    cat spinup.tail >> spinup
    rm -f spinup.tail
  echo "file spinup prepared ...."
