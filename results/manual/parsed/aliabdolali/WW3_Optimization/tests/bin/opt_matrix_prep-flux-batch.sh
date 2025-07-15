#!/bin/bash
#FLUX: --job-name=doopy-pancake-2310
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
  echo '#!/bin/sh --login'                                   > opt_matrix.head
  echo ' '                                                  >> opt_matrix.head
  if [ $batchq = "slurm" ] && [ $isorion ]
  then
    echo "#SBATCH -n ${np}"                                 >> opt_matrix.head
    echo "#SBATCH --cpus-per-task=${nth}"                   >> opt_matrix.head
    echo '#SBATCH -q batch'                                 >> opt_matrix.head
    echo '#SBATCH -t 02:00:00'                              >> opt_matrix.head
    echo '#SBATCH -A marine-cpu'                            >> opt_matrix.head
    echo '#SBATCH -J ww3_optimization'                      >> opt_matrix.head
    echo '#SBATCH -o opt_matrix.out'                        >> opt_matrix.head
    echo '#SBATCH -p orion'                                 >> opt_matrix.head
  elif [ $batchq = "slurm" ]
  then
    echo "#SBATCH -n ${np}"                                 >> opt_matrix.head
    echo "#SBATCH --cpus-per-task=${nth}"                   >> opt_matrix.head
    echo '#SBATCH -q batch'                                 >> opt_matrix.head
    echo '#SBATCH -t 02:00:00'                              >> opt_matrix.head
    echo '#SBATCH -A marine-cpu'                            >> opt_matrix.head
    echo '#SBATCH -J ww3_optimization'                      >> opt_matrix.head
    echo '#SBATCH -o opt_matrix.out'                        >> opt_matrix.head
  else
    echo '#PBS -l procs=24'                                 >> opt_matrix.head
    echo '#PBS -q batch'                                    >> opt_matrix.head
    echo '#PBS -l walltime=02:00:00'                        >> opt_matrix.head
    echo '#PBS -A marine-cpu'                               >> opt_matrix.head
    echo '#PBS -N ww3_optimization'                         >> opt_matrix.head
    echo '#PBS -j oe'                                       >> opt_matrix.head
    echo '#PBS -o opt_matrix.out'                           >> opt_matrix.head
    echo ' '                                                >> opt_matrix.head
  fi
  echo "  cd ${HOME}"                                       >> opt_matrix.head
  echo ' '                                                  >> opt_matrix.head
  echo "  module purge"                                     >> opt_matrix.head
  echo "  module use $hpcstackpath"                         >> opt_matrix.head
  echo "  module load $hpcstackversion"                     >> opt_matrix.head
  echo "  module load $modcomp"                             >> opt_matrix.head
  echo "  module load $modmpi"                              >> opt_matrix.head
  echo "  module load $modnetcdf"                           >> opt_matrix.head
  echo "  module load $modjasper"                           >> opt_matrix.head
  echo "  module load $modzlib"                             >> opt_matrix.head
  echo "  module load $modpng"                              >> opt_matrix.head
  echo "  module load $modhdf5"                             >> opt_matrix.head
  echo "  module load $modbacio"                            >> opt_matrix.head
  echo "  module load $modg2"                               >> opt_matrix.head
  echo "  module load $modw3nco"                            >> opt_matrix.head
  echo "  module load $modesmf"                             >> opt_matrix.head
  echo "  module load matlab"                               >> opt_matrix.head
  echo "  export WWATCH3_NETCDF=NC4"                        >> opt_matrix.head
  echo '  export NETCDF_CONFIG=$NETCDF_ROOT/bin/nc-config'  >> opt_matrix.head
  echo "  export METIS_PATH=${metispath}"                   >> opt_matrix.head
  echo '  export JASPER_LIB=$JASPER_ROOT/lib64/libjasper.a' >> opt_matrix.head
  echo '  export PNG_LIB=$PNG_ROOT/lib64/libpng.a'          >> opt_matrix.head
  echo '  export Z_LIB=$ZLIB_ROOT/lib/libz.a'               >> opt_matrix.head
  echo '  export ESMFMKFILE=$ESMF_LIB/esmf.mk'              >> opt_matrix.head
  echo "  export WW3_PARCOMPN=4"                            >> opt_matrix.head
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
  if [ ! -f opt_matrix.head ]
  then
    echo "#!/bin/sh"  > opt_matrix.head
  fi
  rm -f opt_matrix.body
  rm -f opt_matrix.tail
  echo "  echo ' '"                                                                 >> opt_matrix.head
  echo "  echo '             **********************************************'"       >> opt_matrix.head
  echo "  echo '           ***     WAVEWATCH III opt_matrix tests             ***'" >> opt_matrix.head
  echo "  echo '             **********************************************'"       >> opt_matrix.head
  echo "  echo ' '"                                                                 >> opt_matrix.head
     export input_i=input_opt
     export work_i=work_opt  
  cp bin/default_x_norm bin/x_opt
  module load matlab
 ( cd ${HOME}/bin/; matlab -nodisplay -nodesktop -r "try; opt_wav; catch; end; quit" ) > opt_log.out 2> opt_err.out
if [ ! -f opt_table_Err_norm ] && [ ! -f opt_table_Err_unnorm ]
then  
  echo "# GlobalError RegionalError var1 var2 var3 var4 var5 var6 var7 var8 var9 var11 var12 var13 var14 var15 var16 var17 var18"  >  opt_table_Err_norm
  echo "# GlobalError RegionalError var1 var2 var3 var4 var5 var6 var7 var8 var9 var11 var12 var13 var14 var15 var16 var17 var18 " >  opt_table_Err_unnorm
fi
   if [ -d "${HOME}/test1_GFSv16/input_opt" ]
   then 
      echo "${HOME}/test1_GFSv16/input_opt exist"
   else
     cd ${HOME}/test1_GFSv16/
     bash prep.sh
   fi
     cd ${HOME}
  echo "   if [ -d "${HOME}/test1_GFSv16/work_opt" ] "                           >> opt_matrix.body
  echo "   then "                                                                >> opt_matrix.body
  echo "      rm -r ${HOME}/test1_GFSv16/work_opt "                              >> opt_matrix.body
  echo "   fi"                                                                   >> opt_matrix.body
     echo "( cd ${HOME}/bin/; matlab -nodisplay -nodesktop -r \"try; opt_wav; catch; end; quit\" ) > opt_log.out 2> opt_err.out"  >> opt_matrix.body
     echo "( cd ${HOME}/bin/; matlab -nodisplay -nodesktop -r \"try; opt_prep; catch; end; quit\" ) > opt_log.out 2> opt_err.out" >> opt_matrix.body
     echo "mv ${HOME}/bin/namelist ${HOME}/test1_GFSv16/input_opt/namelist.nml"                                                   >> opt_matrix.body
     echo "mv ${HOME}/bin/norm ${HOME}/test1_GFSv16/input_opt/norm.nml"                                                           >> opt_matrix.body
     echo "mv ${HOME}/bin/unnorm ${HOME}/test1_GFSv16/input_opt/unnorm.nml"                                                       >> opt_matrix.body
     echo "$rtst -w work_opt -i input_opt -m grdset_a -f -p $mpi -n $np -t $nth -o both -N $ww3 test1_GFSv16"                     >> opt_matrix.body
     echo "cat test1_GFSv16/work_opt/Err_norm.nml >> opt_table_Err_norm"                                                          >> opt_matrix.body
     echo "cat test1_GFSv16/work_opt/Err_unnorm.nml >> opt_table_Err_unnorm"                                                      >> opt_matrix.body
  echo "   if [ -f "${HOME}/stop" ]"              >> opt_matrix.body
  echo "   then"                                  >> opt_matrix.body
  echo "      echo 'optimization is completed'"   >> opt_matrix.body
  echo "   else"                                  >> opt_matrix.body
  echo "     sbatch opt_matrix"                   >> opt_matrix.body
  echo "   fi"                                    >> opt_matrix.body
     echo "input_opt is prepared"
  echo "  echo ' '"                                                                   > opt_matrix.tail
  echo "  echo '       *****************************************************'"        >> opt_matrix.tail
  echo "  echo '     ***     end of WAVEWATCH III opt_matrix tests             ***'"  >> opt_matrix.tail
  echo "  echo '       *****************************************************'"        >> opt_matrix.tail
  echo "  echo ' '"                                                                   >> opt_matrix.tail
    mv opt_matrix.head opt_matrix
    cat opt_matrix.body >> opt_matrix
    rm -f opt_matrix.body
    cat opt_matrix.tail >> opt_matrix
    rm -f opt_matrix.tail
  echo "file opt_matrix prepared ...."
