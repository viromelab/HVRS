#!/bin/bash
#
#
# INSTALL SIMULATION AND EVALUATION TOOLS:
#
INSTALL_TOOLS=0;
INSTALL_MINICONDA=0;
INSTALL_SAMTOOLS=0;
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
RUN_QVG=0;
RUN_VPIPE=0;
RUN_STRAINLINE=0;
RUN_HAPHPIPE=0;
RUN_ABAYESQR=0;
RUN_HAPLOCLIQUE=0;
RUN_VISPA=0;
RUN_QUASIRECOMB=0;
RUN_LAZYPIPE=0;
RUN_VIQUAS=0;
RUN_MLEHAPLO=0;
RUN_PEHAPLO=0;
RUN_REGRESSHAPLO=0;
RUN_CLIQUESNV=0;
RUN_IVA=0;
RUN_PRICE=0;
RUN_VIRGENA=0;
RUN_TARVIR=0;
RUN_VIP=0;
RUN_DRVM=0;
RUN_SSAKE=0;
RUN_VIRALFLYE=1;


if [[ "$INSTALL_TOOLS" -eq "1" ]] 
  then
  printf "Installing tools\n\n"
  sudo apt-get install libopenblas-base
  conda install -c cobilab -y gto
  conda install -c bioconda -y art
  conda install -c bioconda -y mummer4
fi

if [[ "$INSTALL_MINICONDA" -eq "1" ]] 
  then
  printf "Installing Miniconda\n\n" #missing get install files
  Miniconda3-py39_4.12.0-Linux-x86_64.sh
fi

#also requires git
#sudo apt install git
#sudo apt-get install g++

if [[ "$INSTALL_SAMTOOLS" -eq "1" ]] 
  then
  printf "Installing Samtools\n\n"
  sudo apt-get install samtools
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

#V-pipe
if [[ "$RUN_VPIPE" -eq "1" ]] 
  then
  printf "Installing V-pipe\n\n"
  curl -O 'https://raw.githubusercontent.com/cbg-ethz/V-pipe/master/utils/quick_install.sh'
  chmod +x ./quick_install.sh
  ./quick_install.sh -w work
fi

#Strainline
if [[ "$RUN_STRAINLINE" -eq "1" ]] #error linking daccord
  then
  printf "Installing Strainline\n\n"
  #conda create -n strainline
  #conda activate strainline
  #conda install -c bioconda minimap2 spoa samtools dazz_db daligner metabat2  
  
  echo Please input the path to miniconda.
  read miniconda
  echo $miniconda
  
  wget https://github.com/gt1/daccord/releases/download/0.0.10-release-20170526170720/daccord-0.0.10-release-20170526170720-x86_64-etch-linux-gnu.tar.gz
  tar -zvxf daccord-0.0.10-release-20170526170720-x86_64-etch-linux-gnu.tar.gz 
  ln -fs $PWD/daccord-0.0.10-release-20170526170720-x86_64-etch-linux-gnu/bin/daccord $miniconda/envs/strainline/bin/daccord #line not working
fi

#HAPHPIPE - error
if [[ "$RUN_HAPHPIPE" -eq "1" ]] 
  then
  printf "Installing HAPHPIPE\n\n"
  conda create -n haphpipe haphpipe
  conda activate haphpipe
  wget https://anaconda.org/bioconda/gatk/3.8/download/linux-64/gatk-3.8-py35_0.tar.bz2
  #bzip2 -d gatk-3.8-py35_0.tar.bz2
  mkdir -p gatk
  tar -jxf gatk-3.8-py35_0.tar.bz2 --directory gatk
  cd gatk/bin/
  ./gatk-register GenomeAnalysisTK #i dont know what the file is
  cd ../../
fi

#aBayesQR
if [[ "$RUN_ABAYESQR" -eq "1" ]] 
  then
  printf "Installing aBayesQR\n\n"
  rm -rf aBayesQR
  git clone https://github.com/SoYeonA/aBayesQR.git
  cd aBayesQR
  make
  cd ..  
fi

#HaploClique - permission errors, ...
if [[ "$RUN_HAPLOCLIQUE" -eq "1" ]] 
  then
  printf "Installing HaploClique\n\n"
  apt-get install libncurses5-dev cmake libboost-all-dev git build-essential zlib1g-dev parallel
  git clone https://github.com/armintoepfer/haploclique
  cd haploclique
  sh install-additional-software.sh
  mkdir build
  cd build
  cmake ..
  make
  make install
fi

#ViSpA
if [[ "$RUN_VISPA" -eq "1" ]] 
  then
  printf "Installing ViSpA\n\n"
  wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mosaik-aligner/MOSAIK-2.1.73-binary.tar
  tar -xf MOSAIK-2.1.73-binary.tar
  wget https://alan.cs.gsu.edu/NGS/sites/default/files/vispa02.zip
  rm -rf home
  unzip vispa02.zip 
  
fi

#QuasiRecomb
if [[ "$RUN_QUASIRECOMB" -eq "1" ]] 
  then
  printf "Installing QuasiRecomb\n\n"
  wget https://github.com/cbg-ethz/QuasiRecomb/archive/refs/tags/v1.2.zip
  wget https://github.com/cbg-ethz/QuasiRecomb/releases/download/v1.2/QuasiRecomb.jar
  unzip v1.2.zip 
  
fi

#Lazypipe 
if [[ "$RUN_LAZYPIPE" -eq "1" ]] 
  then
  printf "Installing Lazypipe\n\n"
  
fi

#ViQuaS
if [[ "$RUN_VIQUAS" -eq "1" ]] 
  then
  printf "Installing ViQuaS\n\n"
  wget -O viquas "https://sourceforge.net/projects/viquas/files/latest/download"
  tar -xzf viquas
  rm viquas
  
fi

#MLEHaplo
if [[ "$RUN_MLEHAPLO" -eq "1" ]] 
  then
  printf "Installing MLEHaplo\n\n"
  
  
fi

#PEHaplo
if [[ "$RUN_PEHAPLO" -eq "1" ]] 
  then
  printf "Installing PEHaplo\n\n"
  wget -O networkx "https://github.com/networkx/networkx/archive/refs/tags/networkx-1.11.zip"
  unzip networkx
  rm networkx
  cd networkx-1.11/  
  sudo python setup.py install
  wget -O apsp "https://github.com/chjiao/Apsp/archive/refs/tags/V0.zip"
  unzip apsp
  rm apsp
  cd Apsp-0  
  make
  git clone https://github.com/chjiao/PEHaplo.git
  
  conda create -n pehaplo python=2.7 
  
fi

#RegressHaplo
if [[ "$RUN_REGRESSHAPLO" -eq "1" ]] 
  then
  printf "Installing RegressHaplo\n\n"
  
fi

#CliqueSNV
if [[ "$RUN_CLIQUESNV" -eq "1" ]] 
  then
  printf "Installing CliqueSNV\n\n"
  wget -O cliquesnv "https://github.com/vtsyvina/CliqueSNV/archive/refs/tags/2.0.3.zip"
  unzip cliquesnv
  rm cliquesnv
  
fi

#IVA
if [[ "$RUN_IVA" -eq "1" ]] 
  then
  printf "Installing IVA\n\n"
  
fi

#PRICE
if [[ "$RUN_PRICE" -eq "1" ]] 
  then
  printf "Installing PRICE\n\n"
  wget -O price "https://sourceforge.net/projects/pricedenovo/files/latest/download"
  tar -xzf price
  rm -rf price
  cd PriceSource130506
  make
  cd ..
    
fi

#VirGenA
if [[ "$RUN_VIRGENA" -eq "1" ]] 
  then
  printf "Installing VirGenA\n\n"
  wget -O virgena "https://github.com/gFedonin/VirGenA/releases/download/1.4/VirGenA_v1.4.zip"
  unzip virgena
  rm virgena
  
fi

#TAR-VIR - untested
if [[ "$RUN_TARVIR" -eq "1" ]] 
  then
  printf "Installing TAR-VIR\n\n"
  conda config --add channels defaults
  conda config --add channels conda-forge
  conda config --add channels bioconda
  conda config --add channels kennethshang
  
  conda create -n bio2 python=2.7     # You can replace bio2 to any name you like
  conda activate bio2                 # Activate your env
  source activate bio2                # Sometimes you need to use this command to activate the environment. Try conda activate first.
  pip install networkx=1.11           # currently TAR-VIR only works with this version. Under some systems, use pip install networkx==1.11. Type both and see the hints. 
  conda install Karect bamtools==2.4.0 apsp sga samtools bowtie2 overlap_extension genometools-genometools
  git clone --recursive https://github.com/chjiao/TAR-VIR.git
 

fi

#VIP - untested
if [[ "$RUN_VIP" -eq "1" ]] 
  then
  printf "Installing VIP\n\n"
  wget -O vip "https://github.com/keylabivdc/VIP/archive/refs/heads/master.zip"
  unzip vip
  cd VIP
  cd installer
  chmod +x ./dependency_installer.sh
  chmod +x ./db_installer.sh
  ./dependency_installer.sh
  #./db_installer.sh -r [PATH]/[TO]/[DATABASE]
  
fi

#drVM
if [[ "$RUN_DRVM" -eq "1" ]] 
  then
  printf "Installing drVM\n\n"
  wget -O drvm "https://sourceforge.net/projects/sb2nhri/files/latest/download"
  unzip drvm
  #rm -rf drvm
  
fi

#SSAKE
if [[ "$RUN_SSAKE" -eq "1" ]] 
  then
  printf "Installing SSAKE\n\n"
  wget -O ssake "https://github.com/bcgsc/SSAKE/releases/download/v4.0.1/ssake_v4-0.tar.gz"
  tar -xzf ssake
  #rm -rf ssake
  
fi

#viralFlye
if [[ "$RUN_VIRALFLYE" -eq "1" ]] 
  then
  printf "Installing viralFlye\n\n"
  git clone https://github.com/Dmitry-Antipov/viralFlye
  cd viralFlye
  install.sh
  cd ..
  wget http://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam34.0/Pfam-A.hmm.gz
fi



