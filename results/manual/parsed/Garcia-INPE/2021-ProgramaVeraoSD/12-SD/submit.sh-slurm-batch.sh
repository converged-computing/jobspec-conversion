#!/bin/bash
#SBATCH --job-name=DCTST
#SBATCH --output=log/slurm-%j.out
#SBATCH --error=log/slurm-%j.err
#SBATCH --nodes=16
#SBATCH --ntasks=384
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=24

mkdir -p log tmp
NETINFO=log/netinfo.$SLURM_JOBID.log
echo $SLURM_JOB_NODELIST
nodeset -e $SLURM_JOB_NODELIST
echo -n Entering in: 
pwd
cd $SLURM_SUBMIT_DIR
echo $SLURM_SUBMIT_HOST >> $NETINFO
ip addr >> $NETINFO
echo Loading modules
module load python/3.8.2
module load raxml/8.2_openmpi-2.0_gnu
source /scratch/app/modulos/julia-1.5.1.sh
cd /scratch/cenapadrjsd/diego.carvalho/biocomp
echo Starting Parsil Script
python3 parsl_inside_allocation.py
