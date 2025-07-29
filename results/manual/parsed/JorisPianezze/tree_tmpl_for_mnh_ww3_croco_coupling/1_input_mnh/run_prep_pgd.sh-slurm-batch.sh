#!/bin/bash
#SBATCH --job-name=PREP_PGD
#SBATCH --output=output_PREP_PGD.eo%j
#SBATCH --error=output_PREP_PGD.eo%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH: --exclusive
#SBATCH: --no-requeue

export PREP_PGD_FILES='${PREP_PGD_FILES:-"$HOME/PREP_PGD_FILES_WWW"}'

ulimit -s unlimited
ulimit -c 0
. /home/piaj/03_workdir/2J_devel_MNH_WW3_CROCO/models/MNH-V5-7-0/conf/profile_mesonh-LXgfortran-R8I4-MNH-V5-6-1-OASISAUTO-MPIAUTO-DEBUG
if [ -z ${XYZ} ] ; then
   echo '      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~           '
   echo ' XYZ is not define, please load profile_mesonh'
   echo '      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~           '
   exit
fi
export PREP_PGD_FILES=${PREP_PGD_FILES:-"$HOME/PREP_PGD_FILES_WWW"}
if [ ! -d ${PREP_PGD_FILES} ]
then
   echo 'Your directory PREP_PGD_FILES=$PREP_PGD_FILES doesnt exist.'
   echo 'Please define the location of your PREP_PGD_FILES through'
   echo 'the environment variable PREP_PGD_FILES.'
   exit
else
   ln -sf $PREP_PGD_FILES/CLAY_HWSD_MOY.??? .
   ln -sf $PREP_PGD_FILES/SAND_HWSD_MOY.??? .
   ln -sf $PREP_PGD_FILES/ECOCLIMAP_v2.0.??? .
   ln -sf $PREP_PGD_FILES/gtopo30.??? .
   ln -sf $PREP_PGD_FILES/etopo2.nc .
   #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   #--
   time mpirun -np 1 PREP_PGD${XYZ} | tee output_PREP_PGD.out
   #--
   #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fi
