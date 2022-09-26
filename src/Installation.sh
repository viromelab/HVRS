#!/bin/bash
#
#
# INSTALL SIMULATION AND EVALUATION TOOLS:
#
INSTALL_TOOLS=0;
RUN_SHORAH=0;
RUN_QURE=0;
RUN_SAVAGE=0;
RUN_QSDPR=0;
RUN_SPADES=0;
RUN_METAVIRALSPADES=0;
RUN_CORONASPADES=0;
RUN_VIADBG=0;
RUN_VIRUSVG=0;
RUN_VGFLOW=0;
RUN_PREDICTHAPLO=0;
RUN_TRACESPIPELITE=0;
RUN_TRACESPIPE=0;
RUN_ASPIRE=0;
RUN_QVG=1;


if [[ "$INSTALL_TOOLS" -eq "1" ]] 
  then
  printf "Installing tools\n\n"
  sudo apt-get install libopenblas-base
  conda install -c cobilab -y gto
  conda install -c bioconda -y art
  conda install -c bioconda -y mummer4
fi
#
#
# INSTALL ASSEMBLY TOOLS:

#shorah
if [[ "$RUN_SHORAH" -eq "1" ]] 
  then
  printf "Installing Shorah\n\n"  
  conda install shorah
fi

#spades, metaviralspades and coronaspades
if [[ "$RUN_SPADES" -eq "1" ]] 
  then
  printf "Installing SPAdes, metaviralSPAdes and coronaSPAdes\n\n"
  wget http://cab.spbu.ru/files/release3.15.5/SPAdes-3.15.5-Linux.tar.gz
  tar -xzf SPAdes-3.15.5-Linux.tar.gz
  rm SPAdes-3.15.5-Linux.tar.gz
fi

#SAVAGE
if [[ "$RUN_SAVAGE" -eq "1" ]] 
  then
  printf "Installing SAVAGE\n\n"
  conda install savage
fi

#qsdpr
if [[ "$RUN_QSDPR" -eq "1" ]] 
  then
  printf "Installing QSdpr\n\n"
  wget -O qsdpr "https://sourceforge.net/projects/qsdpr/files/QSdpR_v3.2.tar.gz/download"
  tar xfz qsdpr
  rm qsdpr
fi


#qure
if [[ "$RUN_QURE" -eq "1" ]] 
  then
  printf "Installing Qure\n\n"
  wget -O qure "https://sourceforge.net/projects/qure/files/latest/download"
  unzip qure
  rm qure
fi

#virus-vg
if [[ "$RUN_VIRUSVG" -eq "1" ]] 
  then
  printf "Installing Virus-VG\n\n"
  wget -O virus-vg "https://bitbucket.org/jbaaijens/virus-vg/get/69a05f3e74f26e5571830f5366570b1d88ed9650.zip"
  unzip virus-vg
  rm virus-vg
  wget "https://github.com/vgteam/vg/releases/download/v1.43.0/vg"
  chmod +x vg
fi

#vg-flow
if [[ "$RUN_VGFLOW" -eq "1" ]] 
  then
  printf "Installing VG-Flow\n\n"
  wget -O vg-flow "https://bitbucket.org/jbaaijens/vg-flow/get/ac68093bbb235e508d0a8dd56881d4e5aee997e3.zip"
  unzip vg-flow
  rm vg-flow
fi

#viaDBG
if [[ "$RUN_VIADBG" -eq "1" ]] 
  then
  printf "Installing viaDBG\n\n"
  wget http://downloads.sourceforge.net/project/boost/boost/1.60.0/boost_1_60_0.tar.gz
  tar xfz boost_1_60_0.tar.gz
  rm boost_1_60_0.tar.gz
  cd boost_1_60_0
  ./bootstrap.sh --prefix=/usr/local --with-libraries=program_options,regex,filesystem,system
  export
  ./b2 install
  cd /home
  rm -rf boost_1_60_0
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
  
  git clone https://bitbucket.org/bfreirec1/viadbg.git
  cd viadbg
  make
  
fi

#PredictHaplo
if [[ "$RUN_PREDICTHAPLO" -eq "1" ]] 
  then
  printf "Installing PredictHaplo\n\n"
  rm -rf PredictHaplo
  git clone https://github.com/bmda-unibas/PredictHaplo.git
  cd PredictHaplo
  #tar xfvz PredictHaplo-1.0.tgz
  #cd PredictHaplo-1.0.tgz      
  #tar xfvz scythestat-1.0.3.tar.gz
  #cd scythestat-1.0.3
  #./configure --prefix=PredictHaplo-1.0/NEWSCYTHE
  #make install
  #cd ..
  make
fi

#TracesPipelite
if [[ "$RUN_TRACESPIPELITE" -eq "1" ]] 
  then
  printf "Installing TRACESPipeLite\n\n"
  git clone https://github.com/viromelab/TRACESPipeLite.git
  cd TRACESPipeLite/src/
  chmod +x *.sh
  ./TRACESPipeLite.sh --install
  cd ../../  
fi

#TRACESPipe
if [[ "$RUN_TRACESPIPE" -eq "1" ]] 
  then
  printf "Installing TRACESPipe\n\n"
  git clone https://github.com/viromelab/tracespipe.git
  cd tracespipe/src/
  chmod +x TRACES*.sh
  ./TRACESPipe.sh --install
  ./TRACESPipe.sh --get-all-aux
  cd ../../  
fi

#ASPIRE
if [[ "$RUN_ASPIRE" -eq "1" ]] 
  then
  printf "Installing ASPIRE\n\n"
  rm -rf aspire/
  git clone https://github.com/kevingroup/aspire.git
fi


#QVG
if [[ "$RUN_QVG" -eq "1" ]] 
  then
  printf "Installing QVG\n\n"
  rm -rf QVG/
  git clone https://github.com/laczkol/QVG.git
fi
