#!/bin/bash
#FLUX: --job-name=swampy-snack-8677
#FLUX: --urgency=16

ml GCC/10.2.0
ml POV-Ray/3.7.0.8
povray benchmark.ini +Opovray_$SLURM_JOB_ID.png
