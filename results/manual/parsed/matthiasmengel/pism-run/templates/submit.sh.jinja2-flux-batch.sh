#!/bin/bash
#FLUX: --job-name={{settings.experiment}}
#FLUX: -n=160
#FLUX: --queue=broadwell
#FLUX: -t=85800
#FLUX: --priority=16

export PISM_ON_CLUSTER='1'
export PATH='$NETCDF_ROOT/bin:$PATH'
export PETSC_DIR='/home/hpc/pn69ru/di36lav2/petsc/petsc-3.9.2-intel2018'
export PETSC_ARCH='arch-linux2-c-opt'

{% if settings.is_pikcluster: -%}
{% if settings.pik_partition=="broadwell" -%}
{% else %}
{% endif %}
module purge
module load pism/stable1.0
runname=`echo $PWD | awk -F/ '{print $NF}'`
outdir={{settings.working_dir}}/$runname
mkdir -p $outdir/log/
export PISM_ON_CLUSTER=1
./pism_run.sh $SLURM_NTASKS > $outdir/log/pism.out
{% else %}
source /etc/profile.d/modules.sh
module unload mpi.ibm intel mkl netcdf
module load mkl/2018 intel/18.0 mpi.intel/2018
module load hdf5/mpi/1.10.1
module load gcc/8
module load gsl/2.4
module load fftw/mpi/v3_mkl2018
NETCDF_ROOT=/home/hpc/pn69ru/di36lav2/software/netcdf-c-4.6.2-intel-2018
export PATH=$NETCDF_ROOT/bin:$PATH
export PETSC_DIR=/home/hpc/pn69ru/di36lav2/petsc/petsc-3.9.2-intel2018
export PETSC_ARCH=arch-linux2-c-opt
runname=`echo $PWD | awk -F/ '{print $NF}'`
outdir={{settings.working_dir}}/$runname
echo $LOADL_STEP_ID
echo $HOME
echo $LOADL_PROCESSOR_LIST
echo $LOADL_TOTAL_TASKS
echo $outdir
number_of_cores=`echo $LOADL_PROCESSOR_LIST | wc -w`
echo $number_of_cores
mkdir -p $outdir/log/
export PISM_ON_CLUSTER=1
pism_run.sh $LOADL_TOTAL_TASKS >> $outdir/log/pism.out
{% endif %}
