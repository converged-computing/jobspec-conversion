#!/bin/bash
#FLUX: --job-name=confused-nalgas-9573
#FLUX: --exclusive
#FLUX: --priority=16

ulimit -s unlimited
ulimit -c 0
. ../../models/MNH-V5-5-0/conf/profile_mesonh
ln -sf ../1_input_mnh/PGD_IROISE_5km.* .
ln -sf ../1_input_mnh/ECMWF_20210915_??.* .
ln -sf ../1_input_mnh/EXSEG1.nam_A1_frc_mnh EXSEG1.nam
time mpirun -np 1 MESONH${XYZ} | tee output_MESONH.out
