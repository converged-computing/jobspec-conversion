#!/bin/bash
#FLUX: --job-name=yolo_v8
#FLUX: --queue=gpu06
#FLUX: -t=600
#FLUX: --priority=16

module purge
module load intel/14.0.3 mkl/14.0.3 fftw/3.3.6 impi/5.1.2
module load singularity
cd $SLURM_SUBMIT_DIR
cp *.in *UPF /scratch/$SLURM_JOB_ID
cd /scratch/$SLURM_JOB_ID
mpirun -ppn 16 -hostfile /scratch/${SLURM_JOB_ID}/machinefile_${SLURM_JOB_ID} -genv OMP_NUM_THREADS 2 \ /share/apps/espresso/qe-6.1-intel-mkl-impi/bin/pw.x -npools 1 <ausurf.in
mv ausurf.log *mix* *wfc* *igk* $SLURM_SUBMIT_DIR/
singularity exec yolo_training.sif python train_model.py
