#!/bin/bash
#FLUX: --job-name=FMS_container
#FLUX: -N=2
#FLUX: -n=4
#FLUX: -t=900
#FLUX: --urgency=16

buildDir=/lustre/build_2021.2
sudo yum install -y singularity
cd /lustre
git clone https://github.com/NOAA-GFDL/FMS.git
mkdir ${buildDir} && cd ${buildDir}
autoreconf -i ../FMS/configure.ac
singularity exec -B /lustre,/contrib /contrib/intel2021.2_netcdfc4.7.4_ubuntu.sif autoreconf -i ../FMS/configure.ac
singularity exec -B /lustre,/contrib /contrib/intel2021.2_netcdfc4.7.4_ubuntu.sif /lustre/FMS/configure --prefix=${buildDir} FC=mpiifort CC="mpiicc -no-multibyte-chars" CPPFLAGS="-L/opt/netcdf-fortran/lib -lnetcdff -I/opt/netcdf-fortran/include -I/opt/netcdf-fortran/include -I/opt/netcdf-c/include -I/opt/hdf5/include -I/include -L/opt/netcdf-c/lib -lnetcdf" LIBS="-L/opt/netcdf-fortran/lib -lnetcdff -L/opt/netcdf-c/lib -lnetcdf" 
singularity exec -B /lustre,/contrib /contrib/intel2021.2_netcdfc4.7.4_ubuntu.sif /contrib/make_fms_container.sh
