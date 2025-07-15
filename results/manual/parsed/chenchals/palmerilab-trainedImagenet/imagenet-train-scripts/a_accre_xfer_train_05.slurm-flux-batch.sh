#!/bin/bash
#FLUX: --job-name=a_accre_train
#FLUX: --queue=maxwell
#FLUX: -t=432000
#FLUX: --priority=16

setpkgs -a matlab_r2016b
setpkgs -a gcc_compiler_4.9.3
setpkgs -a cuda7.5
setpkgs -a cudnn7.5-v5
setpkgs -a matlab_r2016b
echo "SLURM_JOBID: "$SLURM_JOBID
testMode=0
baseResultDir="/scratch/subravcr/trainedImagenet/myModels/xferLearning"
baseNetToUse="${baseResultDir}/net-epoch-05/base-net-epoch-5.mat"
echo "    testMode: "$testMode
echo "baseNetTouse: "$baseNetToUse
bash a_accre_train.sh $SLURM_JOBID $testMode ${baseNetToUse}
