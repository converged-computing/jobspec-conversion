#!/bin/bash
#FLUX: --job-name=remap
#FLUX: -n=8
#FLUX: --queue=cip
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load spack cdo
module load hdf5-blosc
module load icon-tools #/2.1.0-gcc-9
module list
num=$(( ${SLURM_ARRAY_TASK_ID}+1 ))
i=$(printf "%04d\n" ${num})
grid_file="/archive/meteo/w2w-p2/B6/high_resolution/grid/grid_DOM01.nc"
odirs=( "output" )
od_data="E5"
for od in ${odirs[@]}
do
in_filename="/archive/meteo/w2w-p2/B6/high_resolution/${od}/obs_DOM01_ML_${i}.nc"
out_filename="data/${od_data}/obs_DOM01_level90_ML_${i}.nc"
final_filename="data/${od_data}/obs_DOM01_reg_level90_${i}.nc"
if [ -f ${final_filename} ]; then
   echo ${final_filename}
   echo "file already exists"
else
 echo 'creating file'
cdo --no_history -sellevel,90,90 -selvar,pres,temp,qv ${in_filename} ${out_filename}
cat > remap_bc_${i}.namelist << EOF
&remap_nml
    in_grid_filename               = "${grid_file}"
    in_filename                    = "${out_filename}"  
    in_type                        = 2
    out_filename                   = "${final_filename}"    
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
    inputname                      = "pres"
    outputname                     = "pres" 
/
&input_field_nml
    inputname                      = "temp"
    outputname                     = "temp" 
/
&input_field_nml
    inputname                      = "qv"
    outputname                     = "qv" 
/
EOF
echo 'remapping'
iconremap --remap_nml remap_bc_${i}.namelist --input_field_nml input_bc_${i}.namelist
echo 'remap is done'
rm remap_bc_${i}.namelist 
rm input_bc_${i}.namelist
fi
rm ${out_filename}
done
