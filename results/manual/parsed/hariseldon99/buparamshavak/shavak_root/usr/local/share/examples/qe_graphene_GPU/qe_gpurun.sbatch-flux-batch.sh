#!/bin/bash
#FLUX: --job-name=qetest-gr
#FLUX: -n=16
#FLUX: --queue=GPU
#FLUX: -t=43200
#FLUX: --urgency=16

export PSEUDO_DIR_HOST='./pseudo/'
export PSEUDO_DIR_IMG='/pseudo '
export PSEUDO_LIST='C.pbe-n-rrkjus_psl.0.1.UPF'
export TMP_DIR='./tmp'
export QE_IMGDIR='$SIFDIR/qe'
export QE_IMG='qe-7.1-thermopw-20230501.sif'
export OMPI_MCA_btl='self,vader,tcp'
export SINGULARITYENV_PMIX_MCA_gds='hash'
export OPENMPI_HOME='/opt/nvidia/hpc_sdk/Linux_x86_64/23.3/comm_libs/openmpi/openmpi-3.1.5'
export OPAL_PREFIX='${OPENMPI_HOME}'
export OPAL_EXEC_PREFIX='${OPENMPI_HOME}'
export OPAL_BINDIR='${OPENMPI_HOME}/bin'
export OPAL_SBINDIR='${OPENMPI_HOME}/sbin'
export OPAL_LIBEXECDIR='${OPENMPI_HOME}/libexec'
export OPAL_DATAROOTDIR='${OPENMPI_HOME}/share'
export OPAL_DATADIR='${OPENMPI_HOME}/share'
export OPAL_SYSCONFDIR='${OPENMPI_HOME}/etc'
export OPAL_LOCALSTATEDIR='${OPENMPI_HOME}/etc'
export OPAL_LIBDIR='${OPENMPI_HOME}/lib'
export OPAL_INCLUDEDIR='${OPENMPI_HOME}/include'
export OPAL_INFODIR='${OPENMPI_HOME}/share/info'
export OPAL_MANDIR='${OPENMPI_HOME}/share/man'
export OPAL_PKGDATADIR='${OPENMPI_HOME}/share/openmpi'
export OPAL_PKGLIBDIR='${OPENMPI_HOME}/lib/openmpi'
export OPAL_PKGINCLUDEDIR='${OPENMPI_HOME}/include/openmpi'
export SINGULARITY='singularity run --nv -B ${PWD}:/host_pwd -B ${PSEUDO_DIR_HOST}:${PSEUDO_DIR_IMG} --pwd /host_pwd ${QE_IMGDIR}/${QE_IMG}'

export PSEUDO_DIR_HOST=./pseudo/
export PSEUDO_DIR_IMG=/pseudo 
export PSEUDO_LIST="C.pbe-n-rrkjus_psl.0.1.UPF"
export TMP_DIR=./tmp
cat > scf.in << EOF
&CONTROL
calculation   = 'scf'
pseudo_dir    = '${PSEUDO_DIR_IMG}/',
outdir        = '${TMP_DIR}/',
prefix        = 'gr'
/
&SYSTEM
ibrav         = 4
a             = 2.4639055825
c             = 15.0
nat           = 2
ntyp          = 1
occupations   = 'smearing'
smearing      = 'mv'
degauss       = 0.020
ecutwfc       = 40
/
&ELECTRONS
mixing_beta   = 0.7
conv_thr      = 1.0D-6
/
ATOMIC_SPECIES
C 12.0107 ${PSEUDO_LIST}
ATOMIC_POSITIONS (crystal)
C  0.333333333  0.666666666  0.500000000
C  0.666666666  0.333333333  0.500000000
K_POINTS (automatic)
12 12 1 0 0 0
EOF
cat > nscf.in << EOF
&CONTROL
calculation   = 'nscf'
pseudo_dir    = '${PSEUDO_DIR_IMG}/',
outdir        = '${TMP_DIR}/',
prefix        = 'gr'
/
&SYSTEM
ibrav         = 4
a             = 2.4639055825
c             = 15.0
nat           = 2
ntyp          = 1
nbnd          = 16
occupations   = 'tetrahedra'
ecutwfc       = 40
/
&ELECTRONS
mixing_beta   = 0.7
conv_thr      = 1.0D-6
/
ATOMIC_SPECIES
C 12.0107 ${PSEUDO_LIST}
ATOMIC_POSITIONS (crystal)
C  0.333333333  0.666666666  0.500000000
C  0.666666666  0.333333333  0.500000000
K_POINTS (automatic)
48 48 1 0 0 0
EOF
cat > bands.in << EOF
&BANDS
 outdir  = './tmp/'
 prefix  = 'gr'
 filband = 'gr.bands'
/
EOF
cat > dos.in << EOF
&DOS
outdir = '${TMP_DIR}/',
prefix = 'gr'
fildos = 'gr.dos'
/
EOF
export QE_IMGDIR=$SIFDIR/qe
export QE_IMG=qe-7.1-thermopw-20230501.sif
export OMPI_MCA_btl="self,vader,tcp"
export SINGULARITYENV_PMIX_MCA_gds=hash
export OPENMPI_HOME=/opt/nvidia/hpc_sdk/Linux_x86_64/23.3/comm_libs/openmpi/openmpi-3.1.5
export OPAL_PREFIX=${OPENMPI_HOME}
export OPAL_EXEC_PREFIX=${OPENMPI_HOME}
export OPAL_BINDIR=${OPENMPI_HOME}/bin
export OPAL_SBINDIR=${OPENMPI_HOME}/sbin
export OPAL_LIBEXECDIR=${OPENMPI_HOME}/libexec
export OPAL_DATAROOTDIR=${OPENMPI_HOME}/share
export OPAL_DATADIR=${OPENMPI_HOME}/share
export OPAL_SYSCONFDIR=${OPENMPI_HOME}/etc
export OPAL_LOCALSTATEDIR=${OPENMPI_HOME}/etc
export OPAL_LIBDIR=${OPENMPI_HOME}/lib
export OPAL_INCLUDEDIR=${OPENMPI_HOME}/include
export OPAL_INFODIR=${OPENMPI_HOME}/share/info
export OPAL_MANDIR=${OPENMPI_HOME}/share/man
export OPAL_PKGDATADIR=${OPENMPI_HOME}/share/openmpi
export OPAL_PKGLIBDIR=${OPENMPI_HOME}/lib/openmpi
export OPAL_PKGINCLUDEDIR=${OPENMPI_HOME}/include/openmpi
export SINGULARITY="singularity run --nv -B ${PWD}:/host_pwd -B ${PSEUDO_DIR_HOST}:${PSEUDO_DIR_IMG} --pwd /host_pwd ${QE_IMGDIR}/${QE_IMG}"
echo "###########################################"
echo "SCF Calculation:"
srun $SINGULARITY pw.x < scf.in > scf.out
echo "###########################################"
echo "NSCF Calculation:"
srun $SINGULARITY pw.x < nscf.in > nscf.out
echo "###########################################"
echo "BAND Calculation:"
srun $SINGULARITY bands.x < bands.in > bands.out
echo "###########################################"
echo "DOS Calculation:"
srun $SINGULARITY dos.x < dos.in > dos.out
