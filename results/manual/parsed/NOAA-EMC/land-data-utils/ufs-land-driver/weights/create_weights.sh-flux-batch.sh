#!/bin/bash
#FLUX: --job-name=regrid_weights
#FLUX: -n=2
#FLUX: --queue=debug
#FLUX: -t=300
#FLUX: --urgency=16

module purge
module use /scratch1/NCEPDEV/nems/role.epic/spack-stack/spack-stack-1.5.1/envs/unified-env-rocky8/install/modulefiles/Core
module load stack-intel/2021.5.0
module load stack-intel-oneapi-mpi/2021.5.1
module load esmf/8.5.0
module load ncl/6.6.2
atm_res="C96"
ocn_res="mx100"
grid_version="hr3"
datm_source="ERA5"
datm_source_file="/scratch2/NCEPDEV/land/data/forcing/era5/datm/orig/ERA5_forcing_2022-12-31.nc"
interpolation_method="bilinear"
destination_scrip_path="/scratch2/NCEPDEV/land/data/ufs-land-driver/vector_inputs/"
grid_extent="global"
datm_scrip_file=$datm_source"_SCRIP.nc"
cmdparm="'datm_scrip_file="\"$datm_scrip_file"\"' "
cmdparm=$cmdparm"'datm_source_file="\"$datm_source_file"\"' "
echo "variable list sent to NCL"
echo $cmdparm
eval "time ncl create_datm_scrip.ncl $cmdparm"
if [ $grid_extent = "global" ]; then 
  res=$atm_res.$ocn_res
else
  res=$atm_res.$ocn_res.$grid_extent
fi
grid=$res"_hr3"
output_path=$res"/"
weights_filename=$datm_source"-"$grid"_"$interpolation_method"_wts.nc"
destination_scrip_file=$destination_scrip_path"/"$res"/ufs-land_"$grid"_SCRIP.nc"
if [ -d $output_path ]; then 
  echo "BEWARE: output_path directory exists and overwriting is allowed"
else
  mkdir -p $output_path
fi
echo "Creating weights file: "$weights_filename
srun -n $SLURM_NTASKS time ESMF_RegridWeightGen --netcdf4 --ignore_degenerate \
       --source $datm_scrip_file \
       --destination $destination_scrip_file \
       --weight $output_path$weights_filename --method $interpolation_method
