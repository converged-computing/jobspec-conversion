#!/bin/bash
#FLUX: -N 8
#FLUX: -n 64
#FLUX: --tasks-per-node=8
#FLUX: --cores-per-task=8
#FLUX: --mem-per-node=200G
#FLUX: --walltime=06:00:00
#FLUX: --output=job.out
#FLUX: --error=job.err

# Assuming the job is submitted from the intended working directory.
# If not, uncomment and adjust the following line:
# cd $(flux job workdir)

module purge

export OMP_NUM_THREADS=8
export MKL_NUM_THREADS=8

# Clean up files from previous runs, keeping Slurm-related files (original logic)
# First cleanup pass (original had 'run.slurm')
find . -maxdepth 1 ! -name 'run.slurm' -type f -exec rm {} +
cp input/* .

module load CP2K/2022.1-foss-2022a

# Define the CP2K executable path (as per the original script's final choice)
cp2k=/gpfs/home/cahart/software/smeagol/cp2k-smeagol/cp2k-private-external-blas/exe/local/cp2k.psmp

# Second cleanup pass (original had '*slurm*')
find . -maxdepth 1 ! -name '*slurm*' -type f -exec rm {} +
cp input/* .

kpoints_bulk="1 1 20"
kpoints_em="1 1 1"

sed -i -e "s/KPOINTS_REPLACE/$kpoints_bulk/g"  1_bulkLR.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  2_dft_wfn.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  3_0V.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  4_V.inp

bulk_folder=/gpfs/home/cahart/transport/melamine/au_from-h2/leads/leads-sz_kpoints-1-1-20-cu
cp $bulk_folder/*bulk* .
wait # Original script had this, cp is synchronous, so likely not needed but kept for fidelity.

#dft_folder=/gpfs/home/cahart/transport/melamine/au_size-6-6-6/capacitor/dft_kpoints-1-1-20
#cp $dft_folder/*dft* .
#wait

HLB="$(grep '0.0000000000' bulk-VH_AV.dat | head -1 | awk '{print $2}')"
sed -i -e "s/HLB_REPLACE/${HLB}/g"  3_0V.inp

echo "Running CP2K for 3_0V.inp"
flux run $cp2k -i 3_0V.inp -o log_3_0V.out

V=1.0
echo "Processing for V=${V}"
mv 4_V.inp 4_${V}V.inp
sed -i -e "s/PROJECT_REPLACE/${V}V/g" 4_${V}V.inp
sed -i -e "s/HLB_REPLACE/${HLB}/g"  4_${V}V.inp
sed -i -e "s/V_REPLACE/${V}/g"  4_${V}V.inp

echo "Running CP2K for 4_${V}V.inp"
flux run $cp2k -i 4_${V}V.inp -o log_4_${V}V.out

echo "Job finished."