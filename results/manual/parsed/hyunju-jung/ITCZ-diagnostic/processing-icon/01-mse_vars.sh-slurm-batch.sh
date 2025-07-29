#!/bin/bash
#FLUX: --job-name=ke
#FLUX: -n=8
#FLUX: --queue=cip
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load python/3.9-2021.11
module load enstools/2020.11.a2-py3
module load spack
module load icon-tools
module load hdf5-blosc
module list
INDICATOR="explicit" #"high_resolution/param"
files=(`ls /archive/meteo/w2w-p2/B6/natureruns_new/${INDICATOR}/obs_DOM01_ML_*.nc | sort`)
DEST="data/${INDICATOR}"
PREFIX="ke_var_"
num=$(( ${SLURM_ARRAY_TASK_ID}+1 )) #73 #121
i=$(printf "%04d\n" ${num})
echo "i = $i"
grid_file="/archive/meteo/w2w-p2/B6/DA/13km/grid_DOM01.nc"
cat > remap_bc_${i}.namelist << EOF
&remap_nml
    in_grid_filename               = "${grid_file}"
    in_filename                    = "${files[$SLURM_ARRAY_TASK_ID]}"
    in_type                        = 2
    out_filename                   = "${DEST}/ke_var_reg_${i}.nc"
    out_type                       = 1
    lsynthetic_grid                = .TRUE.
    corner1                        = -180.,-30.
    corner2                        = 180., 30.
    nxpoints                       = 1801 
    nypoints                       = 301
/
EOF
cat > input_bc_${i}.namelist << EOF
&input_field_nml
    inputname                      = "temp"
    outputname                     = "temp" 
/
&input_field_nml
    inputname                      = "qv"
    outputname                     = "qv" 
/
&input_field_nml
    inputname                      = "qi"
    outputname                     = "qi" 
/
&input_field_nml
    inputname                      = "pres"
    outputname                     = "pres" 
/
EOF
echo 'remapping'
iconremap --remap_nml remap_bc_${i}.namelist --input_field_nml input_bc_${i}.namelist
echo 'remap is done'
rm remap_bc_${i}.namelist 
rm input_bc_${i}.namelist
python -W ignore scripts/conceptual_vars_bug_fixed.py --source $DEST/ke_var_reg_${i}.nc --dest $DEST --prefix $PREFIX
