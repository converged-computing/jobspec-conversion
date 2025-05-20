#!/bin/bash
#FLUX -N 5
#FLUX --ntasks=320
#FLUX --tasks-per-node=64
#FLUX --cpus-per-task=1
#FLUX --exclusive
#FLUX -t 24h
#FLUX --output=job.out
#FLUX --error=job.err

# The original script used 'cd $PBS_O_WORKDIR'.
# Flux jobs typically start in the directory where 'flux submit' or 'flux batch'
# was executed, so this line is often not needed.
# If required, ensure you are in the correct directory or use 'cd /path/to/workdir'.
# For example, if submitting from the work directory:
# cd "$(pwd)"

module purge

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1

# WARNING: The following 'find ... -exec rm' commands might delete this script
# itself if it's not named 'run.slurm' or contains 'slurm' in its name and
# resides in the current directory. Adapt the exclusion pattern if needed, e.g.,
# ! -name 'this_script_name.flux'
find . -maxdepth 1 ! -name 'run.slurm' -type f -exec rm  {} +
cp input/* .

module load CP2K/2022.1-foss-2022a

# Set path to the CP2K executable
# Default CP2K 2022.1 from module (example, not used if overridden)
#cp2k_module_default=/gpfs/easybuild/prod/software/CP2K/2022.1-foss-2022a/bin/cp2k.psmp

# Custom CP2K paths (original script selected the last one)
#cp2k=/gpfs/home/cahart/software/cp2k-master/exe/local/cp2k.psmp
#cp2k=/gpfs/home/cahart/software/cp2k-2022.1/exe/local/cp2k.psmp
#cp2k=/gpfs/home/cahart/software/cp2k-2022.2/exe/local/cp2k.psmp
#cp2k_smeagol=/gpfs/home/cahart/software/smeagol/cp2k-smeagol/cp2k-private/exe/local/cp2k.psmp
cp2k=/gpfs/home/cahart/software/smeagol/cp2k-smeagol/cp2k-private-external-blas/exe/local/cp2k.psmp

# WARNING: Second cleanup. This might be redundant or have unintended consequences
# depending on the contents of 'input/' and the script's filename.
# See warning above regarding the 'find' command.
find . -maxdepth 1 ! -name '*slurm*' -type f -exec rm  {} +
cp input/* .

kpoints_bulk="2 4 20"
kpoints_em="2 4 1"

sed -i -e "s/KPOINTS_REPLACE/$kpoints_bulk/g"  1_bulkLR.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  2_dft_wfn.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  3_0V.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  4_V.inp

# Execute CP2K using flux run
# flux run will automatically use the allocated 320 tasks
flux run $cp2k -i 2_dft_wfn.inp -o log_2_dft_wfn.out