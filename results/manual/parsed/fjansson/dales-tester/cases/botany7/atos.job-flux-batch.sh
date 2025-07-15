#!/bin/bash
#FLUX: --job-name=phat-eagle-8737
#FLUX: --urgency=16

if [ -z "$TAG" ] 
then
      echo "Set variable $TAG to the DALES version to run."
      exit
fi
if [ -z "$ID" ]
then
    ID=1
fi
if [ -z "$NX" ]
then
    NX=16
    echo "NX set to $NX"
fi
if [ -z "$NY" ]
then
    NY=32
    echo "NY set to $NY"
fi
NTOT=$((NX*NY))
SYST=gnu-fast
NAMOPTIONS=namoptions-1536.001
module load prgenv/gnu
module load gcc/11.2.0
module load openmpi
module load cmake/3.20.2
module load netcdf4/4.7.4
module load fftw/3.3.9
DALES=`pwd`/../../build-$TAG-$SYST/src/dales4*
CASE=`pwd`
WORK=$SCRATCH/dales-tester/botany7-$TAG-$SYST-$OPT-$NX-$NY/$ID
if [ $ID -ge 100 ]; then
    ID=$(( 100-ID ))
fi
mkdir -p $WORK
cd $WORK
cp $CASE/{lscale.inp.001,$NAMOPTIONS,prof.inp.001,scalar.inp.001,nudge.inp.001,rrtmg*nc,backrad*} ./
sed -i -r "s/irandom.*=.*/irandom = $ID/" $NAMOPTIONS
sed -i -r "s/nprocx.*=.*/nprocx = $NX/;s/nprocy.*=.*/nprocy = $NY/" $NAMOPTIONS
echo ID $ID
echo SYST $SYST
echo DALES $DALES
echo CASE $CASE
echo WORK $WORK
echo hostname `hostname`
srun $DALES $NAMOPTIONS | tee output.txt
