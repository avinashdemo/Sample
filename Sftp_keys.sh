#set -x

#!/bin/bash
#This script is to copy the sftp keys to authhosts file

CR_Ref=$1

User_Name=`whoami`

Keys_Path=/home/tuser/$CR_Ref/$User_Name


echo -e "\n`date "+%d-%m-%y %H:%M:%S"` Initiated the process of sftp Keys installation on back of $CR_Ref .....!!!";

echo -e "\n`date "+%d-%m-%y %H:%M:%S"` Checking if the keys are staged under $Keys_Path";

        ls $Keys_Path > ./foundkeys.txt

#       find $Keys_Path -iname *.txt > ./foundkeys.txt

#       find $Keys_Path -iname *.zip > ./foundkeyss.txt

        if [ -s ./foundkeys.txt ]; then

                foundkeyscnt=`cat foundkeys.txt | wc -l`

                echo -e "\n`date "+%d-%m-%y %H:%M:%S"` Found the below $foundkeyscnt Keys:";

                cat ./foundkeys.txt

                echo ""; echo ""; echo "";



                for i in $(cat ./foundkeys.txt)

                do

                echo -e "\n print i value: $i";

                echo "testing: `cat ${Keys_Path}/${i}`"

                cat ${Keys_Path}/${i} > ./check1.txt


#                       cat $i | grep "^ssh-rsa\ * "
#                       cat ${Keys_Path}/${i} | grep "^ssh-rsa\ ............*" > checksftp.txt

                        while read j

#                       echo -e "\n in j $(cat ${Keys_Path}/${i})";

                                do
                #                       echo -e "\n in j $(cat ${Keys_Path}/${i})";

                                        echo "$j" ;

                                        echo "$j" | grep "^ssh-rsa\ ............*"

                                        echo "$j" | grep "^ssh-rsa\ ............*" > ./checksftp.txt



                                        if [ -s ./checksftp.txt ]; then

                                                echo -e "\n`date "+%d-%m-%y %H:%M:%S"` Below provided sftp key(s) in $i is valid..So will be adding it."

                                                echo "$j";

                                                echo "$j" >> ./finalsftpkeys.txt

                                        fi



                                done < ./check1.txt





                done



        fi


#       if [ !- s ./foundkeys.txt  ] && [ !- s ./foundkeyss.txt ]; then

#               echo -e "\n`date "+%d-%m-%y %H:%M:%S"` Cannot find any keys under ${Keys_Path}.May be keys are not staged yet or staged in an incorrect path.";

#       fi


