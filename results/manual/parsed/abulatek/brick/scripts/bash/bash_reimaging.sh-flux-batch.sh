#!/bin/bash
#FLUX: --job-name=data_reimaging
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

export CASA='/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'
export CASA6='/blue/adamginsburg/adamginsburg/casa/casa-6.1.0-118/bin/casa'

pwd; hostname; date
export CASA=/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
export CASA6=/blue/adamginsburg/adamginsburg/casa/casa-6.1.0-118/bin/casa
data_dir_list=(data_55 data_31 data_41)
field_list=('2' '2' '3')
freq_list=('93' '146' '257')
spw_list=('27' '51' '45')
for i in "${!freq_list[@]}"
do
    export data_dir=${data_dir_list[i]}
    export field=${field_list[i]}
    export freq_num=${freq_list[i]}
    export spw=${spw_list[i]}
    export LOGFILENAME='casa_clean_ab_'$freq_num'_spw'$spw'_2sigma_reimaging.log'
    echo $data_dir 
    echo $freq_num 
    echo $spw 
    echo $field
    echo $LOGFILENAME
    ${CASA6} --logfile=${LOGFILENAME} --nogui --nologger -c '/blue/adamginsburg/abulatek/brick/scripts/imaging/reimaging.py' $data_dir $freq_num $spw $field
done
