#!/bin/bash
#FLUX: --job-name=alphamax
#FLUX: -c=10
#FLUX: --queue=short
#FLUX: -t=86340
#FLUX: --urgency=16

module load matlab/R2020a
SetsPerJob=10;
TotalSets=1000000;
cd /home/zeiberg.d/alphamax
let "TotalJobs=$TotalSets/$SetsPerJob"
for ((i=1; i <=$TotalJobs; i++))
do 
	let "Start=$SetsPerJob*($i-1)+1";
	let "End=$i*$SetsPerJob";
	F=/scratch/zeiberg.d/alphamax/results/curves_paramsets_$Start_$End
	if test -f "$F";then
            echo "$F exists, skipping" >> logs/makeCurves.%A_%a.out
	    echo "" >> logs/makeCurves.%A_%a.err
        else
            srun matlab -nodisplay -nosplash -nodesktop -r "curves=makeCurves('/scratch/zeiberg.d/alphamax/syntheticParameters.mat', @(x,y)CurveConstructor(x,y,'useGPU',false),'setNumberStart',"$Start", 'setNumberEnd',"$End",'savePath','/scratch/zeiberg.d/alphamax/results/curves_paramsets_"$Start"_"$End"','quiet',true);exit;" &
	fi
done
wait
