#!/bin/bash
#SBATCH --job-name=CS_adj_p_gauges
#SBATCH --account=loni_ceds3d
#SBATCH --output=o.out
#SBATCH --error=e.err
#SBATCH --nodes=8
#SBATCH --ntasks=384
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=workq

date
module purge
module load proteus/1.8.1
mkdir -p $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cd $WORK/$SLURM_JOB_NAME.$SLURM_JOBID 
cp $SLURM_SUBMIT_DIR/*.py .
cp $SLURM_SUBMIT_DIR/*.csv .
cp $SLURM_SUBMIT_DIR/*.sh .
srun parun -l5 -v -p --TwoPhaseFlow cox_flume2DV_qbc.py -C "he=0.1 mangrove_porous=True filename='inp_HD_TR1.csv'"
date
exit 0
