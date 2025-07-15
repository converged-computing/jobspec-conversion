#!/bin/bash
#FLUX: --job-name=mborrus_MiMA
#FLUX: -n=32
#FLUX: --queue=serc
#FLUX: -t=10800
#FLUX: --priority=16

export "PYTHONPATH='$PYTHONPATH:/scratch/users/mborrus/MiMA/code/MiMAv0.1_mborrus/wavenet/models/'
export "HDF5_DISABLE_VERSION_CHECK='1'

module purge
. /home/groups/s-ees/share/cees/spack_cees/scripts/cees_sw_setup-beta.sh
CEES_MODULE_SUFFIX="cees-beta"
COMP="intel"
MPI="mpich"
module load devel gcc/10.
module load intel-${CEES_MODULE_SUFFIX}
module load mpich-${CEES_MODULE_SUFFIX}/
module load netcdf-c-${CEES_MODULE_SUFFIX}/
module load netcdf-fortran-${CEES_MODULE_SUFFIX}/
module list
conda activate wavenet_env
export "PYTHONPATH=$PYTHONPATH:/home/mborrus/"
export "PYTHONPATH=$PYTHONPATH:/scratch/users/mborrus/MiMA/code/MiMAv0.1_mborrus/src/atmos_param/dd_drag/"
export "PYTHONPATH=$PYTHONPATH:/scratch/users/mborrus/MiMA/code/MiMAv0.1_mborrus/src/atmos_param/"
export "PYTHONPATH=$PYTHONPATH:/scratch/users/mborrus/MiMA/code/MiMAv0.1_mborrus/wavenet/"
export "PYTHONPATH=$PYTHONPATH:/scratch/users/mborrus/MiMA/code/MiMAv0.1_mborrus/wavenet/models/"
export "HDF5_DISABLE_VERSION_CHECK=1"
run=namelist
N_PROCS=32
base=/scratch/users/mborrus/MiMA
user=mborrus
executable=${base}/code/MiMAv0.1_mborrus/exp/exec.Sherlock/mima.x
input=${base}/code/MiMAv0.1_mborrus/input
rundir=${base}/runs/$run
[ ! -d $rundir ] && mkdir $rundir
cp $executable $rundir/
cp -r $input/* $rundir/
cd $rundir
ulimit -s unlimited
[ ! -d RESTART ] && mkdir RESTART
srun --ntasks 32 --mem-per-cpu 8G mima.x
CCOMB=${base}/code/MiMAv0.1_mborrus/bin/mppnccombine.Sherlock
$CCOMB -r atmos_daily.nc atmos_daily.nc.*
$CCOMB -r atmos_avg.nc atmos_avg.nc.*
