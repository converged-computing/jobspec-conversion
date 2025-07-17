#!/bin/bash
#FLUX: --job-name=QC_7
#FLUX: -N=2
#FLUX: -n=80
#FLUX: --queue=CPU-Small
#FLUX: -t=86400
#FLUX: --urgency=16

echo Running on $SBATCH_PARTITION paratation
echo Time is `date`
cd /home/lifesci/liuk0617/workspace/ecc_pipe/ecc_pipe
source /home/lifesci/luosongwen/miniconda3/etc/profile.d/conda.sh
conda activate ecc_pipe_old
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu core.
python3 ecc_pipe_master.py --QC -n 80 --config /home/lifesci/liuk0617/workspace/ecc_pipe/ecc_pipe/config/QC/QC_7.yaml
