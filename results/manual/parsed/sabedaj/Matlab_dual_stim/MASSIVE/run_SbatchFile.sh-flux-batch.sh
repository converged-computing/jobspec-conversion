#!/bin/bash
#FLUX: --job-name=test_dataAnalysis
#FLUX: -t=7200
#FLUX: --priority=16

module load matlab
matlab -nodisplay -nojvm -nosplash < MASSIVE_ANALYSIS_SM.m
