#!/bin/bash
#
cp reconstructed/total_stats.tsv .
declare -a TOOLS=("coronaSPAdes" "Haploflow" "LAZYPIPE" "metaSPAdes" "metaviralSPAdes" "PEHaplo" "QuRe" "QVG" "SPAdes" "SSAKE" "TRACESPipe" "TRACESPipeLite" "VirGenA" "ViSpA" "V-pipe")
#declare -a list
#declare -p list
#
rm -rf vir
#rm -rf Graphs
mkdir vir
mkdir Graphs
i=""
declare ans

for tool in "${TOOLS[@]}" 
  do
  
  i=$(echo "$tool" | tr '[:upper:]' '[:lower:]' )
  
  cd vir  
  content=$(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS13" || $1=="DS63" || $1=="DS64" || $1=="DS65") {print $0}}' | cut --complement -d'S' -f1 > $tool)
 
  #aux=$(cat "${tool}" | awk -F"," '{print $1}' | cut -d'S' -f2 | cut -d'	' -f1 )
  #content= echo "$content
#	$aux"
  #echo $content > $tool
  #tool+="\n"
  #tool+=$aux
  echo "$(sort -t$'\t' -k1 -n ${tool})" > ${tool}
  cd ..
   
done
#
list_vir=($(ls vir))  
#  
#printf "${list[*]} \n\n"
#
cd vir
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_vir.pdf"
    set datafile separator "\t"
    
    ymax = 100.5
    ymin = 94
    offset = ( ymax - ymin ) / 15.0    
    set yrange [ymin:ymax]
    set xrange [62:66]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_vir[@]}"]{  
      set key at 68, ymax
      plot file u 1:5 title file with linespoints linestyle count
      count = count + 1
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCD_vir.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [62:66]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCD"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_vir[@]}"]{  
      set key at 68, ymax
      plot file u 1:6 title file with linespoints linestyle count
      count = count + 1
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_vir.pdf"
    set datafile separator "\t"
    
    ymax = 0.11
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [62:66]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_vir[@]}"]{  
      set key at 68, ymax
      plot file u 1:7 title file with linespoints linestyle count
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ..
#
