#!/bin/bash
#FLUX: --job-name=doopy-bike-8136
#FLUX: -n=24
#FLUX: -t=172800
#FLUX: --urgency=16

ID=$SLURM_ARRAY_TASK_ID
if [ -z "$TAG" ] 
then
      echo "Set variable $TAG to the DALES version to run."
      exit
fi
SYST=gnu-fast
EXP=159
NAMOPTIONS=namoptions-192-fftw.$EXP
OPT=fftw
module load 2019
module load netCDF-Fortran/4.4.4-foss-2018b
module load CMake/3.12.1-GCCcore-7.3.0
module unload OpenMPI/3.1.1-GCC-7.3.0-2.30
module load OpenMPI/3.1.4-GCC-7.3.0-2.30
module load Hypre/2.14.0-foss-2018b
module load FFTW/3.3.8-gompi-2018b
DALES=`pwd`/../../build-$TAG-$SYST/src/dales4
PROJECT=/projects/0/einf170/
CASE=`pwd`
WORK=$PROJECT/janssonf/dales-tester/cao-$TAG-$SYST-$OPT/$ID
mkdir -p $WORK
cd $WORK
cp $CASE/{*.inp.*,$NAMOPTIONS} ./
sed -i -r "s/irandom.*=.*/irandom = $ID/" $NAMOPTIONS
echo ID $ID
echo SYST $SYST
echo DALES $DALES
echo CASE $CASE
echo WORK $WORK
echo hostname `hostname`
srun $DALES $NAMOPTIONS | tee output.txt
