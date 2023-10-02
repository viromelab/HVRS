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
mkdir vir_2
for tool in "${TOOLS[@]}" 
  do
  
  i=$(echo "$tool" | tr '[:upper:]' '[:lower:]' )
  
  cd vir_2  
  content=$(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS5" || $1=="DS13" || $1=="DS57" || $1=="DS58") {print $0}}' | cut --complement -d'S' -f1 > $tool)
 
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
mkdir vir_3
for tool in "${TOOLS[@]}" 
  do
  
  i=$(echo "$tool" | tr '[:upper:]' '[:lower:]' )
  
  cd vir_3  
  content=$(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS13" || $1=="DS61" || $1=="DS62") {print $0}}' | cut --complement -d'S' -f1 > $tool)
 
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
list_tools=($(ls vir)) 
list_tools_2=($(ls vir_2)) 
list_tools_3=($(ls vir_3))  
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
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:5:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_vir.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "NCSD"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:6:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
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
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "NRC"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:7:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ../vir_2
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cont.pdf"
    set datafile separator "\t"
    
    ymax = 100.5
    ymin = 94
    offset = ( ymax - ymin ) / 15.0    
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:5:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cont.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "NCSD"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:6:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cont.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "NRC"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:7:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
cp *.pdf ../Graphs
#
#
cd ../vir_3
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_length.pdf"
    set datafile separator "\t"
    
    ymax = 100.5
    ymin = 94
    offset = ( ymax - ymin ) / 15.0    
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("13" 0, "61" 1, "62" 2)
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:5:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_length.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("13" 0, "61" 1, "62" 2)
    set ytics auto
    set ylabel "NCSD"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:6:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_length.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("13" 0, "61" 1, "62" 2)
    set ytics auto
    set ylabel "NRC"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:7:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
cp *.pdf ../Graphs
#
cd ..
#
