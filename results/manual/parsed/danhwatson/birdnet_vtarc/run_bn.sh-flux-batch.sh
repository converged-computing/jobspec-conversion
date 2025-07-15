#!/bin/bash
#FLUX: --job-name=chocolate-taco-3517
#FLUX: -n=32
#FLUX: --queue=t4_normal_q
#FLUX: -t=252000
#FLUX: --urgency=16

export OMPI_MCA_mpi_warn_on_fork='0 '
export OMPI_MCA_btl_openib_if_exclude='mlx5_1 '

module reset 
module load BirdNET/20201214-fosscuda-2019b-Python-3.7.4 
export OMPI_MCA_mpi_warn_on_fork=0 
export OMPI_MCA_btl_openib_if_exclude=mlx5_1 
cd $SLURM_SUBMIT_DIR 
BN_BIN=/apps/easybuild/software/infer-skylake/BirdNET/20201214-fosscuda-2019b-Python-3.7.4/analyze.py 
IN_DIR=/projects/birdnet/test/data_2023_06
OUT_DIR=/projects/birdnet/test/data_2023_06_output
echo "`date` Starting Birdnet..." 
python $BN_BIN --i $IN_DIR --o $OUT_DIR --lat 31.0429 --lon -81.9687  #edit with the rough coordinates of where your acoustic files were recorded
echo "`date` Done processing $IN_DIR"
