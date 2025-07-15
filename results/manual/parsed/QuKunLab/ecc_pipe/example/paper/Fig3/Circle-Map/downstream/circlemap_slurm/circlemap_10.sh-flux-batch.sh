#!/bin/bash
#FLUX: --job-name=milky-banana-7217
#FLUX: -t=604800
#FLUX: --priority=16

echo Running on $SBATCH_PARTITION paratation
echo Time is `date`
source /home/lifesci/luosongwen/miniconda3/etc/profile.d/conda.sh
conda activate ecc_pipe_old
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu core.
cd /home/lifesci/liuk0617/workspace/ecc_pipe/ecc_pipe
python3 ecc_pipe_master.py --Detect --tool circlemap -n 80 --config /home/lifesci/liuk0617/workspace/ecc_pipe/ecc_pipe/config/circlemap/circlemap_10.yaml
