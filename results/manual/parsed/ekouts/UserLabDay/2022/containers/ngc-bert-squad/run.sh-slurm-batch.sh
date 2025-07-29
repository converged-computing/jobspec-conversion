#!/bin/bash
#SBATCH --job-name=bert-squad-finetune
#SBATCH --account=usup
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --time=00:50:00
#SBATCH --constraint=ntasks-per-node=1,gpu

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load daint-gpu
module load sarus
module load OpenMPI/4.1.2
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
mpirun sarus run --tty --mount=type=bind,source=$SCRATCH,destination=$SCRATCH \
             nvcr.io/nvidia/pytorch:22.08-py3 \
             bash -c '
             cd $SCRATCH/bert-demo;
             . deepspeed-env/bin/activate;
             python 3_squad_bert_deepspeed.py --deepspeed_config ds_config.json'
