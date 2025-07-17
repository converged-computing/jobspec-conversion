#!/bin/bash
#FLUX: --job-name=KID490_check
#FLUX: --queue=gll_meteo_prod
#FLUX: -t=10800
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/gpfs/work/OGS20_PRACE_P/COPERNICUS/bit.sea'

cd $SLURM_SUBMIT_DIR
module purge
module load profile/base
module load intel/pe-xe-2018--binary intelmpi/2018--binary
module load autoload
module load hdf5/1.8.18--intel--pe-xe-2018--binary netcdf/4.6.1--intel--pe-xe-2018--binary
module load mpi4py/3.0.0--intelmpi--2018--binary
source /gpfs/work/OGS20_PRACE_P/COPERNICUS/py_env_2.7.12/bin/activate
export PYTHONPATH=$PYTHONPATH:/gpfs/work/OGS20_PRACE_P/COPERNICUS/bit.sea
date
. ./profile.inc
BASEDIR=/gpfs/scratch/userexternal/gcoidess/SAT/KdProduct/
mkdir -p $BASEDIR
CHECKED=/gpfs/scratch/userexternal/gcoidess/SAT/CHECKED/
OUTMONTHLY=$BASEDIR/MONTHLYAVE/
TTOUTMONTHLY=$BASEDIR/TTMONTHLYAVE/
OUTWEEKLY=$BASEDIR/WEEKLYAVE/
SATMESH=SAT1km_mesh
mkdir -p $OUTMONTHLY
mkdir -p $TTOUTMONTHLY
mkdir -p $OUTWEEKLY
my_prex_or_die "mpirun python aveSat_kd.py -i $CHECKED -o $OUTMONTHLY -m $SATMESH -t monthly"
my_prex_or_die "mpirun python aveSat_kd.py -i $CHECKED -o $OUTWEEKLY -m $SATMESH -t weekly_monday"
