#!/bin/bash
#FLUX: --job-name=hist_photons_G4
#FLUX: --queue=dali
#FLUX: -t=1800
#FLUX: --urgency=16

OPTICS=$1
eval "$(/dali/lgrandi/strax/miniconda3/bin/conda shell.bash hook)"
source activate strax
if [ "$SLURM_ARRAY_TASK_ID" = "" ]; then
    echo "No SLURM ID, job is run interactively, assume 1"
    FILE_NR=0
    SLURM_ARRAY_TASK_ID=1
else
    FILE_NR=`expr $SLURM_ARRAY_TASK_ID - 1`
fi
echo "File number : " $FILE_NR
pyscript=/home/yuanlq/xenon/analysiscode/s1_pulse_shape/generate_histograms.py
echo "Python script : " $pyscript
echo "Optical config" : $OPTICS
curdir=$PWD
rundir=/dali/lgrandi/terliuk/posrec_patterns/run_folder/
echo "Current dir : " $curdir
echo "Changing to run folder  : " $rundir
cd $rundir
python $pyscript -r $FILE_NR -p $OPTICS -n 50
cd $curdir
