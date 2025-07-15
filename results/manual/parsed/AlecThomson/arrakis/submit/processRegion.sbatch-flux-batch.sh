#!/bin/bash
#FLUX: --job-name=SPICE-MERGE
#FLUX: -n=1000
#FLUX: -t=43200
#FLUX: --urgency=16

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
