#!/bin/bash
#flux: -N 7
#flux: --ntasks-per-node=64
#flux: --cores-per-task=1
#flux: --requires=mem=200G  # Memory per node
#flux: -t 24:00:00
#flux: --job-name=cp2k_job
#flux: --output=cp2k_job.out
#flux: --error=cp2k_job.err

# Change to the submission directory (Flux default behavior, but explicit for clarity)
# $FLUX_JOB_WORKID is set to the initial working directory of the job.
if [ -n "$FLUX_JOB_WORKID" ]; then
  cd "$FLUX_JOB_WORKID"
else
  # Fallback if FLUX_JOB_WORKID is not set, though it should be in a Flux job context.
  # This assumes the script is submitted from the intended working directory.
  echo "Warning: FLUX_JOB_WORKID not set. Assuming current directory is the workdir." >&2
fi

module purge

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1

# First cleanup and copy block (preserved from original script)
find . -maxdepth 1 ! -name 'run.slurm' -type f -exec rm  {} +
cp input/* .

module load CP2K/2022.1-foss-2022a

# Define the cp2k executable path
# Default CP2K 2022.1
#cp2k=/gpfs/easybuild/prod/software/CP2K/2022.1-foss-2022a/bin/cp2k.psmp

# CP2K official
#cp2k=/gpfs/home/cahart/software/cp2k-master/exe/local/cp2k.psmp
#cp2k=/gpfs/home/cahart/software/cp2k-2022.1/exe/local/cp2k.psmp
#cp2k=/gpfs/home/cahart/software/cp2k-2022.2/exe/local/cp2k.psmp

# CP2K-SMEAGOL
#cp2k=/gpfs/home/cahart/software/smeagol/cp2k-smeagol/cp2k-private/exe/local/cp2k.psmp
cp2k=/gpfs/home/cahart/software/smeagol/cp2k-smeagol/cp2k-private-external-blas/exe/local/cp2k.psmp

# Second cleanup and copy block (preserved from original script)
find . -maxdepth 1 ! -name '*slurm*' -type f -exec rm  {} +
cp input/* .

kpoints_bulk="2 4 20"
kpoints_em="2 4 1"

sed -i -e "s/KPOINTS_REPLACE/$kpoints_bulk/g"  1_bulkLR.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  2_dft_wfn.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  3_0V.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  4_V.inp

# Execute the application using flux run
# flux run will use the resources allocated to the job (-N, --ntasks-per-node, etc.)
flux run $cp2k -i 2_dft_wfn.inp -o log_2_dft_wfn.out