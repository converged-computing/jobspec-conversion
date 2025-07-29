#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=output-%j.txt
#SBATCH --error=output-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:40:00
#SBATCH --partition=shared

export PYTHONPATH='/gpfs/slac/staas/fs1/g/accelerator_modeling/nneveu/software/distgen/:$PYTHONPATH'
export PATH='/gpfs/slac/staas/fs1/g/accelerator_modeling/nneveu/software/OPAL/opal_mpich/bin/:$PATH'
export SLURM_EXACT='1'

module remove openmpi
module load devtoolset/9
module list
source ~/.bashrc
export PYTHONPATH=/gpfs/slac/staas/fs1/g/accelerator_modeling/nneveu/emittance_minimization/code/:$PYTHONPATH
export PYTHONPATH=/gpfs/slac/staas/fs1/g/accelerator_modeling/nneveu/software/libensemble/:$PYTHONPATH
export PYTHONPATH=/gpfs/slac/staas/fs1/g/accelerator_modeling/nneveu/software/distgen/:$PYTHONPATH
conda activate
conda activate /gpfs/slac/staas/fs1/g/accelerator_modeling/nneveu/software/libe
export PATH=/gpfs/slac/staas/fs1/g/accelerator_modeling/nneveu/software/OPAL/opal_mpich/bin/:$PATH
export SLURM_EXACT=1
which mpirun
python latin_sample_sc.py --comms local --nworkers 7 
echo Finished at: `date`
