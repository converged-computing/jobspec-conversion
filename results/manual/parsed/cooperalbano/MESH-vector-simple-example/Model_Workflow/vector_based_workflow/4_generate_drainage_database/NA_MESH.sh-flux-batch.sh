#!/bin/bash
#FLUX: --job-name=BowAtLouise_drainage_database
#FLUX: -t=3600
#FLUX: --urgency=16

module load StdEnv/2020 gcc/9.3.0 openmpi/4.0.3
module load gdal/3.5.1 libspatialindex/1.8.5
module load python/3.8.10 scipy-stack/2022a mpi4py/3.0.3
source $HOME/MESH-env/bin/activate 
python create_MESH_drainage_database.py 
echo "finished"
