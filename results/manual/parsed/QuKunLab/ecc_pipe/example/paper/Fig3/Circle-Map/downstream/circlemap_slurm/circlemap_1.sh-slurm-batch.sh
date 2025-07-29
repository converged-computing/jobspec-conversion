#!/bin/bash
#SBATCH --job-name=circlemap_1
#SBATCH --output=log/circlemap_1_%j.log
#SBATCH --error=log/circlemap_1_%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=80
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --qos=scpujoblimit

echo Running on $SBATCH_PARTITION paratation
echo Time is `date`
source /home/lifesci/luosongwen/miniconda3/etc/profile.d/conda.sh
conda activate ecc_pipe_old
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu core.
cd /home/lifesci/liuk0617/workspace/ecc_pipe/ecc_pipe
python3 ecc_pipe_master.py --Detect --tool circlemap -n 80 --config /home/lifesci/liuk0617/workspace/ecc_pipe/ecc_pipe/config/circlemap/circlemap_1.yaml
