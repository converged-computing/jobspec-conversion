#!/bin/bash
#FLUX: --job-name=genCPseries
#FLUX: -c=18
#FLUX: --queue=biochem,owners,normal
#FLUX: -t=54000
#FLUX: --urgency=16

module load python/2.7.13
source /scratch/groups/herschla/roy-test/env/bin/activate
map_cpfluors="CPfluor/$1"
output_dir="CPseries/$1"
cpseq_file="/scratch/groups/herschla/roy-test/20210218_30mM_Mg_Lib4_run1_data/seqData/split-tile/temp/"
mkdir -p $output_dir
logfile="$output_dir/log"
errfile="$output_dir/err"
python $KdScripts/generateCPseries.py -fs $cpseq_file -bs $map_cpfluors -od $output_dir -n 18  1> $logfile 2> $errfile
