#!/bin/bash
#FLUX: --job-name=misunderstood-hobbit-1848
#FLUX: --urgency=16

export JULIA_PKGDIR='$myjulia'
export PATH='$myjulia/bin/:$PATH'

list=$1
offset=$2
if [ ! $offset ]
then
    offset=0
fi
pos=$(($SLURM_ARRAY_TASK_ID + $offset))
id=`tail -n+$pos $list | head -n1`
name=`basename $id .trimmed`
DIR=/pfs/nobackup/home/m/mircomic/PconsC3/
myjulia=/pfs/nobackup/home/a/arnee/Software/julia-0d7248e2ff  # (v0.6)
export JULIA_PKGDIR=$myjulia
export PATH=$myjulia/bin/:$PATH
DIR=/pfs/nobackup/home/a/arnee/git/PconsC3
sleep 2 # waiting for filesystem
dir=`dirname $id`
file=`basename $id .trimmed`
scratch=$SNIC_TMP/arnee/PLM/$dir/
mkdir -p $scratch
cd $dir
if [ ! -s $file.0.02.plm20 ]
then
    $DIR//runplm.py $file.trimmed
fi
cd ../..
