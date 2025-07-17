#!/bin/bash
#FLUX: --job-name=hanky-cattywampus-9455
#FLUX: --queue=gpuq
#FLUX: -t=5400
#FLUX: --urgency=16

export PATH='/group/mwaops/phancock/code/Aegean:$PATH'
export PYTHONPATH='/group/mwaops/phancock/code/Aegean:$PYTHONPATH'

function doit {
    echo "$@"
    aprun -n 1 -d 8 -b $@
}
export PATH=/group/mwaops/phancock/code/Aegean:$PATH
export PYTHONPATH=/group/mwaops/phancock/code/Aegean:$PYTHONPATH
datadir=/scratch2/mwaops/phancock
proj=G0008
week=WEEK
if [[ ! $PBS_ARRAY_INDEX ]]
then
    PBS_ARRAY_INDEX=$SLURM_ARRAY_TASK_ID
fi
cd $datadir/$proj/$week
freq=`ls -d *z/ | sed "s;/;;g" | head -${PBS_ARRAY_INDEX} | tail -1`
cd $freq
inputimage="mosaic_${week}_${freq}.fits"
if [[ ! -e ${inputimage} ]]
then
    exit
fi
refcat="../white/mosaic_${week}_170-231MHz_psf_QC_comp.fits"
refpsf="../white/mosaic_${week}_170-231MHz_psf.fits"
outcat="mosaic_${week}_${freq}_priorized"
if [[ ! -e "${outcat}_comp.fits" ]]
then
    echo "Making ${outcat}.fits"
    doit aegean --telescope=mwa --island --maxsummits=25 --autoload --out=/dev/null \
                --table=${outcat}.vot,${outcat}.reg,${outcat}.fits ${inputimage} --priorized 1 \
                --input=${refcat} --catpsf=${refpsf}
else
    echo "${outcat}_comp.fits already exists"
fi
