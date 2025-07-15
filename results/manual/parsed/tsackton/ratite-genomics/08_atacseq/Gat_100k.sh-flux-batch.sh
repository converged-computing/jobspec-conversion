#!/bin/bash
#FLUX: --job-name=angry-leg-8732
#FLUX: --urgency=16

source activate python2_pgrayson
gat-run.py --ignore-segment-tracks --segments=${1} --annotations=${2} --workspace=workspace_galGal4.bed --num-samples=100000 --output-counts-pattern=count${1}_%s.txt --log=gat${1}.log > ${1}_gat.out
