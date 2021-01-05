#!/bin/bash


          function view {
                  # cat -n production_$ts.log
                    tail -f $line/log/production.log
           }

           function send {
                  scp production_$ts.log akshaysb@foradian.org:production_$ts.log
         # echo ">>>>>>>>>>>production_$ts.log sent successfully<<<<<<<<<<<"          
          }

         function menu {
                  echo "choose the required option"
                  echo -e "1.view log \n2.send log to local"
                  read  n
          }
          function option {

                menu
                case $n in
                        1)
                                view ;;

                        2)      send ;;

                        *)
                                echo "invalid entry"

                esac


          }



echo ">>>>>>>>LOGIN SUCCESSFUL<<<<<<<<"
path=/var/fedena/fedena.conf
count=$(wc -l $path| gawk '{print $1}')
ts=$(date +'%d%m%y')
if [ -f $path ]                                                                         #to check if the folder exist
then
        echo -e "\nFEDENA INSTALLATION EXIST\n"
        if [ $count -ge 3 ]                                                             #to check if there are mutiple installations in server
        then
                echo -e "below are the installations paths" 
                cat $path |sed '1d'|gawk -F: '{print $1}' > temp
                cat -n temp                                                             #list the path
                read -p "choose the path": li

                #line=$(sed -n ' '$li' 'p $line|gawk -F: '{print $1}')
                #       cut -f1 -d":")
                line=$(sed -n ' '$li' 'p temp)                                          #select the required installation from the fedena.conf file
                echo "choosen path:"$line
                sleep 0.5
                tail -n500 $line/log/production.log > production_$ts.log                #move the production log to temp file
                echo "multischool available at-------"$filep
                option
                rm temp
                rm production_$ts.log
##############if server has only one installation######################
        else
                line=$(sed -n '2p' $path|gawk -F: '{print $1}')                         #select the secong line from the fedena.conf
                echo "installation available at:"$line 
                tail -n500  $line/log/production.log > production_$ts.log
                option
                rm production_$ts.log
        fi
else
echo "installation not available"
fi
