#!/bin/bash
#FLUX: --job-name=chocolate-toaster-6563
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
  echo '#!/bin/sh --login'                                   > initial.head
  echo ' '                                                  >> initial.head
  if [ $batchq = "slurm" ] && [ $isorion ]
  then
    echo "#SBATCH -n ${np}"                                 >> initial.head
    echo "#SBATCH --cpus-per-task=${nth}"                   >> initial.head
    echo '#SBATCH -q batch'                                 >> initial.head
    echo '#SBATCH -t 08:00:00'                              >> initial.head
    echo '#SBATCH -A marine-cpu'                            >> initial.head
    echo '#SBATCH -J ww3_optimization'                      >> initial.head
    echo '#SBATCH -o initial.out'                           >> initial.head
    echo '#SBATCH -p orion'                                 >> initial.head
  elif [ $batchq = "slurm" ]
  then
    echo "#SBATCH -n ${np}"                                 >> initial.head
    echo "#SBATCH --cpus-per-task=${nth}"                   >> initial.head
    echo '#SBATCH -q batch'                                 >> initial.head
    echo '#SBATCH -t 08:00:00'                              >> initial.head
    echo '#SBATCH -A marine-cpu'                            >> initial.head
    echo '#SBATCH -J ww3_optimization'                      >> initial.head
    echo '#SBATCH -o initial.out'                           >> initial.head
  else
    echo '#PBS -l procs=24'                                 >> initial.head
    echo '#PBS -q batch'                                    >> initial.head
    echo '#PBS -l walltime=08:00:00'                        >> initial.head
    echo '#PBS -A marine-cpu'                               >> initial.head
    echo '#PBS -N ww3_optimization'                         >> initial.head
    echo '#PBS -j oe'                                       >> initial.head
    echo '#PBS -o initial.out'                              >> initial.head
    echo ' '                                                >> initial.head
  fi
  echo "  cd ${HOME}"                                       >> initial.head
  echo ' '                                                  >> initial.head
  echo "  module purge"                                     >> initial.head
  echo "  module use $hpcstackpath"                         >> initial.head
  echo "  module load $hpcstackversion"                     >> initial.head
  echo "  module load $modcomp"                             >> initial.head
  echo "  module load $modmpi"                              >> initial.head
  echo "  module load $modnetcdf"                           >> initial.head
  echo "  module load $modjasper"                           >> initial.head
  echo "  module load $modzlib"                             >> initial.head
  echo "  module load $modpng"                              >> initial.head
  echo "  module load $modhdf5"                             >> initial.head
  echo "  module load $modbacio"                            >> initial.head
  echo "  module load $modg2"                               >> initial.head
  echo "  module load $modw3nco"                            >> initial.head
  echo "  module load $modesmf"                             >> initial.head
  echo "  module load matlab"                               >> initial.head
  echo "  export WWATCH3_NETCDF=NC4"                        >> initial.head
  echo '  export NETCDF_CONFIG=$NETCDF_ROOT/bin/nc-config'  >> initial.head
  echo "  export METIS_PATH=${metispath}"                   >> initial.head
  echo '  export JASPER_LIB=$JASPER_ROOT/lib64/libjasper.a' >> initial.head
  echo '  export PNG_LIB=$PNG_ROOT/lib64/libpng.a'          >> initial.head
  echo '  export Z_LIB=$ZLIB_ROOT/lib/libz.a'               >> initial.head
  echo '  export ESMFMKFILE=$ESMF_LIB/esmf.mk'              >> initial.head
  echo "  export WW3_PARCOMPN=4"                            >> initial.head
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
  if [ ! -f initial.head ]
  then
    echo "#!/bin/sh"  > initial.head
  fi
  rm -f initial.body
  rm -f initial.tail
  echo "  echo ' '"                                                             >> initial.head
  echo "  echo '             **********************************************'"   >> initial.head
  echo "  echo '           ***  WAVEWATCH III initial of tests             ***'">> initial.head
  echo "  echo '             **********************************************'"   >> initial.head
  echo "  echo ' '"                                                             >> initial.head
if [ ! -f table_Err_norm ] && [ ! -f table_Err_unnorm ]
then  
  echo "# GlobalError RegionalError var1 var2 var3 var4 var5 var6 var7 var8 var9 var11 var12 var13 var14 var15 var16 var17 var18"  >  opt_table_Err_norm
  echo "# GlobalError RegionalError var1 var2 var3 var4 var5 var6 var7 var8 var9 var11 var12 var13 var14 var15 var16 var17 var18 " >  opt_table_Err_unnorm
fi
module load matlab
 ( cd ${HOME}/bin/; matlab -nodisplay -nodesktop -r "try; initial_prep; catch; end; quit" ) > initial_log.out 2> initial_err.out 
 i=0
 while [ -f ${HOME}/bin/namelist_$(( i + 1 )) ];
 do
   i=$(( i + 1 ))
   if [ -d "${HOME}/test1_GFSv16/input_$i" ];then
     echo "input_$i exists"
   else
     export input_i=input_$i
     export work_i=work_$i
     cd ${HOME}/test1_GFSv16/
     bash prep.sh
     cd ${HOME}
     mv ${HOME}/bin/namelist_$i ${HOME}/test1_GFSv16/input_$i/namelist.nml
     mv ${HOME}/bin/norm_$i ${HOME}/test1_GFSv16/input_$i/norm.nml
     mv ${HOME}/bin/unnorm_$i ${HOME}/test1_GFSv16/input_$i/unnorm.nml
     echo "$rtst -w work_$i -i input_$i -m grdset_a -f -p $mpi -n $np -t $nth -o both -N $ww3 test1_GFSv16"  >> initial.body
     echo "cat test1_GFSv16/work_$i/Err_norm.nml >> opt_table_Err_norm"                                      >> initial.body
     echo "cat test1_GFSv16/work_$i/Err_unnorm.nml >> opt_table_Err_unnorm"                                  >> initial.body                    
     echo "input_$i is prepared"
   fi 
 done
  echo "  echo ' '"                                                                > initial.tail
  echo "  echo '       *****************************************************'"     >> initial.tail
  echo "  echo '     ***  end of WAVEWATCH III initial tests               ***'"   >> initial.tail
  echo "  echo '       *****************************************************'"     >> initial.tail
  echo "  echo ' '"                                                                >> initial.tail
    mv initial.head initial
    cat initial.body >> initial
    rm -f initial.body
    cat initial.tail >> initial
    rm -f initial.tail
  echo "file initial prepared ...."
