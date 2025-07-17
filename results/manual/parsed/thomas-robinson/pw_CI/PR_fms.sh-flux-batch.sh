#!/bin/bash
#FLUX: --job-name=FMS_container
#FLUX: -N=2
#FLUX: -n=4
#FLUX: -t=900
#FLUX: --urgency=16

intelVersion=2021.2
container=/contrib/intel${intelVersion}_netcdfc4.7.4_ubuntu.sif
buildDir=/contrib/${intelVersion}/${1}
logdir=/contrib/${intelVersion}/${1}/log
rm -rf ${buildDir}
mkdir -p ${buildDir}/build
mkdir -p ${logdir}
sudo yum install -y singularity
cd ${buildDir}
rm -rf FMS/
git clone https://github.com/NOAA-GFDL/FMS.git |& tee ${logdir}/clone.log
cd FMS && git fetch origin ${1}:toMerge && git merge toMerge |& tee ${logdir}/fetch.log
cd ${buildDir}/build
set -o pipefail
singularity exec -B /lustre,/contrib ${container} autoreconf -i ${buildDir}/FMS/configure.ac |& tee ${logdir}/contreconf.log
set -o pipefail
singularity exec -B /lustre,/contrib ${container} ${buildDir}/FMS/configure --prefix=${buildDir}/build FC=mpiifort CC="mpiicc -no-multibyte-chars" CPPFLAGS="-L/opt/netcdf-fortran/lib -lnetcdff -I/opt/netcdf-fortran/include -I/opt/netcdf-fortran/include -I/opt/netcdf-c/include -I/opt/hdf5/include -I/include -L/opt/netcdf-c/lib -lnetcdf" LIBS="-L/opt/netcdf-fortran/lib -lnetcdff -L/opt/netcdf-c/lib -lnetcdf" |& tee ${logdir}/configrun.log
cp config.log ${logdir}/config.log 
set -o pipefail
singularity exec -B /lustre,/contrib ${container} /contrib/make_fms_container_pr.sh ${buildDir}/build |& tee ${logdir}/make_fms_container.log
