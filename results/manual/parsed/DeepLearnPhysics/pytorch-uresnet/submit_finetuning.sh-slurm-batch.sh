#!/bin/bash
#SBATCH --job-name=uresnet_finetuning
#SBATCH --output=uresnet_finetuning.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8000
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu
#SBATCH --nodelist=pgpu03

WORKDIR=/cluster/kappa/90-days-archive/wongjiradlab/twongj01/pytorch-uresnet
DATADIR=/cluster/kappa/90-days-archive/wongjiradlab/twongj01/ssnet_training_data
CONTAINER=/cluster/kappa/90-days-archive/wongjiradlab/larbys/images/singularity-larbys-pytorch/singularity-larbys-pytorch-larcv1-nvidia384.66.img
module load singularity
singularity exec --nv ${CONTAINER} bash -c "cd ${WORKDIR} && source run_finetuning_job.sh ${WORKDIR} ${DATADIR}"
