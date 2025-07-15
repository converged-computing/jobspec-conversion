#!/bin/bash
#FLUX: --job-name=hairy-punk-5089
#FLUX: -n=24
#FLUX: --queue=thin
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
module load 2022
module load foss/2022a
module load netCDF-Fortran/4.6.0-gompi-2022a
module load CMake/3.23.1-GCCcore-11.3.0
module load Hypre/2.25.0-foss-2022a # optional
DALES=`pwd`/../../build-$TAG-$SYST/src/dales4
if [ ! -x $DALES ] ; then
DALES=${DALES}.3
fi
CASE=`pwd`
WORK=/scratch-shared/$USER/dales-tester/rico-$TAG-$SYST/$ID
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
