#!/bin/bash
#FLUX: --job-name=ornery-buttface-8615
#FLUX: --priority=16

cd path
/home/alfredo/Software/NAMD_Git-2021-03-23_Linux-x86_64-multicore/namd2 +auto-provision +isomalloc_sync namd > 1.log
