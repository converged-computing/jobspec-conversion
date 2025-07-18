#!/bin/bash
#FLUX: --job-name=PREP_REAL_CASE
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

export YEAR='2021'
export MONTH='09'

ulimit -s unlimited
ulimit -c 0
. /home/piaj/03_workdir/2J_devel_MNH_WW3_CROCO/models/MNH-V5-7-0/conf/profile_mesonh-LXgfortran-R8I4-MNH-V5-6-1-OASISAUTO-MPIAUTO-DEBUG
if [ -z ${XYZ} ] ; then
   echo '      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~           '
   echo ' XYZ is not define, please load profile_mesonh'
   echo '      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~           '
   exit
fi
export YEAR='2021'
export MONTH='09'
for DAY in '15'
do
  for HOUR in '00' '06'
  do
    echo ' ~~~~~~~~~~~~~~~~~~~~ '
    echo ' Treatment of the date' $YEAR$MONTH$DAY 'at' $HOUR'h'
    echo '                      '
    cp PRE_REAL1.nam_tmpl PRE_REAL1.nam
    sed -i  "s/YEAR/$YEAR/g"  PRE_REAL1.nam
    sed -i "s/MONTH/$MONTH/g" PRE_REAL1.nam
    sed -i   "s/DAY/$DAY/g"   PRE_REAL1.nam
    sed -i  "s/HOUR/$HOUR/g"  PRE_REAL1.nam
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #--
    time mpirun -np 1 PREP_REAL_CASE${XYZ} | tee output_PREP_REAL_CASE_${YEAR}${MONTH}${DAY}${HOUR}.out
    #--
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    mv OUTPUT_LISTING0 OUTPUT_LISTING0_${YEAR}${MONTH}${DAY}${HOUR}
    mv PRE_REAL1.nam PRE_REAL1.nam_${YEAR}${MONTH}${DAY}${HOUR}
  done
done
