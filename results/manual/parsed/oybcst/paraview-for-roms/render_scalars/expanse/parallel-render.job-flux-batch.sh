#!/bin/bash
#FLUX: --job-name=gnu-parallel-render
#FLUX: --queue=compute
#FLUX: --urgency=16

export SLURM_EXPORT_ENV='ALL'

export SLURM_EXPORT_ENV=ALL
module purge
module load cpu/0.15.4
module load gcc/10.2.0
module load openmpi/4.0.4
module load paraview/5.8.0-openblas
module load parallel
module load slurm
NCDIR=/expanse/lustre/projects/ncs124/mvanmoer/zhilong/
BINDIR=$HOME/Vis/projects/lowe-esrt/bin/rendering/
cd /scratch/$USER/job_$SLURM_JOB_ID
readarray -d '' NCS < <(find $NCDIR -name "*.nc" -print0)
var=temp
zslice=0
min=10
max=35
colormap=$HOME/Vis/projects/lowe-esrt/data/assets/plasma_export.json
name=${var}_${zslice}_closeup
srun="srun --exclusive -N1 -n1"
parallel="time -p parallel --delay 0.2 -j $SLURM_NTASKS --joblog $name.log --resume"
renderscript="render-scalar.py $var $zslice $min $max $colormap $name"
printf '%s\n' "${NCS[@]}" | $parallel "$srun pvbatch $BINDIR/$renderscript {} > $name.log.{#}"
tar cvf $name.tar $name*png
mv $name.tar /expanse/lustre/projects/ncs124/$USER/renders/frames
rm -rf $name*png
tar cvf logs-$name.tar $name.log*
mv logs-$name.tar /expanse/lustre/projects/ncs124/$USER/renders/frames
rm -rf $name.log*
