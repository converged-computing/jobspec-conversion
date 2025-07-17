#!/bin/bash
#FLUX: --job-name=gen
#FLUX: -c=16
#FLUX: --queue=compute
#FLUX: -t=86400
#FLUX: --urgency=16

export PATH='~/.conda/envs/pipeline/bin:~/.homebrew/bin:${PATH}'

. /opt/ohpc/admin/lmod/lmod/init/bash
ml purge
ml load MATLAB/2019b
export PATH=~/.conda/envs/pipeline/bin:~/.homebrew/bin:${PATH}
echo
echo "Running on $(hostname)"
echo "The $(type python)"
echo
WORKSPACE=/home/kremeto1/neural_rendering
cd $WORKSPACE/artwin
~/.homebrew/bin/time -f 'real\t%e s\nuser\t%U s\nsys\t%S s\nmemmax\t%M kB' matlab -batch $1
