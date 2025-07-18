#!/bin/bash
#FLUX: --job-name=MESONH
#FLUX: -n=2
#FLUX: --exclusive
#FLUX: --queue=normal256
#FLUX: -t=3600
#FLUX: --urgency=16

export dir_exe_croco='../../models/croco-v1.1/exe_IROISE_1core_CPLOA'

ulimit -s unlimited
ulimit -c 0
. ../../models/MNH-V5-5-0/conf/profile_mesonh
export dir_exe_croco=../../models/croco-v1.1/exe_IROISE_1core_CPLOA
ln -sf ${dir_exe_croco}/croco croco.exe
ln -sf ../1_input_mnh/PGD_IROISE_5km.* .
ln -sf ../1_input_mnh/ECMWF_20210915_??.* .
ln -sf ../1_input_mnh/EXSEG1.nam_B_mnh_croco EXSEG1.nam
ln -sf ../3_input_croco/croco_grd.nc .
ln -sf ../3_input_croco/croco_ini_mercator_15597.5.nc croco_ini.nc
ln -sf ../3_input_croco/croco_bry_mercator_15597.5.nc croco_bry.nc
ln -sf ../3_input_croco/croco.in_B_mnh_croco croco.in
ln -sf ../4_input_oasis/namcouple_B_mnh_croco namcouple
cp ../4_input_oasis/rst_A.nc .
cp ../4_input_oasis/rst_O.nc .
cp ../4_input_oasis/rmp*nc .
time mpirun : -np 1 MESONH${XYZ} : -np 1 ./croco.exe
