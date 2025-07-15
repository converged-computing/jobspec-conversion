#!/bin/bash
#FLUX: --job-name=spicy-banana-3842
#FLUX: --priority=16

export LANG='en_US.utf8'
export LC_ALL='en_US.utf8'
export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT='0'

export LANG=en_US.utf8
export LC_ALL=en_US.utf8
cd /ocean/projects/ees230007p/ztseng/ecco_v4r4/build
module purge
module load intel-icc
module load intel-mpi
make CLEAN
../../MITgcm/tools/genmake2 -mods=../reproduce_eccov4r4_online_68o/x_vert_diff -rd=../../MITgcm -optfile=../reproduce_eccov4r4_online_68o/linux_amd64_ifort+impi -mpi
make -j96 depend
make -j96 all
module purge
module load intel-icc
module load intel-mpi
module load hdf5
module load parallel-netcdf
unset I_MPI_PMI_LIBRARY
export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=0
cd /ocean/projects/ees230007p/ztseng/ecco_v4r4/run
rm -rf ../run/*
ln -s ../../forcing/input_init/error_weight/data_error/* .
ln -s ../../forcing/input_init/error_weight/data_error/* .
ln -s ../../forcing/input_init/* .
ln -s ../../forcing/input_forcing/* .
ln -s ../../forcing/other/flux-forced/state_weekly/* .
ln -s ../../forcing/other/flux-forced/forcing/* .
ln -s ../../forcing/other/flux-forced/forcing_weekly/* .
ln -s ../../forcing/other/flux-forced/mask/* .
ln -s ../../forcing/other/flux-forced/xx/* .
ln -s ../../gcmfaces_climatologies/*.bin .
ln -s ../reproduce_eccov4r4_online_68o/ic_files/* .
ln -s ../reproduce_eccov4r4_online_68o/x_vert_diff_input/* .
cp -p ../build/mitgcmuv .
mpiexec -np 96 ./mitgcmuv > a.log
mkdir ziens_xvertdiff_C
mv PTR* ziens_xvertdiff_C
mv ziens_xvertdiff_C ..
