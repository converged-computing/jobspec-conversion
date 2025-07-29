#!/bin/bash
#SBATCH --job-name=square_qua_phase_36_dense_0.4
#SBATCH --output=/zfs/hybrilit.jinr.ru/user/a/astrakh/nqs_frustrated_phase/output_square_phase_dense64_0.4
#SBATCH --error=/zfs/hybrilit.jinr.ru/user/a/astrakh/nqs_frustrated_phase/error_36_large_0.4.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:1
#SBATCH --mem=300000
#SBATCH --time=3-00:00:00
#SBATCH --chdir=/zfs/hybrilit.jinr.ru/user/a/astrakh/SU3_stag/builds/hydra/logs

start=$(date +%s)
python3 /zfs/hybrilit.jinr.ru/user/a/astrakh/nqs_frustrated_phase/generalisation_very_large.py /zfs/hybrilit.jinr.ru/user/a/astrakh/nqs_frustrated_phase/config_square_phase_K_0.4
finish=$(date +%s)
echo $[$finish-$start]
