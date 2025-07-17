#!/bin/bash
#FLUX: --job-name=data_reimaging_FOV
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

export CASA='/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'
export CASA6='/blue/adamginsburg/adamginsburg/casa/casa-6.1.0-118/bin/casa'

pwd; hostname; date
export CASA=/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
export CASA6=/blue/adamginsburg/adamginsburg/casa/casa-6.1.0-118/bin/casa
data_dir_list=(data_41)
field_list=('3')
freq_list=('259')
spw_list=('47')
for i in "${!freq_list[@]}"
do
    export data_dir=${data_dir_list[i]}
    export field=${field_list[i]}
    export freq_num=${freq_list[i]}
    export spw=${spw_list[i]}
    export LOGFILENAME='casa_clean_ab_'$freq_num'_spw'$spw'_2sigma_reimaging_FOV.log'
    echo $data_dir 
    echo $freq_num 
    echo $spw 
    echo $field
    echo $LOGFILENAME
    ${CASA6} --logfile=${LOGFILENAME} --nogui --nologger -c '/blue/adamginsburg/abulatek/brick/scripts/imaging/reimaging_FOV.py' $data_dir $freq_num $spw $field
done
