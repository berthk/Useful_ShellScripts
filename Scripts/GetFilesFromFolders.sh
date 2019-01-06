# This shell script compresses/moves/copies all files inside folders in the currecnt directory recursively
#!/bin/bash
location="`pwd`"
echo "Your current directory is $location"
echo "Please choose an operation (1: Compress, 2: Move, 3: Copy)"
read Operation
list=" "
function Moving {
   for item in $1
   do 
      if [ -d $item ]
      then
         cd $item
         Moving "`ls`"
         cd ..
      elif [ -f $item ]
      then
         list+=" `pwd`/$item"
      fi
   done 
}
Moving "`ls`"
Command=""
if [ "$Operation" == "1" ]
then
   mkdir /var/tmp/archive
   cp $list /var/tmp/archive
   Command="zip -rj archive.zip /var/tmp/archive"
elif [ "$Operation" == "2" ]
then  
   Command="mv $list $location"
elif [ "$Operation" == "3" ]
then 
   Command="cp $list $location"
fi    
$Command
if [ "$Operation" == "1" ]
then
   rm -rf /var/tmp/archive
fi

