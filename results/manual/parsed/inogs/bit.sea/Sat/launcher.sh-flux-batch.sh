#!/bin/bash
#FLUX: --job-name=SAT
#FLUX: --queue=g100_meteo_prod
#FLUX: -t=5400
#FLUX: --urgency=16

export UCX_TLS='ib'
export SLURM_PMIX_DIRECT_CONN_UCX='false'
export PYTHONPATH='$PYTHONPATH:$PYPATH'

cd $SLURM_SUBMIT_DIR
. ./profile.inc
source /g100_work/OGS23_PRACE_IT/COPERNICUS/sequence3.sh
unset I_MPI_PMI_LIBRARY
export UCX_TLS=ib
export SLURM_PMIX_DIRECT_CONN_UCX=false
MASKFILE=/g100_work/OGS_devC/V9C/RUNS_SETUP/PREPROC/MASK/meshmask.nc
ORIGDIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/STATIC/SAT/OCEANCOLOUR_MED_BGC_L3_MY_009_143/preproc_download/Download/my.cmems-du.eu/Core/OCEANCOLOUR_MED_BGC_L3_MY_009_143/cmems_obs-oc_med_bgc-reflectance_my_l3-multi-1km_P1D/2019/01
       ORIGDIR=/g100_scratch/userexternal/gbolzon0/V11C/SAT/DAILY/ORIG
   CHECKED_DIR=/g100_scratch/userexternal/gbolzon0/V11C/SAT/DAILY/CHECKED
 WEEKLY_DIR1km=/g100_scratch/userexternal/gbolzon0/V11C/SAT/WEEKLY_1km
   WEEKLYDATES=/g100_scratch/userexternal/gbolzon0/V11C/SAT/WEEKLYDATES
 WEEKLY_DIR_24=/g100_scratch/userexternal/gbolzon0/V11C/SAT/WEEKLY_24
mkdir -p $CHECKED_DIR $WEEKLY_DIR1km $WEEKLYDATES $WEEKLY_DIR_24
MPI="mpirun -np 24"
for nm in 412 443 490 510 555 670; do
   var=RRS${nm}
   my_prex_or_die "$MPI python sat_check_QI.py -i $ORIGDIR -o $CHECKED_DIR -m SAT1km_mesh -v $var --QI 3.0"
   my_prex_or_die "$MPI python aveSat.py -i $CHECKED_DIR -o $WEEKLY_DIR1km -m SAT1km_mesh -t weekly_thursday -d $WEEKLYDATES -v $var"
   my_prex_or_die "$MPI python interpolator.py -i $WEEKLY_DIR1km -o $WEEKLY_DIR_24 -m $MASKFILE --inmesh SAT1km_mesh -v $var "
done
exit 0
ORIGDIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/ONLINE_V9C/SAT/KD490/DT/DAILY/ORIG/
CHECKED_DIR=/g100_scratch/userexternal/gbolzon0/V10C/SAT/KD490/DT/DAILY/CHECKED/SIGMA_2.0/
mkdir -p $CHECKED_DIR
my_prex_or_die "python sat_check_QI.py -i $ORIGDIR -o $CHECKED_DIR -m SAT1km_mesh -v KD490 --QI 2.0 --Kd_min 0.021"
exit 0
WEEKLY_DIR1km=/g100_scratch/userexternal/gbolzon0/V10C/SAT/KD490/DT/SIGMA_2.0/WEEKLY_4_1km
  WEEKLYDATES=/g100_scratch/userexternal/gbolzon0/V10C/SAT/KD490/DT/WEEKLY_4_AVEDATES
mkdir -p $WEEKLY_DIR1km $WEEKLYDATES
my_prex_or_die " python aveSat.py -i $CHECKED_DIR -o $WEEKLY_DIR1km -m SAT1km_mesh -t weekly_thursday -d $WEEKLYDATES -v KD490"
WEEKLY_DIR_24=/g100_scratch/userexternal/gbolzon0/V10C/SAT/KD490/DT/SIGMA_2.0/WEEKLY_4_24
mkdir -p $WEEKLY_DIR_24
my_prex_or_die " python interpolator.py -i $WEEKLY_DIR1km -o $WEEKLY_DIR_24 -m $MASKFILE --inmesh SAT1km_mesh -v KD490 "
ORIGDIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/ONLINE_V9C/SAT/CHL/DT/DAILY/ORIG/
CHECKED_DIR=/g100_scratch/userexternal/gbolzon0/V10C/SAT/CHL/DT/DAILY/CHECKED
for pftvar in CHL DIATO NANO PICO DINO ; do
    break
    my_prex_or_die "python sat_check_QI.py -i $ORIGDIR -o $CHECKED_DIR -m SAT1km_mesh -v $pftvar --QI 2 "
done
DAILY_DIR_24=/g100_scratch/userexternal/gbolzon0/V10C/SAT/CHL/DT/DAILY/CHECKED_24
for pftvar in CHL DIATO NANO PICO DINO ; do
   break
   my_prex_or_die "mpirun -np 24 python interpolator.py -i $CHECKED_DIR -o $DAILY_DIR_24 -m $MASKFILE --inmesh SAT1km_mesh -v $pftvar "
done
WEEKLY_DIR1km=/g100_scratch/userexternal/gbolzon0/V10C/SAT/CHL/DT/WEEKLY_4_1km
  WEEKLYDATES=/g100_scratch/userexternal/gbolzon0/V10C/SAT/CHL/DT/WEEKLY_4_AVEDATES
  mkdir -p $WEEKLY_DIR1km $WEEKLYDATES
for pftvar in CHL DIATO NANO PICO DINO ; do
   break
   my_prex_or_die "mpirun python aveSat.py -i $CHECKED_DIR -o $WEEKLY_DIR1km -m SAT1km_mesh -t weekly_thursday -d $WEEKLYDATES -v $pftvar"
done
WEEKLY_DIR_24=/g100_scratch/userexternal/gbolzon0/V10C/SAT/CHL/DT/WEEKLY_4_24
mkdir -p $WEEKLY_DIR_24
for pftvar in CHL DIATO NANO PICO DINO ; do
   my_prex_or_die "mpirun -np 24 python interpolator.py -i $WEEKLY_DIR1km -o $WEEKLY_DIR_24 -m $MASKFILE --inmesh SAT1km_mesh -v $pftvar "
done
exit 0
INPUTDIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/ONLINE_V8C/SAT/CHL/MULTISENSOR/1Km/NRT/DAILY/CHECKED
MASKFILE=/g100_work/OGS_prodC/MIT/V1M-dev/V1/devel/wrkdir/POSTPROC/meshmask.nc
echo python interpolator.py -i $INPUTDIR -o ./ --inmesh SAT1km_mesh -m $MASKFILE -v CHL
exit 0
PYPATH=/pico/home/usera07ogs/a07ogs00/OPA/V2C/HOST/pico/lib/python2.7/site-packages/
export PYTHONPATH=$PYTHONPATH:$PYPATH
CHECKED_DIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/STATIC/SAT/MULTISENSOR_1km/DAILY/CHECKED/
WEEKLY_DIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/STATIC/SAT/MULTISENSOR_1km/WEEKLY_1km
CHECKED_DIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/STATIC/SAT/CCI_1km/DAILY/CHECKED/
WEEKLY_DIR=/pico/scratch/userexternal/ateruzzi/SATELLITE/CCI16_1km/WEEKLY_1km/
WEEKLY_1KMDIR=$WEEKLY_DIR
WEEKLY_16_DIR=/pico/scratch/userexternal/ateruzzi/SATELLITE/CCI16_1km/WEEKLY_16/
MASKFILE=/pico/home/usera07ogs/a07ogs00/OPA/V2C/etc/static-data/MED1672_cut/MASK/meshmask.nc
WEEKLY_1KMDIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/ONLINE/SAT/MULTISENSOR/1Km/DT/WEEKLY_2_1km/
WEEKLY_1KMDIR=/gpfs/scratch/userexternal/ateruzzi/SAT_forRA_COAST2018/WEEKLY_2_1km_2018
WEEKLY_16_DIR=/gpfs/scratch/userexternal/ateruzzi/SAT_forRA_COAST2018/WEEKLY_2_16_2018/
MASKFILE=/gpfs/scratch/userexternal/ateruzzi/MASKS16/meshmask.nc
mkdir -p $WEEKLY_16_DIR
echo mpirun -np 10 python interpolator.py -i $WEEKLY_1KMDIR -o $WEEKLY_16_DIR -inmesh SAT1km_mesh -m $MASKFILE -v CHL
exit 0
ORIGDIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/STATIC/SAT/CCI_1km/DAILY/ORIG/
CHECKDIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/STATIC/SAT/CCI_1km/DAILY/CHECKED/
CLIM_FILE=/gss/gss_work/DRES_OGS_BiGe/Observations/CLIMATOLOGY/SAT/CCI_1km/SatClimatology.nc
python sat_check.py -i $ORIGDIR -o $CHECKDIR -c $CLIM_FILE -m SAT1km_mesh
ORIGDIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/STATIC/SAT/MULTISENSOR_1km/DAILY/ORIG/
CHECKDIR=/gss/gss_work/DRES_OGS_BiGe/Observations/TIME_RAW_DATA/STATIC/SAT/MULTISENSOR_1km/DAILY/CHECKED/
python sat_check.py -i $ORIGDIR -o $CHECKDIR -c $CLIM_FILE -m SAT1km_mesh
