#!/bin/bash
#FLUX: --job-name=RNN
#FLUX: -t=86399
#FLUX: --urgency=16

export PATH='/mnt/home/priesbr1/anaconda3/bin:/mnt/home/priesbr1/anaconda3/condabin:/opt/software/powertools/bin:/opt/software/MATLAB/2018a:/opt/software/MATLAB/2018a/bin:/opt/software/Java/1.8.0_152:/opt/software/Java/1.8.0_152/bin:/opt/software/Python/3.6.4-foss-2018a/bin:/opt/software/SQLite/3.21.0-GCCcore-6.4.0/bin:/opt/software/Tcl/8.6.8-GCCcore-6.4.0/bin:/opt/software/libreadline/7.0-GCCcore-6.4.0/bin:/opt/software/ncurses/6.0-GCCcore-6.4.0/bin:/opt/software/CMake/3.11.1-GCCcore-6.4.0/bin:/opt/software/bzip2/1.0.6-GCCcore-6.4.0/bin:/opt/software/FFTW/3.3.7-gompi-2018a/bin:/opt/software/OpenBLAS/0.2.20-GCC-6.4.0-2.28/bin:/opt/software/imkl/2018.1.163-gompi-2018a/mkl/bin:/opt/software/imkl/2018.1.163-gompi-2018a/bin:/opt/software/OpenMPI/2.1.2-GCC-6.4.0-2.28/bin:/opt/software/binutils/2.28-GCCcore-6.4.0/bin:/opt/software/GCCcore/6.4.0/bin:/usr/lib64/qt-3.3/bin:/opt/software/core/lua/lua/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/usr/local/hpcc/bin:/usr/lpp/mmfs/bin:/opt/ibutils/bin:/opt/puppetlabs/bin'

dir=/mnt/home/yushiqi2/Analysis/SPACNN/
export PATH="/mnt/home/priesbr1/anaconda3/bin:/mnt/home/priesbr1/anaconda3/condabin:/opt/software/powertools/bin:/opt/software/MATLAB/2018a:/opt/software/MATLAB/2018a/bin:/opt/software/Java/1.8.0_152:/opt/software/Java/1.8.0_152/bin:/opt/software/Python/3.6.4-foss-2018a/bin:/opt/software/SQLite/3.21.0-GCCcore-6.4.0/bin:/opt/software/Tcl/8.6.8-GCCcore-6.4.0/bin:/opt/software/libreadline/7.0-GCCcore-6.4.0/bin:/opt/software/ncurses/6.0-GCCcore-6.4.0/bin:/opt/software/CMake/3.11.1-GCCcore-6.4.0/bin:/opt/software/bzip2/1.0.6-GCCcore-6.4.0/bin:/opt/software/FFTW/3.3.7-gompi-2018a/bin:/opt/software/OpenBLAS/0.2.20-GCC-6.4.0-2.28/bin:/opt/software/imkl/2018.1.163-gompi-2018a/mkl/bin:/opt/software/imkl/2018.1.163-gompi-2018a/bin:/opt/software/OpenMPI/2.1.2-GCC-6.4.0-2.28/bin:/opt/software/binutils/2.28-GCCcore-6.4.0/bin:/opt/software/GCCcore/6.4.0/bin:/usr/lib64/qt-3.3/bin:/opt/software/core/lua/lua/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/usr/local/hpcc/bin:/usr/lpp/mmfs/bin:/opt/ibutils/bin:/opt/puppetlabs/bin"
cd $dir
source activate /mnt/home/priesbr1/anaconda3/envs/tfgpu-brandon
python $dir/pone_RNN.py --hits 300 --epochs 1000 --beta_1 0.8 --lr 0.002 --dropout 0.2 --log_energy 0 --standardize 0 --weights 0 --data_type 'cleaned_linefit_300_dxyz_10DOM_10TeV' -c 1 -f "pone_cleaned_pulses_linefit_10minDOM_min10000GeV.hdf5" 
exit $?
