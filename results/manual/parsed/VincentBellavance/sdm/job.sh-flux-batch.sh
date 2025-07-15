#!/bin/bash
#FLUX: --job-name=test_pipeline
#FLUX: -t=36000
#FLUX: --priority=16

module use /home/belv1601/.local/easybuild/modules/2020/avx2/Compiler/gcc9/
module load StdEnv/2020  gcc/9.3.0 r-inla/21.05.02 geos/3.9.1 gdal/3.0.4 proj/7.0.1 udunits
sp=$(cut -d' ' "-f${SLURM_ARRAY_TASK_ID}" <<<cat data/species_vect.txt)
make spatial zone=south_qc species=$sp cpu_task=1 output_dir=/home/belv1601/scratch/output obs_folder=data/occurrences
make models zone=south_qc species=$sp cpu_task=1 output_dir=/home/belv1601/scratch/output
make maps zone=south_qc species=$sp cpu_task=1 output_dir=/home/belv1601/scratch/output
make binary_maps zone=south_qc species=$sp cpu_task=1 output_dir=/home/belv1601/projects/def-dgravel/belv1601/sdm/output
