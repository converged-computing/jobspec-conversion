#!/bin/bash
#FLUX: --job-name=esdm
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --priority=16

export PATH='$TGT/bin:$PATH'
export PKG_CONFIG_PATH='$TGT/lib/pkgconfig/:$TGT/lib64/pkgconfig/:$PKG_CONFIG_PATH'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/cray/libfabric/1.11.0.0.233/lib64/'

TGT=/work/n02/n02/kunkel/esdm/install
wget https://digip.org/jansson/releases/jansson-2.13.1.tar.bz2
cd jansson-2.13.1/
./configure  --prefix=$TGT
make -j install
cd ..
module load cray-python/3.8.5.0
pip install meson
pip install ninja
export PATH=$PATH:$HOME/.local/bin/
wget https://gitlab.gnome.org/GNOME/glib/-/archive/2.67.1/glib-2.67.1.tar.bz2
tar -xf glib*
cd glib-2.67.1/
$HOME/.local/bin/meson build --prefix=$TGT
cd build
ninja install
cd ..
wget https://support.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.10.5.tar.gz
tar -xzf hdf5*.gz
cd hdf5-1.10.5
./configure --enable-parallel --prefix=$TGT CC=cc
make -j install
RUN git clone --recurse-submodules https://github.com/ESiWACE/esdm.git
export PATH=$PATH:$TGT/bin
export PKG_CONFIG_PATH=$TGT/lib/pkgconfig/:$TGT/lib64/pkgconfig/:$PKG_CONFIG_PATH
cd esdm
./configure --prefix=$TGT
cd build
make -j install
cd ../../
git clone --recurse-submodules https://github.com/ESiWACE/esdm-netcdf.git
cd esdm-netcdf
autoreconf
cd build
../configure --prefix=$TGT --with-esdm=$TGT CC=cc  --disable-dap
make -j install LDFLAGS="-L$TGT/lib/ -lsmd -ljansson"
git clone https://github.com/joobog/netcdf-bench.git
cd netcdf-bench/
cmake -DNETCDF_INCLUDE_DIR=$TGT/include  -DNETCDF_LIBRARY=$TGT/lib/libnetcdf.so
make
cp ./src/benchtool $TGT/bin
cd ..
cat > test.slurm << EOF
export PATH=$TGT/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/libfabric/1.11.0.0.233/lib64/
ldd $(which benchtool)
mkfs.esdm --ignore-errors --remove --create -g -l
srun --hint=nomultithread --distribution=cyclic:cyclic benchtool -w -r --verify -f="esdm://out" -p=2 -n=2
mkfs.esdm --ignore-errors --remove --create -g -l
EOF
echo "Now submit the test.slurm file!"
