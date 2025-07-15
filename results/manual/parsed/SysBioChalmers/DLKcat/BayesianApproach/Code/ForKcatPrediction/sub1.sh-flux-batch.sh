#!/bin/bash
#FLUX: --job-name=delicious-blackbean-5400
#FLUX: --urgency=16

module load GCCcore/8.3.0
module load MATLAB intel/2018b GMP
module load Gurobi/8.0.0
a1=1
b1=40
matlab -nodesktop -singleCompThread -r "writeFile_pre_cluster($a1,$b1)"
