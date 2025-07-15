#!/bin/bash
#FLUX: --job-name=dinosaur-eagle-3733
#FLUX: -n=24
#FLUX: --priority=16

/scratch/mtayl29/rad-in-rust/target/release/rad-in-rust disp2d 1.0 -0.60205999132 -1.0 1 480 21 4
