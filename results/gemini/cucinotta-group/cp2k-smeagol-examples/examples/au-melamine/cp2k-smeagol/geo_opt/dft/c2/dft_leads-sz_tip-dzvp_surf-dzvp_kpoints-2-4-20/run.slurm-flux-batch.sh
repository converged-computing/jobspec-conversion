#!/bin/bash
#FLUX: -N 8
#FLUX: --ntasks-per-node=64
#FLUX: --cores-per-task=1
#FLUX: --mem-per-node=200G
#FLUX: -t 01:00:00
#FLUX: --output=job.out
#FLUX: --error=job.err

# Change to the directory where the job was submitted, if not default
# Flux typically starts in the submission directory, so this might be optional.
# If needed, use: cd $(flux job workdir) or ensure submission from the correct path.

module purge

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1

# Clean up files, preserving files with 'slurm' in their name
# Note: The original script had two similar find commands.
# The first one excludes 'run.slurm' specifically.
# The second one excludes any file with 'slurm' in its name.
# This effectively means files like 'run.slurm' or 'abc.slurm.txt' are preserved.
find . -maxdepth 1 ! -name 'run.slurm' -type f -exec rm  {} +
cp input/* .

# This second find command might be redundant if 'run.slurm' is the only 'slurm' file
# or if the intention was different. Preserving original logic.
find . -maxdepth 1 ! -name '*slurm*' -type f -exec rm  {} +
cp input/* .


module load CP2K/2022.1-foss-2022a

# Define the CP2K executable path
# Default CP2K 2022.1 (from module)
# cp2k_exe_from_module=$(which cp2k.psmp) # If module provides it in PATH

# CP2K official (user compiled versions - commented out in original)
#cp2k=/gpfs/home/cahart/software/cp2k-master/exe/local/cp2k.psmp
#cp2k=/gpfs/home/cahart/software/cp2k-2022.1/exe/local/cp2k.psmp
#cp2k=/gpfs/home/cahart/software/cp2k-2022.2/exe/local/cp2k.psmp

# CP2K-SMEAGOL (user compiled version - active in original)
cp2k=/gpfs/home/cahart/software/smeagol/cp2k-smeagol/cp2k-private-external-blas/exe/local/cp2k.psmp

kpoints_bulk="2 4 20"
kpoints_em="2 4 1"

sed -i -e "s/KPOINTS_REPLACE/$kpoints_bulk/g"  1_bulkLR.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  2_dft_wfn.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  3_0V.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  4_V.inp

# Execute CP2K using flux run
# flux run will use the allocated tasks (N * ntasks-per-node)
flux run $cp2k -i 2_dft_wfn.inp -o log_2_dft_wfn.out