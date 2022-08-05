#/bin/bash

if [ "$1" == "" ]; then
  echo "No Argument"
  if [ ! -e ./"1.sh" ]; then
    echo "Writing 1.sh"
    file="1.sh"
  else
    echo "1.sh exist. Write other name"
    exit
  fi
else
  file="$1"
fi


touch $file
cat << EOS > $file
#!/bin/bash

EOS

chmod 744 $file




