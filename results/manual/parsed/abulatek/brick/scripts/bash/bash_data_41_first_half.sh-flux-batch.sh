#!/bin/bash
#FLUX: --job-name=imaging
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

export CASA='/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'
export CASA6='/blue/adamginsburg/adamginsburg/casa/casa-6.1.0-118/bin/casa'
export data_dir='data_41'
export field='3'

pwd; hostname; date
export CASA=/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
export CASA6=/blue/adamginsburg/adamginsburg/casa/casa-6.1.0-118/bin/casa
export data_dir=data_41
export field='3'
freq_list=('250' '252' '264' '266' '257' '259' '271' '273' '244' '245')
spw_list=('25' '27' '29' '31' '45' '47' '49' '51' '65' '67')
for i in "${!freq_list[@]}"
do
    export freq_num=${freq_list[i]}
    export spw=${spw_list[i]}
    export LOGFILENAME='casa_clean_ab_'$freq_num'_spw'$spw'_2sigma.log'
    echo $data_dir 
    echo $freq_num 
    echo $spw 
    echo $field
    echo $LOGFILENAME
    ${CASA6} --logfile=${LOGFILENAME} --nogui --nologger -c '/blue/adamginsburg/abulatek/brick/scripts/imaging/imaging.py' $data_dir $freq_num $spw $field
done
