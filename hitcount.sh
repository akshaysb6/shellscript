#!/bin/bash

function ldate {

                read -p "provide the date in yyyy/mm/dd format :" logdate
                dcount=$(grep $logdate $line/log/production.log|grep -v  "Parameters:"|wc -l)
                echo "total hit:" $dcount
           }

           function ltime {
                read -p "provide the time in hour:min:sec :" logtime
                tcount=$(grep $logtime $line/log/production.log|grep -v "Parameters:"|wc -l)
                echo "total hit:" $tcount

          }

         function menu {
                  echo "choose the required option"
                  echo "1.hits on a day 2.hits at a a paticular time:"
                  read -n 1 option
                 echo
          }


#main
path=/var/fedena/fedena.conf
count=$(wc -l $path| gawk '{print $1}')
#to find the required file-filep=cat /srv/fedena_app/fedena_erp/vendor/plugins/acts_as_multi_school/config/multischool_settings.yml | grep name | cut -f2 -d":"
ts=$(date +'%d%m%y')
if [ -f $path ]
then
        echo "file exist"
        if [ $count -ge 2 ]
        then
                echo "below are the installations"
                echo 
                cat $path |sed -e '1d'|gawk -F: '{print $1}' > temp
                cat -n temp
                read -p "choose the path": li
                #line=$(sed -n ' '$li' 'p $line|gawk -F: '{print $1}')
                #       cut -f1 -d":")
                line=$(sed -n ' '$li' 'p temp)
                echo "choosen path:"$line
                sleep 0.5

                menu
                case $option in
                        1)
                                ldate ;;

                        2)      ltime ;;

                        *)
                                echo "invalid entry"
                esac


else
                echo "installation available at:" $path
                line=$(head -1 $path|cut -f1 -d":")
                ls -n $line/log
        fi
        else
                   echo "installation not available"
           fi
                rm temp

