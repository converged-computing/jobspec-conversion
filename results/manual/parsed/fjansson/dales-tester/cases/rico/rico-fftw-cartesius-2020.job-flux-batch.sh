#!/bin/bash
#FLUX: --job-name=frigid-taco-5430
#FLUX: --priority=16

ID=$SLURM_ARRAY_TASK_ID
if [ -z "$TAG" ] 
then
    echo "Set variable $TAG to the DALES version to run."
    exit
fi
SYST=gnu-fast
NAMOPTIONS=namoptions-144-fftw.001
OPT=fftw
module load 2020
module load netCDF-Fortran/4.5.2-gompi-2020a
module load CMake/3.16.4-GCCcore-9.3.0
module load Hypre/2.18.2-foss-2020a
module load FFTW/3.3.8-gompi-2020a
DALES=`pwd`/../../build-$TAG-$SYST/src/dales4
if [ ! -x $DALES ] ; then
DALES=${DALES}.3
fi
PROJECT=/projects/0/einf170/
CASE=`pwd`
WORK=$PROJECT/janssonf/dales-tester/rico-$TAG-$SYST-$OPT/$ID
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
echo ls -l libgfortran.so.5
ls -l /sw/arch/RedHatEnterpriseServer7/EB_production/2020/software/GCCcore/9.3.0/lib64/libgfortran.so.5
ls -l /sw/arch/RedHatEnterpriseServer7/EB_production/2020/software/GCCcore/9.3.0/lib64/libgfortran.so.5.0.0
srun $DALES $NAMOPTIONS | tee output.txt
