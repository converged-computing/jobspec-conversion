#!/bin/bash
#FLUX: --job-name=C1_cpl_mnh_ww3_croco
#FLUX: -N=10
#FLUX: -n=938
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

export dir_exe_croco='/home/piaj/03_workdir/2J_devel_MNH_WW3_CROCO/models/croco/exe_IROISE_1core_CPLOA_CPLOW'

ulimit -s unlimited
ulimit -c 0
. /home/piaj/03_workdir/2J_devel_MNH_WW3_CROCO/models/MNH-V5-7-0/conf/profile_mesonh-LXgfortran-R8I4-MNH-V5-6-1-OASISAUTO-MPIAUTO-DEBUG
if [ -z ${XYZ} ] ; then
   echo '      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~           '
   echo ' XYZ is not define, please load profile_mesonh'
   echo '      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~           '
   exit
fi
ln -sf ${SRC_MESONH}/exe/MESONH${XYZ} mesonh.exe 
export dir_exe_croco=/home/piaj/03_workdir/2J_devel_MNH_WW3_CROCO/models/croco/exe_IROISE_1core_CPLOA_CPLOW
ln -sf ${dir_exe_croco}/croco croco.exe
ln -sf /home/piaj/03_workdir/2J_devel_MNH_WW3_CROCO/models/WW3/model/exe_OASACM_OASOCM/ww3_shel ww3_shel.exe
ln -sf ../1_input_mnh/PGD_IROISE_5km.* .
ln -sf ../1_input_mnh/ERA5_20210915_??.* .
ln -sf ../1_input_mnh/EXSEG1.nam_C1_cpl_mnh_ww3_croco EXSEG1.nam
ln -sf ../3_input_croco/croco_grd.nc .
ln -sf ../3_input_croco/croco_ini_mercator_Y2020M09.nc croco_ini.nc
ln -sf ../3_input_croco/croco_bry_mercator_Y2020M09.nc croco_bry.nc
ln -sf ../3_input_croco/croco.in_C1_cpl_mnh_ww3_croco croco.in
ln -sf ../2_input_ww3/mapsta.ww3 .
ln -sf ../2_input_ww3/mask.ww3 .
ln -sf ../2_input_ww3/mod_def.ww3 .
ln -sf ../2_input_ww3/ST4TABUHF2.bin .
ln -sf ../2_input_ww3/ww3_shel.nml_C1_cpl_mnh_ww3_croco ww3_shel.nml
ln -sf ../A2_frc_ww3_spinup/restart001.ww3 restart.ww3
ln -sf ../4_input_oasis/namcouple_C1_cpl_mnh_ww3_croco namcouple
cp     ../4_input_oasis/rmp_*.nc .
cp     ../4_input_oasis/rst_*.nc .
mpirun -np 2 ./mesonh.exe : -np 1 ./croco.exe : -np 1 ./ww3_shel.exe
