#!/bin/bash
#FLUX: --job-name=frigid-sundae-5289
#FLUX: -n=24
#FLUX: --queue=thin
#FLUX: -t=64800
#FLUX: --priority=16

ID=$SLURM_ARRAY_TASK_ID
if [ -z "$TAG" ] 
then
      echo "Set variable $TAG to the DALES version to run."
      exit
fi
SYST=gnu-fast
NAMOPTIONS=namoptions-144-fftw.001
module load 2021
module load foss/2021a
module load netCDF-Fortran/4.5.3-gompi-2021a
module load CMake/3.20.1-GCCcore-10.3.0
module load Hypre/2.21.0-foss-2021a # optional
DALES=`pwd`/../../build-$TAG-$SYST/src/dales4
if [ ! -x $DALES ] ; then
DALES=${DALES}.3
fi
CASE=`pwd`
OPT="fftw"
WORK=/scratch-shared/$USER/dales-tester/rico-$TAG-$SYST-$OPT/$ID
mkdir -p $WORK
cd $WORK
cp $CASE/{lscale.inp.001,$NAMOPTIONS,prof.inp.001,scalar.inp.001} ./
sed -i -r "s/irandom.*=.*/irandom = $ID/" $NAMOPTIONS
echo ID $ID
echo SYST $SYST
echo DALES $DALES
echo CASE $CASE
echo WORK $WORK
echo hostname `hostname`
srun $DALES $NAMOPTIONS | tee output.txt
