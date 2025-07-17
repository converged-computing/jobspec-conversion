#!/bin/bash
#FLUX: --job-name=lovely-lemur-2375
#FLUX: -n=24
#FLUX: -t=86400
#FLUX: --urgency=16

ID=$SLURM_ARRAY_TASK_ID
if [ -z "$TAG" ] 
then
      echo "Set variable $TAG to the DALES version to run."
      exit
fi
SYST=gnu-fast
NAMOPTIONS=namoptions-144.001
module load prgenv/gnu
module load gcc/11.2.0
module load openmpi
module load cmake/3.20.2
module load netcdf4/4.7.4
module load fftw/3.3.9
DALES=`pwd`/../../build-$TAG-$SYST/src/dales4*
CASE=`pwd`
WORK=$SCRATCH/dales-tester/rico-$TAG-$SYST/$ID
if [ $ID -ge 100 ]; then
    ID=$(( 100-ID ))
fi
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
