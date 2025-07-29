#!/bin/bash
#SBATCH --job-name=TEP
#SBATCH --account=laszka
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=16GB
#SBATCH --time=2-00:00:00
#SBATCH --array=1-5

export PATH='$PWD/gambit-project/:$PATH'

source /project/cacds/apps/anaconda3/5.0.1/etc/profile.d/conda.sh
conda activate tep-gpu
cd /home/teghtesa/TennesseeEastmanProcess
export PATH=$PWD/gambit-project/:$PATH
python safety_test.py $SLURM_ARRAY_TASK_ID
cp -r $TMPDIR/tb_logs /home/teghtesa/TennesseeEastmanProcess/new_logs
