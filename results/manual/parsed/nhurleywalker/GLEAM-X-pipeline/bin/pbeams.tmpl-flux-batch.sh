#!/bin/bash
#FLUX: --job-name=stanky-hobbit-2619
#FLUX: --queue=STANDARDQ
#FLUX: -t=43200
#FLUX: --urgency=16

base=BASEDIR
absmem=ABSMEM
obsnum=`sed "${SLURM_ARRAY_TASK_ID}q;d" BEAMLIST`
subchans="MFS 0000 0001 0002 0003"
cd $base
if [[ ! -d pbeams ]]
then
    mkdir pbeams
fi
cd pbeams
if [[ ! -d ${obsnum} ]] && [[ -d ../${obsnum} ]]
then
    mv ../${obsnum} ./
fi
cd ${obsnum}
metafits=`ls -t ${obsnum}*metafits* | head -1`
if [[ $obsnum -lt 1151402936 ]] ; then
    telescope="MWA128T"
    basescale=1.1
    imsize=4000
    robust=-1.0
elif [[ $obsnum -ge 1151402936 ]] && [[ $obsnum -lt 1191580576 ]] ; then
    telescope="MWAHEX"
    basescale=2.0
    imsize=2000
    robust=-2.0
elif [[ $obsnum -ge 1191580576 ]] ; then
    telescope="MWALB"
    basescale=0.5
    imsize=8000
    robust=0.0
fi
chan=`pyhead.py -p CENTCHAN ${metafits} | awk '{print $3}'`
bandwidth=`pyhead.py -p BANDWIDTH ${metafits} | awk '{print $3}'`
centfreq=`pyhead.py -p FREQCENT ${metafits} | awk '{print $3}'`
    # Pixel scale
scale=`echo "$basescale / $chan" | bc -l` # At least 4 pix per synth beam for each channel
    # Naming convention for output files
lowfreq=`echo "$centfreq $bandwidth" | awk '{printf("%00d\n",$1-($2/2.)+0.5)}'`
highfreq=`echo "$centfreq $bandwidth" | awk '{printf("%00d\n",$1+($2/2.)+0.5)}'`
freqrange="${lowfreq}-${highfreq}"
Dec=`pyhead.py -p Dec $metafits | awk '{print $3}'`
dec=`echo $Dec | awk '{printf("%.0f",$1)}'`
HA=`pyhead.py -p HA $metafits | awk '{print $3}'`
ha=`echo $HA | awk 'BEGIN{FS=":"} {printf("%.0f",$1+($2/60.)+($3/3600.))}'`
if [[ ! -d ../Dec${dec} ]]
then
    mkdir ../Dec${dec}
fi
if [[ ! -d ../Dec/${dec}/HA${ha} ]]
then
    mkdir ../Dec${dec}/HA${ha}
fi
if [[ ! -d ../Dec${dec}/HA${ha}/${chan} ]]
then
    mkdir ../Dec${dec}/HA${ha}/${chan}
fi
wsclean -nmiter 0 -niter 0 \
    -name ${obsnum} \
    -size ${imsize} ${imsize} \
    -scale ${scale:0:8} \
    -pol I \
    -weight briggs ${robust} \
    -abs-mem ${absmem} \
    -join-channels \
    -channels-out 4 \
    ${obsnum}.ms | tee wsclean.log
for subchan in $subchans
do
    beam -2016 -proto ${obsnum}-${subchan}-dirty.fits -ms ${obsnum}.ms -name beam-${subchan}
done
mv beam* ../Dec${dec}/${chan}
