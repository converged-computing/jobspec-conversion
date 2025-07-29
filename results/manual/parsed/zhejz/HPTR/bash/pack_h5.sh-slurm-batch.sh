#!/bin/bash
#SBATCH --output=./logs/%j.out
#SBATCH --error=./logs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=5000
#SBATCH --time=5-00:00:00

trap "echo sigterm recieved, exiting!" SIGTERM
run () {
python -u src/pack_h5_womd.py --dataset=training \
--out-dir=/cluster/scratch/zhejzhan/h5_womd_hptr \
--data-dir=/cluster/scratch/zhejzhan/womd_scenario_v_1_2_0
}
source /cluster/project/cvl/zhejzhan/apps/miniconda3/etc/profile.d/conda.sh
conda activate hptr # for av2: conda activate hptr_av2
echo Running on host: `hostname`
echo In directory: `pwd`
echo Starting on: `date`
type run
echo START: `date`
run &
wait
echo DONE: `date`
mkdir -p ./logs/slurm
mv ./logs/$SLURM_JOB_ID.out ./logs/slurm/$SLURM_JOB_ID.out
echo finished at: `date`
exit 0;
