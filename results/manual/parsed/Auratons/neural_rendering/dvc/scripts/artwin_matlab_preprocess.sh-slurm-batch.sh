#!/bin/bash
#SBATCH --job-name=gen
#SBATCH --output=artwin_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --partition=compute

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
