#!/bin/bash
#FLUX: --job-name=processSPICE
#FLUX: -n=500
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export SINGULARITY_BINDPATH='$(pwd),/group'

export OMP_NUM_THREADS=1
conda activate spice
module load singularity
export SINGULARITY_BINDPATH=$(pwd),/group
SPICA=(
    '1416+00A'
    '1351+00A'
    '1326+00A'
    '1237+00A'
    '1302+00A'
    '1416-06A'
    '1351-06A'
    '1326-06A'
    '1302-06A'
    '1237-06A'
    '1418-12A'
    '1353-12A'
    '1328-12A'
    '1303-12A'
    '1237-12A'
    '1424-18A'
    '1357-18A'
    '1331-18A'
    '1305-18A'
    '1239-18A'
    '1429-25A'
    '1402-25A'
    '1335-25A'
    '1307-25A'
    '1240-25A'
    '1212+00A'
    '1212-06A'
    '1212-12A'
    '1213-18A'
    '1213-25A'
)
field=${SPICA[$SLURM_ARRAY_TASK_ID]}
echo Running pipeline on $field
cal_sbid=`find_sbid.py $field --cal`
weight=`find_sbid.py $field --weight`
weight_pad=`printf "%05d\n" $weight`
zernike=/group/askap/athomson/projects/arrakis/leakages_bak/${weight_pad}_zernike_holo_cube.fits
data_dir=/group/ja3/athomson/spica
config=/group/askap/athomson/projects/arrakis/spica/spica_config.txt
cd $data_dir
sedstr="s/sbatch/${field}.${SLURM_JOB_ID}\.sbatch/g"
slurmdir="/group/askap/athomson/projects/arrakis/spica/slurmFiles"
currentdir="/group/askap/athomson/repos/arrakis/submit"
sedstr2="s+${currentdir}+${slurmdir}+g"
echo "Correcting for leakage"
srun -n $SLURM_NTASKS --export=ALL spice_process $field $data_dir/$cal_sbid/RACS_test4_1.05_$field --config $config --savePlots --use_mpi --skip_cutout --holofile $zernike
