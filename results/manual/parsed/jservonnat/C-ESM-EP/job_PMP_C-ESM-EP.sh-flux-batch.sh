#!/bin/bash
#FLUX: --job-name=CESMEP
#FLUX: --queue=P8HOST
#FLUX: -t=10800
#FLUX: --urgency=16

export PATH='/prodigfs/ipslfs/dods/jservon/anaconda2-5.1.0/bin:/opt/ncl-6.3.0/bin:/opt/netcdf43/gfortran/bin:/home/igcmg/atlas:/home/igcmg/fast:/opt/ferret-6.9/bin:/opt/ferret-6.9/fast:/opt/nco-4.5.2/bin:/usr/lib64/openmpi/1.4.5-ifort/bin:/opt/intel/15.0.6.233/composer_xe_2015.6.233/bin/intel64:/opt/intel/15.0.6.233/composer_xe_2015.6.233/debugger/gdb/intel64_mic/bin:/opt/scilab-5.4.1/bin:/usr/lib64/qt-3.3/bin:/opt/pgi-2013/linux86-64/2013/bin:/opt/matlab-2013b:/opt/matlab-2013b/bin:/opt/intel/composer_xe_2011_sp1.9.293/bin/intel64:/opt/g95-stable-0.92/bin:/opt/ferret-6.7.2/fast:/opt/ferret-6.7.2/bin:/opt/cdfTools-3.0:/opt/canopy-1.3.0/Canopy_64bit/User/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/idl8/idl/bin:/opt/intel/composer_xe_2011_sp1.9.293/mpirt/bin/intel64:/opt/ncl-6.1.2/bin:/home/lvignon/bin:/home/jservon/bin'
export LD_LIBRARY_PATH='/data/jservon/PMP_nightly_backup_22062017/PMP_nightly/lib:/prodigfs/ipslfs/dods/jservon/anaconda2-5.1.0/lib:${LD_LIBRARY_PATH}'

if [[ -d "/cnrm" ]] ; then
echo "at CNRM"
else
echo "Everywhere else"
fi
set +x
date
atlas_file='PMP_C-ESM-EP.py'
env_script='setenv_C-ESM-EP.sh'
if [[ $1 != '' ]]; then
  ln -s ../cesmep_atlas_style_css
  component=${1%/}
  comparison=$(basename $PWD)
  env=../${env_script}
  main=../${atlas_file}
  datasets_setup_file=datasets_setup.py
  # -- Name of the parameter file
  param_file=${component}/params_${component}.py
else
  # -- comparison, component et WD sont les variables passees avec qsub -v
  echo '$comparison'
  echo $comparison
  echo '$component'
  echo $component
  echo '$WD'
  echo $WD
  env=../../${env_script}
  main=../../${atlas_file}
  datasets_setup_file=../datasets_setup.py
  if [[ -n ${WD} ]]; then
     cd $WD
  fi
  component=${component%/}
  # -- Name of the parameter file
  param_file=params_${component}.py
fi
source ${env}
echo "Running Parallel Coordinates metrics for comparison ${comparison}"
echo "Using CliMAF cache = ${CLIMAF_CACHE}"
export PATH=/prodigfs/ipslfs/dods/jservon/anaconda2-5.1.0/bin:/opt/ncl-6.3.0/bin:/opt/netcdf43/gfortran/bin:/home/igcmg/atlas:/home/igcmg/fast:/opt/ferret-6.9/bin:/opt/ferret-6.9/fast:/opt/nco-4.5.2/bin:/usr/lib64/openmpi/1.4.5-ifort/bin:/opt/intel/15.0.6.233/composer_xe_2015.6.233/bin/intel64:/opt/intel/15.0.6.233/composer_xe_2015.6.233/debugger/gdb/intel64_mic/bin:/opt/scilab-5.4.1/bin:/usr/lib64/qt-3.3/bin:/opt/pgi-2013/linux86-64/2013/bin:/opt/matlab-2013b:/opt/matlab-2013b/bin:/opt/intel/composer_xe_2011_sp1.9.293/bin/intel64:/opt/g95-stable-0.92/bin:/opt/ferret-6.7.2/fast:/opt/ferret-6.7.2/bin:/opt/cdfTools-3.0:/opt/canopy-1.3.0/Canopy_64bit/User/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/idl8/idl/bin:/opt/intel/composer_xe_2011_sp1.9.293/mpirt/bin/intel64:/opt/ncl-6.1.2/bin:/home/lvignon/bin:/home/jservon/bin
source activate /data/jservon/PMP_nightly_backup_22062017/PMP_nightly
export LD_LIBRARY_PATH=/data/jservon/PMP_nightly_backup_22062017/PMP_nightly/lib:/prodigfs/ipslfs/dods/jservon/anaconda2-5.1.0/lib:${LD_LIBRARY_PATH}
python3 ${main} --datasets_setup ${datasets_setup_file} --comparison ${comparison} --params ${param_file}
