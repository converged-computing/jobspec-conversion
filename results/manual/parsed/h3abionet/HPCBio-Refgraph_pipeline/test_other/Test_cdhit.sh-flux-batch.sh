#!/bin/bash
#FLUX: --job-name=cd-hit-test
#FLUX: --priority=16

cd /home/groups/h3abionet/RefGraph/results/NeginV_Test_Summer2021/results/annotation
module load CD-HIT/4.8.1-IGB-gcc-8.2.0
 # * Word size 10-11 is for thresholds 0.95 ~ 1.0
 # * Word size 8,9 is for thresholds 0.90 ~ 0.95
 # * Word size 7 is for thresholds 0.88 ~ 0.9
 # * Word size 6 is for thresholds 0.85 ~ 0.88
 # * Word size 5 is for thresholds 0.80 ~ 0.85
 # * Word size 4 is for thresholds 0.75 ~ 0.8
