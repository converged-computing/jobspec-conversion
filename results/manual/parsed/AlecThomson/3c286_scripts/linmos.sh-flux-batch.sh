#!/bin/bash
#FLUX: --job-name=linmos
#FLUX: -n=36
#FLUX: -t=3600
#FLUX: --priority=16

module load singularity
module load rclone
module load openmpi
beam=0 #$SLURM_ARRAY_TASK_ID
workdir=/scratch3/projects/spiceracs/3C286_flint_main/51997
base=SB51997.3C286_45deg.beam$beam
rclone copy -P --transfers $SLURM_NTASKS --checkers $SLURM_NTASKS --include="$base.*cube.fits" ./ $MEMDIR/
for stokes in i q u; do
mv $MEMDIR/$base.${stokes}cube.fits $MEMDIR/$base.${stokes}.cube.fits
    ./fix_header.py $MEMDIR/$base.${stokes}.cube.fits
    cat << EOF > $MEMDIR/$base.linmos.$stokes.parset
linmos.names            = $MEMDIR/$base.${stokes}.cube.fixed
linmos.imagetype        = fits
linmos.outname          = $MEMDIR/$base.${stokes}.cube.pbcor
linmos.outweight        = $MEMDIR/$base.${stokes}.cube.pbcor.weight
linmos.useweightslog    = true
linmos.weighttype       = FromPrimaryBeamModel
linmos.weightstate      = Inherent
linmos.primarybeam      = ASKAP_PB
linmos.primarybeam.ASKAP_PB.image = /scratch3/projects/spiceracs/akpb.iquv.closepack36.54.943MHz.SB51811.cube.fits
linmos.removeleakage    = true
EOF
    mpirun --mca btl_openib_allow_ib 1 singularity exec /datasets/work/sa-mhongoose/work/containers/askapsoft_1.15.0-openmpi4.sif linmos-mpi -c $MEMDIR/$base.linmos.$stokes.parset
done
rclone copy -P --transfers $SLURM_CPUS_PER_TASK --checkers $SLURM_CPUS_PER_TASK --include="$base.*cube.pbcor.fits" $MEMDIR/ ./
