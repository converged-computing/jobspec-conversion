#!/bin/bash
#FLUX: --job-name=hello-eagle-1423
#FLUX: -n=6
#FLUX: -t=21600
#FLUX: --urgency=16

start=`date +%s`
module load singularity
shopt -s expand_aliases
source /astro/mwasci/sprabu/aliases
set -x
{
obsnum=OBSNUM
base=BASE
myPath=MYPATH
link=
while getopts 'l:' OPTION
do
    case "$OPTION" in
        l)
            link=${OPTARG}
            ;;
    esac
done
cd ${base}/processing/
mkdir ${obsnum}
cd ${obsnum}
mv ${obsnum}.ms old${obsnum}.ms
wget -O ${obsnum}_ms.tar "${link}"
tar -xvf ${obsnum}_ms.tar
end=`date +%s`
runtime=$((end-start))
echo "the job run time ${runtime}"
}
