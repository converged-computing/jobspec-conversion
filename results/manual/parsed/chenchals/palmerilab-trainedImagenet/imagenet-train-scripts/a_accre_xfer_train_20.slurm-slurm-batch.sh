#!/bin/bash
#SBATCH --job-name=a_accre_train
#SBATCH --account=palmeri_gpu
#SBATCH --output=/scratch/subravcr/trainedImagenet/myModels/xferLearning/a_accre_xfer_train_%A.out
#SBATCH --mail-user=chenchal.subraveti@vanderbilt.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=64G
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=12

setpkgs -a matlab_r2016b
setpkgs -a gcc_compiler_4.9.3
setpkgs -a cuda7.5
setpkgs -a cudnn7.5-v5
setpkgs -a matlab_r2016b
echo "SLURM_JOBID: "$SLURM_JOBID
testMode=0
baseResultDir="/scratch/subravcr/trainedImagenet/myModels/xferLearning"
baseNetToUse="${baseResultDir}/net-epoch-20/base-net-epoch-20.mat"
echo "    testMode: "$testMode
echo "baseNetTouse: "$baseNetToUse
bash a_accre_train.sh $SLURM_JOBID $testMode ${baseNetToUse}
