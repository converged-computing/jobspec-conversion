#!/bin/bash
#FLUX: --job-name=0_disp2d
#FLUX: -n=24
#FLUX: --queue=action
#FLUX: -t=86400
#FLUX: --urgency=16

/scratch/mtayl29/rad-in-rust/target/release/rad-in-rust disp2d 1.0 -0.60205999132 -1.0 1 480 21 4
