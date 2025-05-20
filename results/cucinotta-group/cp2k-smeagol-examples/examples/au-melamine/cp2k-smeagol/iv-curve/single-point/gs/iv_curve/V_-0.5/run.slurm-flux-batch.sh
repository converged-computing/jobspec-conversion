#!/bin/bash
#FLUX: -N 8
#FLUX: --tasks-per-node=32
#FLUX: -c 2
#FLUX: --exclusive
#FLUX: --requires=mem=200G 
#FLUX: -t 06:00:00

# cd to the submission directory (PBS_O_WORKDIR equivalent)
# Flux typically starts in the submission directory, but FLUX_JOB_WORKIR can be used for explicit cd.
if [ -n "$FLUX_JOB_WORKIR" ]; then
  cd "$FLUX_JOB_WORKIR"
else
  # Fallback if FLUX_JOB_WORKIR is not set, though it should be in a Flux job environment.
  # This might indicate an issue or a different Flux version behavior.
  echo "Warning: FLUX_JOB_WORKIR not set. Staying in current directory."
fi

module purge

export OMP_NUM_THREADS=2 # Should match #FLUX: -c 2
export MKL_NUM_THREADS=2

find . -maxdepth 1 ! -name 'run.slurm' -type f -exec rm  {} +
cp input/* .

module load CP2K/2022.1-foss-2022a

# Default CP2K 2022.1
#cp2k=/gpfs/easybuild/prod/software/CP2K/2022.1-foss-2022a/bin/cp2k.psmp

# CP2K official
#cp2k=/gpfs/home/cahart/software/cp2k-master/exe/local/cp2k.psmp
#cp2k=/gpfs/home/cahart/software/cp2k-2022.1/exe/local/cp2k.psmp
#cp2k=/gpfs/home/cahart/software/cp2k-2022.2/exe/local/cp2k.psmp

# CP2K-SMEAGOL
#cp2k=/gpfs/home/cahart/software/smeagol/cp2k-smeagol/cp2k-private/exe/local/cp2k.psmp
cp2k=/gpfs/home/cahart/software/smeagol/cp2k-smeagol/cp2k-private-external-blas/exe/local/cp2k.psmp

find . -maxdepth 1 ! -name '*slurm*' -type f -exec rm  {} +
cp input/* .

kpoints_bulk="2 4 20"
kpoints_em="2 4 1"

sed -i -e "s/KPOINTS_REPLACE/$kpoints_bulk/g"  1_bulkLR.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  2_dft_wfn.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  3_0V.inp
sed -i -e "s/KPOINTS_REPLACE/$kpoints_em/g"  4_V.inp

bulk_folder=/gpfs/home/cahart/transport/melamine/au_from-h2/leads/leads-sz_kpoints-2-4-20
cp $bulk_folder/*bulk* .
wait

#dft_folder=/gpfs/home/cahart/transport/melamine/au_size-6-6-6/capacitor/dft_kpoints-1-1-20
#cp $dft_folder/*dft* .
#wait

HLB="$(grep '0.0000000000' bulk-VH_AV.dat | head -1 | awk '{print $2}')"

#sed -i -e "s/HLB_REPLACE/${HLB}/g"  3_0V.inp
#flux run $cp2k -i 3_0V.inp -o log_3_0V.out # Original was mpirun

V=-0.5
echo $V
mv 4_V.inp 4_${V}V.inp
sed -i -e "s/PROJECT_REPLACE/${V}V/g" 4_${V}V.inp
sed -i -e "s/HLB_REPLACE/${HLB}/g"  4_${V}V.inp
sed -i -e "s/V_REPLACE/${V}/g"  4_${V}V.inp

# flux run will inherit rank/node distribution from #FLUX directives
flux run $cp2k -i 4_${V}V.inp -o log_4_${V}V.out