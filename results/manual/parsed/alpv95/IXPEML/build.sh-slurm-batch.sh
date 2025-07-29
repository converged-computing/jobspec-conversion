#!/bin/bash
#SBATCH --job-name=BUILD
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=25G
#SBATCH --time=02:00:00
#SBATCH --partition=kipac

ml python/3.9
ml py-scipy/1.6.3_py39
ml viz
ml py-matplotlib/3.4.2_py39
ml py-numpy/1.20.3_py39
srun python3 run_build_fitsdata.py /home/users/alpv95/khome/tracksml/data/spectra_68720/gen4_spec_true_flat_recon.fits /home/users/alpv95/khome/tracksml/data/spectra_68720/test_aug6 --tot 500000 --sim --augment 6
