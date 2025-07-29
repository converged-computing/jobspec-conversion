#!/bin/bash
#SBATCH --account=birdnet
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-22:00:00

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
