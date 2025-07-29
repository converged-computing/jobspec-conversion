#!/bin/bash
#SBATCH --job-name=mlreco_p100
#SBATCH --output=gridlog_mlreco_p100.log
#SBATCH --error=gridlog_train_larmatch.%j.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:4
#SBATCH --mem=8g
#SBATCH --time=6-00:00:00
#SBATCH --partition=gpu,ccgpu,wongjiradlab

WORKDIR=/cluster/tufts/wongjiradlabnu/twongj01/mlreco/lartpc_mlreco3d/
container=/cluster/tufts/wongjiradlabnu/larbys/larbys-container/singularity_minkowskiengine_u20.04.cu111.torch1.9.0_comput8.sif
module load singularity/3.5.3
singularity exec --nv --bind /cluster/tufts/:/cluster/tufts/,/tmp:/tmp $container bash -c "source ${WORKDIR}/run_ubmlreco_uresnet_ppn.sh"
