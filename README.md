# HVRS
Human Viral Reconstruction Survey - Comparative evaluation of computational methods for reconstruction of human viral genomes

### REPLICATION ###

Run the whole experiment in a Linux system with:
<pre>
git clone https://github.com/viromelab/HVRS.git
cd HVRS/src/
bash Installation.sh --all
bash Simulation.sh
bash Reconstruction.sh --all
bash Evaluation.sh 
bash Plots.sh
</pre>

## RECONSTRUCTION PROGRAMS ##

The survey includes the following tools:

| Tool | URL |
| --- | --- |
| coronaSPAdes | https://github.com/ablab/spades |
| Haploflow | https://github.com/hzi-bifo/Haploflow |
| IRMA | https://wonder.cdc.gov/amd/flu/irma/ |
| LAZYPIPE | https://www.helsinki.fi/en/projects/lazypipe | 
| metaSPAdes | https://github.com/ablab/spades |
| metaviralSPAdes | https://github.com/ablab/spades |
| PEHaplo | https://github.com/chjiao/PEHaplo |
| QuRe | https://sourceforge.net/projects/qure |
| QVG | https://github.com/laczkol/QVG |
| SPAdes | https://github.com/ablab/spades |
| SSAKE | http://www.bcgsc.ca/bioinfo/software/ssake |
| TRACESPipe | https://github.com/viromelab/TRACESPipe |
| TRACESPipeLite | https://github.com/viromelab/TRACESPipeLite |
| VirGenA | https://github.com/gFedonin/VirGenA |
| ViSpA | https://alan.cs.gsu.edu/NGS/?q=content/vispa |
| V-pipe | https://github.com/cbg-ethz/V-pipe |




### PARAMETERS ###

To see the possible installation options type
<pre>
./Installation.sh -h
</pre>

This will print the following options:

```
 ------------------------------------------------------------------ 
                                                                    
 Installation.sh : Installation script for HVRS                     
                                                                    
 Script to install all of the tools necesary to run HVRS.           
                                                                    
 Program options -------------------------------------------------- 
                                                                    
 -h, --help                    Show this,                           
 --miniconda                   Install Miniconda,                   
 --all                         Install all tools, except Miniconda. 
                                                                    
 --coronaspades                Install coronaSPAdes,                
 --haploflow                   Install Haploflow,                   
 --irma                        Install IRMA,                        
 --lazypipe                    Install LAZYPIPE,                    
 --metaspades                  Install metaSPAdes,                  
 --metaviralspades             Install metaviralSPAdes,             
 --pehaplo                     Install PEHaplo,                     
 --qure                        Install QuRe,                        
 --qvg                         Install QVG,                         
 --spades                      Install SPAdes,                      
 --ssake                       Install SSAKE,                       
 --tracespipe                  Install TRACESPipe,                  
 --tracespipelite              Install TRACESPipeLite,              
 --virgena                     Install VirGenA,                     
 --vispa                       Install ViSpA,                       
 --vpipe                       Install V-pipe,                      
 --tools                       Install other tools used in the      
                               benchmark.                           
                                                                    
 Examples --------------------------------------------------------- 
                                                                    
 - Install Miniconda                                                
  ./Installation.sh --miniconda                                     
                                                                    
 - Install all tools (except Miniconda)                             
  ./Installation.sh --all                                           
                                                                    
 ------------------------------------------------------------------
```

To see the possible reconstruction options type
<pre>
./Reconstruction.sh -h
</pre>

This will print the following options:

```
 ------------------------------------------------------------------ 
                                                                    
 Reconstruction.sh : Reconstruction script for HVRS                 
                                                                    
 Script to reconstruct all of the datasets contained in HVRS.       
                                                                    
 Program options -------------------------------------------------- 
                                                                    
 -h, --help                    Show this,                           
                                                                    
 --all                         Reconstruction using all tools,      
                                                                    
 --coronaspades                Reconstruction using coronaSPAdes,   
 --haploflow                   Reconstruction using Haploflow,      
 --lazypipe                    Reconstruction using LAZYPIPE,       
 --irma                        Reconstruction using IRMA,           
 --metaspades                  Reconstruction using metaSPAdes,     
 --metaviralspades             Reconstruction using metaviralSPAdes,
 --pehaplo                     Reconstruction using PEHaplo,        
 --qure                        Reconstruction using QuRe,           
 --qvg                         Reconstruction using QVG,            
 --spades                      Reconstruction using SPAdes,         
 --ssake                       Reconstruction using SSAKE,          
 --tracespipe                  Reconstruction using TRACESPipe,     
 --tracespipelite              Reconstruction using TRACESPipeLite, 
 --virgena                     Reconstruction using VirGenA,        
 --vispa                       Reconstruction using ViSpA,          
 --vpipe                       Reconstruction using V-pipe.         
                                                                    
 -t  <INT>, --threads <INT>    Number of threads,                   
 -m  <INT>, --memory <INT>     Maximum of RAM available,            
                                                                    
 --virgena-timeout <INT>       Maximum time used by VirGenA         
                               to reconstruct with each reference,  
 --timeout <INT>               Maximum time used by a reconstruction
                               program to reconstruct a genome.     
                                                                    
 -r <STR>, --reads <STR>       FASTQ reads file name. The string    
                               must be the name before _1 and _2.fq.
                               The references are retrieved using   
                               FALCON-meta.                         
                                                                    
 -y, --yes                     Assume the answer to all prompts is yes.
                                                                    
 --top_falcon  <INT>           Maximum number of references retrived
                               by FALCON-meta.                      
                                                                    
                                                                    
 Examples --------------------------------------------------------- 
                                                                    
 - Reconstruct using all tools                                      
  ./Reconstruction.sh --all                                         
                                                                    
 ------------------------------------------------------------------
```

### CITATION ###

On using this software/method please cite:

* pending

### ISSUES ###

For any issue let us know at [issues link](https://github.com/viromelab/HVRS/issues).

### LICENSE ###

GPL v3.

For more information:
<pre>http://www.gnu.org/licenses/gpl-3.0.html</pre>

