#!/bin/bash
#FLUX: --job-name=msweep
#FLUX: --queue=big
#FLUX: -t=86400
#FLUX: --urgency=16

dataset=$1
network=$2
pool=$3
n=$4
m=$5
filename=${dataset}_${network}_${pool}.sh
rm $filename
echo '#!/bin/bash' > $filename
echo '/home_directory/nn-pacbayes/meta_script_msweep_jade2 '${dataset}' '${network}' '${pool}' '${n}' '${m} >> $filename
chmod +x $filename
/jmain01/apps/docker/tensorflow-batch -v 19.09-py3 -c $filename
