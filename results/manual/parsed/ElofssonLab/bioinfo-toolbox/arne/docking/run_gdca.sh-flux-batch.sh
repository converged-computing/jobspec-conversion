#!/bin/bash
#FLUX: --job-name=psycho-onion-3435
#FLUX: -c=6
#FLUX: -t=21600
#FLUX: --urgency=16

export JULIA_PKGDIR='$myjulia'
export PATH='$myjulia/bin/:$PATH'

list=$1
offset=$2
pos=$(($SLURM_ARRAY_TASK_ID + $offset))
id=`tail -n+$pos $list | head -n1`
myjulia=/pfs/nobackup/home/a/arnee/Software/julia-ae26b25d43  # (v0.4) (Compiled with Mircos MeffPoss position
export JULIA_PKGDIR=$myjulia
export PATH=$myjulia/bin/:$PATH
DIR=/pfs/nobackup/home/a/arnee/git/PconsC3
sleep 2 # waiting for filesystem
dir=`dirname $id`
file=`basename $id .trimmed`
scratch=$SNIC_TMP/arnee/gdca/$dir/
mkdir -p $scratch
cd $dir
if [ ! -s $file.gdca ]
then
    $DIR/rungdca.py $file.trimmed
fi
cd ../..
