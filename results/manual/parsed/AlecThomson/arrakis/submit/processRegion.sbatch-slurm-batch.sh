#!/bin/bash
#SBATCH --job-name=SPICE-MERGE
#SBATCH --account=askap
#SBATCH --output=/group/askap/athomson/projects/arrakis/spica/slurmLogs/process_spice-%j.log
#SBATCH --error=/group/askap/athomson/projects/arrakis/spica/slurmLogs/process_spice-%j.log
#SBATCH --mail-user=alec.thomson@csiro.au
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1000
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=10

export OMP_NUM_THREADS='1'
export SINGULARITY_BINDPATH='$(pwd),/group'

export OMP_NUM_THREADS=1
cd /group/askap/athomson/projects/arrakis/DR1
conda activate spice
module load singularity
export SINGULARITY_BINDPATH=$(pwd),/group
outfile=Arrakis.dr1.multiflag.test.xml
srun --export=ALL spice_region --dask_config /group/askap/athomson/repos/arrakis/arrakis/configs/galaxy.yaml --config /group/askap/athomson/projects/arrakis/spica/spica_full_region_config.txt --use_mpi --own_fit --outfile $outfile --skip_merge --output_dir /group/askap/athomson/projects/arrakis/DR1 --polyOrd -1
fix_dr1_cat.py $outfile
