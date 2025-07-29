#!/bin/bash
#SBATCH --job-name=alphamax
#SBATCH --output=logs/makeCurves.%A_%a.out
#SBATCH --error=logs/makeCurves.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=32Gb
#SBATCH --time=23:59:00
#SBATCH --partition=short
#SBATCH --constraint=E5-2690v3@2.60GHz
#SBATCH --array=1-1000

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
