#!/bin/bash
#FLUX: --job-name=2d_7l_DNN
#FLUX: -t=172800
#FLUX: --urgency=16

module load python/2.7.5
module load tensorflow
basedir=/home/chebert/DonutNN/
scratchdir=/scratch/users/chebert
learningrate=.001
iters=5000
save=1
activation=None
mask=1
inputs=2
layers="[([4,4,2,96],2,'c'),([3,3,96,96],1,'c'),([4,4,96,96],2,'c'),([4,4,96,96],1,'d'),([4,4,96,96],1,'d'),([4,4,96,48],2,'d'),([3,3,48,1],1,'c')]"
command="python $basedir/DonutNet.py -f $scratchdir/simulatedData_plus.p -resdir $basedir/results/ -arch $layers -lr $learningrate -i $iters -a $activation -s $save -in $inputs"
echo $command
$command
