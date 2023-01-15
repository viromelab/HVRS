#!/bin/bash
#
#
# INSTALL SIMULATION AND EVALUATION TOOLS:
#
INSTALL_TOOLS=0;
INSTALL_OTHERS=0;
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
RUN_HAPHPIPE=1;
RUN_ABAYESQR=0;
RUN_HAPLOCLIQUE=0;
RUN_VISPA=0;
RUN_QUASIRECOMB=0; #here
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
RUN_VIRALFLYE=0;
RUN_ENSEMBLEASSEMBLER=0;

install_samtools () {
  wget http://sourceforge.net/projects/samtools/files/samtools/0.1.18/samtools-0.1.18.tar.bz2
  tar xjf samtools-0.1.18.tar.bz2 && cd samtools-0.1.18
  make CFLAGS=-fPIC
  export SAMTOOLS=`pwd`
  cd ..
}

install_conda() {
  rm -rf Miniconda3-py39_22.11.1-1-Linux-x86_64.sh
  wget https://repo.anaconda.com/miniconda/Miniconda3-py39_22.11.1-1-Linux-x86_64.sh
  chmod +x Miniconda3-py39_22.11.1-1-Linux-x86_64.sh
  bash Miniconda3-py39_22.11.1-1-Linux-x86_64.sh
}

if [[ "$INSTALL_TOOLS" -eq "1" ]] 
  then
  printf "Installing tools\n\n"
  #sudo apt-get install libopenblas-base
  conda install -c cobilab -y gto
  conda install -c bioconda -y art
  conda install -c bioconda -y mummer4 
  
fi

if [[ "$INSTALL_OTHERS" -eq "1" ]] 
  then
  printf "Installing Miniconda\n\n"
  install_conda
  printf "Installing git\n\n"
  sudo apt install git
  printf "Installing G++\n\n"
  sudo apt-get install g++
  #printf "Installing Samtools\n\n"
  #install_samtools
  printf "Installing make"
  sudo apt install make
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
if [[ "$RUN_SPADES" -eq "1" ]] || [[ "$RUN_METAVIRALSPADES" -eq "1" ]] || [[ "$RUN_CORONASPADES" -eq "1" ]]
  then
  printf "Installing SPAdes, metaviralSPAdes and coronaSPAdes\n\n"
  wget http://cab.spbu.ru/files/release3.15.5/SPAdes-3.15.5-Linux.tar.gz
  tar -xzf SPAdes-3.15.5-Linux.tar.gz
  rm -rf SPAdes-3.15.5-Linux.tar.gz
fi

#SAVAGE
if [[ "$RUN_SAVAGE" -eq "1" ]] 
  then
  printf "Installing SAVAGE\n\n"
  eval "$(conda shell.bash hook)"
  conda create -n savage
  conda activate savage
  conda install -c bioconda -c conda-forge boost savage
  conda activate base
fi

#qsdpr
if [[ "$RUN_QSDPR" -eq "1" ]] 
  then
  printf "Installing QSdpr\n\n"
  eval "$(conda shell.bash hook)"
  conda create --name qsdpr python=2.7 
  conda activate qsdpr
  cconda install -c bioconda samtools
  wget -O qsdpr "https://sourceforge.net/projects/qsdpr/files/QSdpR_v3.2.tar.gz/download"
  tar xfz qsdpr
  rm -rf qsdpr
  conda activate base
fi


#qure
if [[ "$RUN_QURE" -eq "1" ]] 
  then
  printf "Installing Qure\n\n"
  wget -O qure "https://sourceforge.net/projects/qure/files/latest/download"
  unzip qure
  rm -rf qure
fi

#virus-vg
if [[ "$RUN_VIRUSVG" -eq "1" ]] 
  then
  printf "Installing Virus-VG\n\n"
  wget -O virus-vg "https://bitbucket.org/jbaaijens/virus-vg/get/69a05f3e74f26e5571830f5366570b1d88ed9650.zip"
  unzip virus-vg
  rm -rf virus-vg
  rm vg
  wget "https://github.com/vgteam/vg/releases/download/v1.43.0/vg"
  chmod +x vg
  eval "$(conda shell.bash hook)"
  conda env create --name virus-vg-deps --file jbaaijens-virus-vg-69a05f3e74f2/conda_list_explicit.txt
  conda activate virus-vg-deps 
  conda install -c bioconda rust-overlaps 
  conda install -c conda-forge graph-tool biopython
  pip install tqdm
  conda activate base
  
fi

#vg-flow
if [[ "$RUN_VGFLOW" -eq "1" ]] 
  then
  printf "Installing VG-Flow\n\n"
  eval "$(conda shell.bash hook)"
  conda create --name vg-flow-env
  conda activate vg-flow-env
  conda install -c bioconda -c conda-forge -c gurobi python=3 graph-tool minimap2 gurobi biopython numpy rust-overlaps 
  conda install -c conda-forge graph-tool biopython
  wget -O vg-flow "https://bitbucket.org/jbaaijens/vg-flow/get/ac68093bbb235e508d0a8dd56881d4e5aee997e3.zip"
  unzip vg-flow
  rm -rf vg-flow
  conda activate base
  sudo apt-get install minimap2
fi

#viaDBG
if [[ "$RUN_VIADBG" -eq "1" ]] 
  then
  printf "Installing viaDBG\n\n"
  #wget http://downloads.sourceforge.net/project/boost/boost/1.60.0/boost_1_60_0.tar.gz
  #tar xfz boost_1_60_0.tar.gz
  #rm boost_1_60_0.tar.gz
  #cd boost_1_60_0
  #./bootstrap.sh --prefix=/usr/local --with-libraries=program_options,regex,filesystem,system
  #export
  #./b2 install
  #cd /home
  #rm -rf boost_1_60_0
  #export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
  eval "$(conda shell.bash hook)"  
  conda create -n viadbg
  conda activate viadbg
  conda install -c conda-forge boost    
  git clone https://bitbucket.org/bfreirec1/viadbg.git
  cd viadbg
  make  
  conda activate base  
  #cd ../../../  
fi

#PredictHaplo - error on make
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
  cd ..
fi

#TracesPipelite
if [[ "$RUN_TRACESPIPELITE" -eq "1" ]] 
  then
  printf "Installing TRACESPipeLite\n\n"
  eval "$(conda shell.bash hook)"  
  conda create -n tracespipelite
  conda activate tracespipelite
  git clone https://github.com/viromelab/TRACESPipeLite.git
  cd TRACESPipeLite/src/
  chmod +x *.sh
  ./TRACESPipeLite.sh --install
  cd ../../  
  conda activate base
fi

#TRACESPipe - error on mapDamage
if [[ "$RUN_TRACESPIPE" -eq "1" ]] 
  then
  printf "Installing TRACESPipe\n\n"
  eval "$(conda shell.bash hook)"  
  conda create -n tracespipe
  conda activate tracespipe
  git clone https://github.com/viromelab/tracespipe.git
  cd tracespipe/src/
  chmod +x TRACES*.sh
  ./TRACESPipe.sh --install
  ./TRACESPipe.sh --get-all-aux
  cd ../../  
  conda activate base
fi

#ASPIRE - can't install dependencies
if [[ "$RUN_ASPIRE" -eq "1" ]] 
  then
  printf "Installing ASPIRE\n\n"
  rm -rf aspire/
  git clone https://github.com/kevingroup/aspire.git
  install_samtools  
  cpan Module::Build
  cpan App::Cmd::Setup
  cpan Bio::DB::Sam
  cpan Bio::Seq
  cpan Bio::SeqIO
  cpan Cwd
  cpan File::Path
  cpan File::Spec
  cpan IPC::Run
  cpan List::Util
  cpan Math::Round
  cpan Statistics::Descriptive::Full
fi


#QVG
if [[ "$RUN_QVG" -eq "1" ]] 
  then
  printf "Installing QVG\n\n"
  eval "$(conda shell.bash hook)"  
  #conda create -n qvg
  #conda activate qvg  
  #conda install -c bioconda fastp bwa sambamba freebayes bcftools vcflib vcftools bedtools bioawk #samtools liftoff minimap
  #conda install -c conda-forge parallel
  rm -rf QVG/
  git clone https://github.com/laczkol/QVG.git
  cd ./QVG/
  conda create --name qvg-env --file qvg-env.yaml 
  
  
  #conda activate base
fi

#V-pipe - try again
if [[ "$RUN_VPIPE" -eq "1" ]] 
  then
  printf "Installing V-pipe\n\n"
  #curl -O 'https://raw.githubusercontent.com/cbg-ethz/V-pipe/master/utils/quick_install.sh'
  #chmod +x ./quick_install.sh
  #./quick_install.sh -w work
  eval "$(conda shell.bash hook)"  
  conda create --yes -n vpipe -c conda-forge -c bioconda mamba 
  conda activate vpipe
  conda install -c bioconda snakemake
  wget "https://github.com/cbg-ethz/V-pipe/archive/refs/tags/v2.99.3.tar.gz"
  tar xvzf v2.99.3.tar.gz
  conda activate base
fi

#Strainline - seg. fault; reads.las not present
if [[ "$RUN_STRAINLINE" -eq "1" ]]
  then
  printf "Installing Strainline\n\n"
  eval "$(conda shell.bash hook)"  
  conda create -n strainline
  conda activate strainline
  conda install -c bioconda minimap2 spoa samtools dazz_db daligner metabat2   
  wget https://github.com/gt1/daccord/releases/download/0.0.10-release-20170526170720/daccord-0.0.10-release-20170526170720-x86_64-etch-linux-gnu.tar.gz
  tar -zvxf daccord-0.0.10-release-20170526170720-x86_64-etch-linux-gnu.tar.gz 
  rm -rf daccord-0.0.10-release-20170526170720-x86_64-etch-linux-gnu.tar.gz   
  printf "Please insert the path to miniconda installation. Example: /home/USER/miniconda3\n" 
  read condapath    
  ln -fs $PWD/daccord-0.0.10-release-20170526170720-x86_64-etch-linux-gnu/bin/daccord $condapath/envs/strainline/bin/daccord
  rm -rf Strainline
  git clone "https://github.com/HaploKit/Strainline.git"
  conda activate base
fi

#HAPHPIPE -
if [[ "$RUN_HAPHPIPE" -eq "1" ]] 
  then
  printf "Installing HAPHPIPE\n\n"
  eval "$(conda shell.bash hook)"
  conda create -n haphpipe
  conda activate haphpipe
  conda install -c bioconda gatk
  conda install haphpipe
  #wget https://anaconda.org/bioconda/gatk/3.8/download/linux-64/gatk-3.8-py35_0.tar.bz2
  #bzip2 -d gatk-3.8-py35_0.tar.bz2
  #mkdir -p gatkRUN_HAPLOCLIQUE
  #tar -jxf gatk-3.8-py35_0.tar.bz2 --directory gatk
  #cd gatk/bin/
  #./gatk-register GenomeAnalysisTK #i dont know what the file is
  
  #cd ../../
  conda activate base
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

#HaploClique - missing zlib, samtools
if [[ "$RUN_HAPLOCLIQUE" -eq "1" ]] 
  then
  printf "Installing HaploClique\n\n"
  rm -rf haploclique
  eval "$(conda shell.bash hook)"
  conda create -n haploclique
  conda install -c bioconda samtools
  conda install -c conda-forge zlib
  sudo apt-get install libncurses5-dev cmake libboost-all-dev git build-essential zlib1g-dev parallel
  git clone https://github.com/armintoepfer/haploclique
  cd haploclique
  sh install-additional-software.sh
  mkdir build
  cd build
  cmake ..
  make
  make install
  conda activate base
fi

#ViSpA
if [[ "$RUN_VISPA" -eq "1" ]] 
  then
  printf "Installing ViSpA\n\n"
  wget https://alan.cs.gsu.edu/NGS/sites/default/files/vispa02.zip
  rm -rf home
  unzip vispa02.zip 
  rm -rf vispa02.zip
  eval "$(conda shell.bash hook)"
  conda create --name vispa python=2.7 
  conda activate vispa
  conda install -c bioconda -c conda-forge numexpr pysam numpy biopython mosaik
  conda activate base
fi

#QuasiRecomb
if [[ "$RUN_QUASIRECOMB" -eq "1" ]] 
  then
  printf "Installing QuasiRecomb\n\n"
  eval "$(conda shell.bash hook)"
  conda create --name quasirecomb
  conda activate quasirecomb
  conda install -c bioconda samtools
  
  wget https://github.com/cbg-ethz/QuasiRecomb/archive/refs/tags/v1.2.zip
  unzip v1.2.zip 
  rm -rf v1.2.zip
  
  rm -rf QuasiRecomb.jar
  wget https://github.com/cbg-ethz/QuasiRecomb/releases/download/v1.2/QuasiRecomb.jar
  cp QuasiRecomb.jar QuasiRecomb-1.2
  
  conda activate base
  
fi

#Lazypipe - not complete, try later
if [[ "$RUN_LAZYPIPE" -eq "1" ]] 
  then
  printf "Installing Lazypipe\n\n"
  
  #rm -rf lazypipe  
  #git clone https://plyusnin@bitbucket.org/plyusnin/lazypipe.git
  #cd lazypipe
  
  eval "$(conda shell.bash hook)"
  
  conda create -n blast -c bioconda blast 
  conda create -n lazypipe -c bioconda -c eclarke bwa centrifuge csvtk fastp krona megahit mga minimap2 samtools seqkit spades snakemake-minimal taxonkit trimmomatic numpy scipy fastcluster requests
  conda activate blast
  conda activate --stack lazypipe
  
  printf "Please insert the path to miniconda installation" 
  read $condapath
  
  #rm -rf $condapath/envs/lazypipe/opt/krona/taxonomy ln -s $condapath/pkgs/krona-2.8.1-pl5262hdfd78af_0/opt/krona/taxonomy $condapath/envs/lazypipe/opt/krona/taxonomy #idk if this path is right
  export TM=$condapath/share/trimmomatic #not exporting, I think
   
  
  cd .. 
fi

#ViQuaS
if [[ "$RUN_VIQUAS" -eq "1" ]] 
  then
  printf "Installing ViQuaS\n\n"
  wget -O viquas "https://sourceforge.net/projects/viquas/files/latest/download"
  tar -xzf viquas
  rm -rf viquas
  
fi

#MLEHaplo - not able to connect to gatb
if [[ "$RUN_MLEHAPLO" -eq "1" ]] 
  then
  printf "Installing MLEHaplo\n\n"
  wget -O dsk http://gatb-tools.gforge.inria.fr/versions/bin/dsk-2.1.0-Linux.tar.gz
  tar -xzf dsk
  rm -rf dsk
  
  #cpanm Bio::Perl
  #cpanm Getopt::Long, Graph.
  
  
  
fi

#PEHaplo - part of tar-vir installation
#if [[ "$RUN_PEHAPLO" -eq "1" ]] 
#  then
#  printf "Installing PEHaplo\n\n"
#  git clone https://github.com/chjiao/PEHaplo.git 
#  conda create -n pehaplo python=2.7 networkx==1.11 apsp 
#fi

#RegressHaplo - error in r instalation
if [[ "$RUN_REGRESSHAPLO" -eq "1" ]] 
  then
  printf "Installing RegressHaplo\n\n"
  
  #install R 	
  sudo apt update
  sudo apt install r-base
  
  # Install devtools from CRAN
  
  #sudo R -e 'install.packages("devtools")'

  
  #wget -O rsource "https://cran.r-project.org/src/base/R-4/R-4.2.2.tar.gz"
  #tar -zxf rsource
  #rm -rf rsource
  #cd R-4.2.2
  #./configure
  #make
  #R --version
  #R
  
  #devtools::install_github("hadley/devtools")
  
  
  #sudo apt-get install r-base
 
 
  #install_github("hadley/devtools")
  #library(devtools)
  #install_github("SLeviyang/RegressHaplo")
  
  #source("https://bioconductor.org/biocLite.R")
  #biocLite("Biostrings")
  #biocLite("Rsamtools")
  #biocLite("GenomicAlignments")
  
  #cd ..
  
fi

#CliqueSNV
if [[ "$RUN_CLIQUESNV" -eq "1" ]] 
  then
  printf "Installing CliqueSNV\n\n"
  wget -O cliquesnv "https://github.com/vtsyvina/CliqueSNV/archive/refs/tags/2.0.3.zip"
  unzip cliquesnv
  rm -rf 2.0.3.zip 
  rm -rf cliquesnv
fi

#IVA - error, not adding to path and iva can't find kmc and smalt.
if [[ "$RUN_IVA" -eq "1" ]] 
  then
  printf "Installing IVA\n\n"
  
  #wget https://github.com/refresh-bio/KMC/releases/download/v3.2.1/KMC3.2.1.linux.tar.gz
  #rm -rf kmc
  #mkdir kmc
  #tar -xzf KMC3.2.1.linux.tar.gz -C kmc
  #rm -rf KMC3.2.1.linux.tar.gz
  #missing add to path
  
  #wget -O smalt https://sourceforge.net/projects/smalt/files/latest/download
  #tar zxvf smalt
  #rm -rf smalt
  #cd smalt-0.7.6
  #./configure
  #make
  #make install
  #missing add to path
  
  rm -rf IVAdependencies
  mkdir IVAdependencies   
  cd IVAdependencies
  cp -R ../kmc .
  cp -R ../smalt-0.7.6 .
  
  #error, not adding to path and iva can't find kmc and smalt.
  echo "\n\n Adding $(pwd) to path" 
  export PATH=$PATH:`pwd`
  
  
  
  
  #pip3 install iva
  cd ..
  
  #v2----------
  #curr_dir = $pwd
  
  #sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
  #sudo apt-get update
  #sudo apt-get install python3-pip zlib1g-dev libncurses5-dev libncursesw5-dev
  
  #export PATH=$PATH:$HOME/bin/:$HOME/.local/bin/
  
  #cd $HOME/bin
  #wget http://sun.aei.polsl.pl/kmc/download/kmc
  #wget http://sun.aei.polsl.pl/kmc/download/kmc_dump
  #chmod 755 kmc kmc_dump
  
  #cd $HOME/bin
  #wget http://downloads.sourceforge.net/project/mummer/mummer/3.23/MUMmer3.23.tar.gz
  #tar -zxf MUMmer3.23.tar.gz
  #cd MUMmer3.23
  #make
  #cd ..
  #for x in `find MUMmer3.23/ -maxdepth 1 -executable -type f`; do cp -s $x . ; done
  
  #cd $HOME/bin
  #wget http://downloads.sourceforge.net/project/samtools/samtools/1.0/samtools-1.0.tar.bz2
  #tar -xjf samtools-1.0.tar.bz2
  #cd samtools-1.0/
  #make
  #cd ..
  #cp -s samtools-1.0/samtools .
  
  #cd $HOME/bin
  #wget http://downloads.sourceforge.net/project/smalt/smalt-0.7.6-bin.tar.gz
  #tar -zxf smalt-0.7.6-bin.tar.gz
  #cp -s smalt-0.7.6-bin/smalt_x86_64 smalt
  
  #pip3 install iva
  
  #cd $curr_dir
  
  
  
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
  rm -rf virgena
  
fi

#TAR-VIR
if [[ "$RUN_TARVIR" -eq "1" ]] || [[ "$RUN_PEHAPLO" -eq "1" ]]
  then
  printf "Installing TAR-VIR and PEHaplo\n\n"
  conda config --add channels defaults
  conda config --add channels conda-forge
  conda config --add channels bioconda
  conda config --add channels kennethshang
  eval "$(conda shell.bash hook)"  
  conda create -n bio2 python=2.7    
  conda activate bio2                 
  pip install networkx==1.11           
  conda install bamtools==2.4.0 apsp sga samtools bowtie2 overlap_extension genometools-genometools numpy scipy
  conda install -c bioconda karect
  git clone --recursive https://github.com/chjiao/TAR-VIR.git
  cd TAR-VIR/Overlap_extension/
  make
  cd ../../ 
  
  conda activate base

fi

#VIP - untested, rerun
if [[ "$RUN_VIP" -eq "1" ]] 
  then
  printf "Installing VIP\n\n"
  wget -O vip "https://github.com/keylabivdc/VIP/archive/refs/heads/master.zip"
  unzip vip
  rm -rf vip
  cd VIP-master/installer
  chmod +x ./dependency_installer.sh
  chmod +x ./db_installer.sh
  sudo sh dependency_installer.sh
  ./db_installer.sh -r ../ #-r #[PATH]/[TO]/[DATABASE]
  cd ../../
  
fi

#drVM
if [[ "$RUN_DRVM" -eq "1" ]] 
  then
  printf "Installing drVM\n\n"
  wget -O drvm "https://sourceforge.net/projects/sb2nhri/files/latest/download"
  unzip drvm
  rm -rf drvm
  
fi

#SSAKE
if [[ "$RUN_SSAKE" -eq "1" ]] 
  then
  printf "Installing SSAKE\n\n"
  wget -O ssake "https://github.com/bcgsc/SSAKE/releases/download/v4.0.1/ssake_v4-0.tar.gz"
  tar -xzf ssake
  rm -rf ssake
  
fi

#viralFlye - missing scipy
if [[ "$RUN_VIRALFLYE" -eq "1" ]] 
  then
  printf "Installing viralFlye\n\n"
  git clone https://github.com/Dmitry-Antipov/viralFlye
  cd viralFlye
  eval "$(conda shell.bash hook)"
  conda create -n viralFlye
  conda activate viralFlye
  conda install -c bioconda -c conda-forge -c mikeraiko "python>=3.6" prodigal viralverify vcflib seqtk minced minimap2 pysam tabix samtools freebayes bcftools numpy scipy blast bwa viralcomplete
  conda install -c conda-forge biopython
  conda install -c anaconda scipy
  #cd ..
  rm -rf Pfam-A.hmm.gz  
  wget http://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam34.0/Pfam-A.hmm.gz
  
  conda activate base
fi


#EnsembleAssembler - mid installation
if [[ "$RUN_ENSEMBLEASSEMBLER" -eq "1" ]] 
  then
  printf "Installing EnsembleAssembler \n\n"
  #wget -O ensembleAssembly "https://sourceforge.net/projects/ensembleassembly/files/latest/download"
  #tar -zxvf ensembleAssembly
  
  #install abyss
  wget -O abyss "https://github.com/bcgsc/abyss/releases/download/2.3.5/abyss-2.3.5.tar.gz"
  tar -zxvf abyss  
  cd abyss-2.3.5  
  eval "$(conda shell.bash hook)"
  conda create -n ensembleAssembler
  conda activate ensembleAssembler
  conda install -c conda-forge boost openmpi
  conda install -c bioconda google-sparsehash
  conda install -c conda-forge compilers
  ./autogen.sh
  mkdir build
  cd build
  ../configure --prefix=$(pwd)/../../
  make
  make install
  PATH=$(pwd)/../../:$PATH  
  cd ..  
  #copy abyss-pe
  
  
  #
  
  conda activate base
  
  
  
fi

