#!/bin/bash
#FLUX: --job-name=confused-muffin-8821
#FLUX: --queue=gpuq
#FLUX: -t=1800
#FLUX: --priority=16

export PATH='/group/mwaops/phancock/code/Aegean:$PATH'
export PYTHONPATH='/group/mwaops/phancock/code/Aegean:$PYTHONPATH'

aprun="aprun -n 1 -d 8 "
export PATH=/group/mwaops/phancock/code/Aegean:$PATH
export PYTHONPATH=/group/mwaops/phancock/code/Aegean:$PYTHONPATH
datadir=/scratch2/mwaops/phancock
proj=G0008
week=Week2
ncpus=8
if [[ ! $PBS_ARRAY_INDEX ]]
then
    PBS_ARRAY_INDEX=$SLURM_ARRAY_TASK_ID
fi
cd $datadir/$proj/$week
freq=`ls -d *z/ | sed "s;/;;g" | head -${PBS_ARRAY_INDEX} | tail -1`
cd $freq
if [[ -e ${week}_${freq}_rescaled.fits ]]
then
    beam=`pyhead.py -p BMAJ ${week}_${freq}_rescaled.fits | awk '{print $3}'`
    inputimage=${week}_${freq}_rescaled.fits
    psfimage=${week}_${freq}_resid_excl_triple.fits
else
    beam=`pyhead.py -p BMAJ ${week}_${freq}_noweight.fits | awk '{print $3}'`
    inputimage=${week}_${freq}_noweight.fits
    psfimage=${week}_${freq}_noweight_resid_excl_triple.fits
fi
whitebeam=`pyhead.py -p BMAJ ../white/${week}_white_noweight.fits | awk '{print $3}'`
psfratio=`echo "$beam / $whitebeam" | bc -l`
echo $psfratio
if [[ ! -e ${week}_${freq}_prior_comp.vot ]]
then
    $aprun aegean.py --cores=${ncpus} --telescope=mwa --island --maxsummits=5 --autoload --out=/dev/null --table=${week}_${freq}_prior.vot,${week}_${freq}_prior.reg --input=../white/${week}_white_noweight_resid_excl_comp.vot --priorized=1 --ratio=$psfratio --psf=$psfimage $inputimage
else
    echo "${week}_${freq}_prior_comp.vot already exists!"
fi
