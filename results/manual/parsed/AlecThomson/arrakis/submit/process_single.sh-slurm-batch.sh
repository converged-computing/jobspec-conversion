#!/bin/bash
#SBATCH --job-name=processSPICE
#SBATCH --account=askaprt
#SBATCH --output=/group/askap/athomson/projects/arrakis/spica/slurmLogs/slurm-%j.out
#SBATCH --error=/group/askap/athomson/projects/arrakis/spica/slurmLogs/slurm-%j.err
#SBATCH --mail-user=alec.thomson@csiro.au
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=500
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=20

export OMP_NUM_THREADS='1'
export SINGULARITY_BINDPATH='$(pwd),/group'

export OMP_NUM_THREADS=1
conda activate spice
module load singularity
export SINGULARITY_BINDPATH=$(pwd),/group
field='1600-50A'
echo Running pipeline on $field
cal_sbid=`find_sbid.py $field --cal`
weight=`find_sbid.py $field --weight`
weight_pad=`printf "%05d\n" $weight`
zernike=/group/askap/athomson/projects/arrakis/leakages/${weight_pad}_zernike_holo_cube.fits
data_dir=/group/ja3/athomson/spica
config=/group/askap/athomson/projects/arrakis/spica/spica_config.txt
cd $data_dir
sedstr="s/sbatch/${field}.${SLURM_JOB_ID}\.sbatch/g"
slurmdir="/group/askap/athomson/projects/arrakis/spica/slurmFiles"
currentdir="/group/askap/athomson/repos/arrakis/submit"
sedstr2="s+${currentdir}+${slurmdir}+g"
echo "Correcting for leakage"
srun -n $SLURM_NTASKS --export=ALL spice_process $field $data_dir/$cal_sbid/RACS_test4_1.05_$field --config $config --savePlots --use_mpi --skip_cutout --holofile $zernike
