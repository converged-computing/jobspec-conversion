#!/bin/bash
#FLUX: --job-name=plotV1
#FLUX: -c=5
#FLUX: -t=3600
#FLUX: --priority=16

set -e
module purge
module load gcc/10.2.0
module load cuda/11.1.74
module load boost/intel/1.74.0
module load matlab/2020b
module list
plotOnly=false
TF=8
fdr=tune-008
op=evoked1s-s15t8-no_CI0
op_cfg=evoked_1s.cfg
lgn=b_4_20-micro
v1=no_CI0
v1_cfg=connectome.cfg
lgn_cfg=LGN_V1.cfg
if [ -d "$fdr" ]
then
	echo overwrite contents in $fdr
else
	mkdir $fdr	
fi
cp $op_cfg $fdr
echo using $op_cfg
echo outputs $op, $lgn and $v1
if [ "$plotOnly" = false ]
then
	date
	./patch -c $op_cfg
	readNewSpike=True
else
	readNewSpike=False
fi
date
pid=""
echo python plotLGN_response.py $op $lgn $fdr $readNewSpike
python plotLGN_response.py $op $lgn $fdr $readNewSpike &
pid+="${!} "
echo python plotV1_response.py $op $lgn $v1 $fdr $TF 0.25 True $readNewSpike 
python plotV1_response.py $op $lgn $v1 $fdr $TF 0.25 True $readNewSpike & 
pid+="${!} "
wait $pid
date
