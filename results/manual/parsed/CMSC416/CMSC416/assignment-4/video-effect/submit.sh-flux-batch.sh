#!/bin/bash
#FLUX: --job-name=doopy-bits-5349
#FLUX: --priority=16

export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:/cvmfs/hpcsw.umd.edu/spack-software/2022.06.15/linux-rhel8-zen2/gcc-9.4.0/opencv-4.5.2-xxyodykxk3vuw64tlvm6sujgaxnctgep/lib64'

module load cuda opencv
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/cvmfs/hpcsw.umd.edu/spack-software/2022.06.15/linux-rhel8-zen2/gcc-9.4.0/cuda-11.6.2-eonihhhvlh4s2d6riyb7al2qivzn477u/lib64"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/cvmfs/hpcsw.umd.edu/spack-software/2022.06.15/linux-rhel8-zen2/gcc-9.4.0/opencv-4.5.2-xxyodykxk3vuw64tlvm6sujgaxnctgep/lib64"
./video-effect video video-edge.mp4 edge 128 128 100 frame-100.csv
