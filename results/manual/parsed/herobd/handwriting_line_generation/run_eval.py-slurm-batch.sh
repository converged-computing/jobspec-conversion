#!/bin/bash
#SBATCH --job-name=eval
#SBATCH --mail-user=herobd@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=2048M
#SBATCH --time=00:30:00

export PBS_NODEFILE='`/fslapps/fslutils/generate_pbs_nodefile`'
export PBS_JOBID='$SLURM_JOB_ID'
export PBS_O_WORKDIR='$SLURM_SUBMIT_DIR'
export PBS_QUEUE='batch'
export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export PBS_NODEFILE=`/fslapps/fslutils/generate_pbs_nodefile`
export PBS_JOBID=$SLURM_JOB_ID
export PBS_O_WORKDIR="$SLURM_SUBMIT_DIR"
export PBS_QUEUE=batch
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
module load cuda/10.1
module load cudnn/7.6
cd ~/hw_with_style
source deactivate
source activate c10
python new_eval.py -c saved/fontNAF32_ocr_softmax_1huge/checkpoint-iteration500000.pth -g 0 -f cf_test_on_FUNSD.json
