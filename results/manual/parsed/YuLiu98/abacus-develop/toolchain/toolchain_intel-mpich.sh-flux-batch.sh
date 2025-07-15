#!/bin/bash
#FLUX: --job-name=fugly-hippo-1969
#FLUX: --priority=16

./install_abacus_toolchain.sh \
--with-intel=system --math-mode=mkl \
--with-gcc=no --with-mpich=install \
--with-cmake=install \
--with-scalapack=no \
--with-libxc=install \
--with-fftw=no \
--with-elpa=install \
--with-cereal=install \
--with-rapidjson=install \
--with-libtorch=no \
--with-libnpy=no \
--with-libri=no \
--with-libcomm=no \
--with-intel-classic=no \
| tee compile.log
