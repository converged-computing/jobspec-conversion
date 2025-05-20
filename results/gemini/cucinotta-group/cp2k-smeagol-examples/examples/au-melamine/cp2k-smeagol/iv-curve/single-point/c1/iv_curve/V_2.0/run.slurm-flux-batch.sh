#!/bin/bash
#flux: -N 8
#flux: -n 256
#flux: -c 2
#flux: --tasks-per-node=32
#flux: --walltime=06:00:00
#flux: --output=job.out
#flux: --error=job.err

# Assuming the job is submitted from the working directory,
# equivalent to PBS_O_WORKDIR. If not, cd to the correct directory here.
# cd /path/to/your/working/directory

module purge

export OMP_NUM_THREADS=2
export MKL_NUM_THREADS=2

# Original script had a specific exclusion for 'run.slurm'
find . -maxdepth 1 ! -name 'run.slurm' -type f -exec rm {} +
cp input/* .

module load CP2K/2022.1-foss-2022a

# Define the CP2K executable path
# Default CP2K 2022.1
#cp2k=/gpfs/easybuild/prod/software/CP2K/2022.1-foss-2022a/bin/cp2k.psmp

# CP2K official
#cp2k=/gpfs/home/cahart/software/cp2k-master/exe/local/cp2k.psmp
#cp2k=/gpfs/home/cahart/software/cp2k-2022.1/exe/local/cp2k.psmp
#cp2k=/gpfs/home/cahart/software/cp2k-2022.2/exe/local/cp2k.psmp

# CP2K-SMEAGOL
#cp2k=/gpfs/home/cahart/software/smeagol/cp2k-smeagol/cp2k-private/exe/local/cp2k.psmp
cp2k=/gpfs/home/cahart/software/smeagol/cp2k-smeagol/cp2k-private-external-blas/exe/local/cp2k.psmp

# Original script had a more general exclusion for '*slurm*'
find . -maxdepth 1 ! -name '*slurm*' -type f -exec rm {} +
cp input/* .

kpoints_bulk="2 4 20"
kpoints_em="2 4 1"

sed -i -e "s/KPOINTS_REPLACE/$kpoints_bulk/g" 1_bulkLR.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g" 2_dft_wfn.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g" 3_0V.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g" 4_V.inp

bulk_folder=/gpfs/home/cahart/transport/melamine/au_from-h2/leads/leads-sz_kpoints-2-4-20
cp $bulk_folder/*bulk* .
wait # wait is likely not necessary here as cp is synchronous

#dft_folder=/gpfs/home/cahart/transport/melamine/au_size-6-6-6/capacitor/dft_kpoints-1-1-20
#cp $dft_folder/*dft* .
#wait

HLB="$(grep '0.0000000000' bulk-VH_AV.dat | head -1 | awk '{print $2}')"

#sed -i -e "s/HLB_REPLACE/${HLB}/g"  3_0V.inp
#flux run $cp2k -i 3_0V.inp -o log_3_0V.out

V=2.0
echo $V
mv 4_V.inp 4_${V}V.inp
sed -i -e "s/PROJECT_REPLACE/${V}V/g" 4_${V}V.inp
sed -i -e "s/HLB_REPLACE/${HLB}/g" 4_${V}V.inp
sed -i -e "s/V_REPLACE/${V}/g" 4_${V}V.inp

# flux run will inherit the -n 256 and -c 2 from the batch directives
flux run $cp2k -i 4_${V}V.inp -o log_4_${V}V.out