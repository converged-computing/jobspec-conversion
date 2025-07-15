#!/bin/bash
#FLUX: --job-name=gassy-dog-4564
#FLUX: --priority=16

export PATH='/proj/jesuni/projappl/tex-basic/texlive/2020/bin/x86_64-linux:$PATH'
export PTNONINTERACTIVE='1'
export PTNOLATEX=''
export PTOUTPUTDIR='/wrk/users/markusb/Plots/'

frameStart=0  # set to initial frame
frameEnd=2708 # set to the final frame
jobcount=$(( $SLURM_ARRAY_TASK_MAX - $SLURM_ARRAY_TASK_MIN + 1 )) 
index=$(( $SLURM_ARRAY_TASK_ID - $SLURM_ARRAY_TASK_MIN ))
frameEndC=$(( $frameEnd + 1 )) # Need to iterate to 1 past final frame
totalFrames=$(( $frameEndC - $frameStart )) # Total frames to calculate
increment=$(( $totalFrames / $jobcount )) # amount of frames per job (rounded down)
remainder=$(( $totalFrames - $jobcount * $increment ))
start=$(( $frameStart + $index * $increment ))
end=$(( $start + $increment ))
if [ $index -lt $remainder ];
then 
    start=$(( $start + $index ))
    end=$(( $end + $index + 1 ))
else
    start=$(( $start + $remainder ))
    end=$(( $end + $remainder ))
fi;
if [ $SLURM_ARRAY_TASK_ID -eq $SLURM_ARRAY_TASK_MAX ];
then 
    echo Verifying final frame: $end $frameEndC
    end=$frameEndC
fi;
module purge
module load Python/3.7.2-GCCcore-8.2.0
export PATH=/proj/jesuni/projappl/tex-basic/texlive/2020/bin/x86_64-linux:$PATH
module load matplotlib
export PTNONINTERACTIVE=1
export PTNOLATEX=
export PTOUTPUTDIR=/wrk/users/markusb/Plots/
python generate_panel.py $start $end
echo Job $SLURM_ARRAY_TASK_ID complete.
