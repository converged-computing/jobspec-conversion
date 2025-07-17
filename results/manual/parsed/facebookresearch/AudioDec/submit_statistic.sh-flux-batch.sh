#!/bin/bash
#FLUX: --job-name=extraction
#FLUX: -c=40
#FLUX: --queue=xxx
#FLUX: -t=86400
#FLUX: --urgency=16

tag_name=statistic/symAD_vctk_48000_hop300_clean
subset=train
subset_num=-1
. ./parse_options.sh || exit 1;
config_name="config/${tag_name}.yaml"
echo "Configuration file="$config_name
python codecStatistic.py -c ${config_name} --subset ${subset} --subset_num ${subset_num}
