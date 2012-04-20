#!/bin/bash
# foobot - Der Statusbot der foobar

cd $BOTDIR

source config.cfg
LASTSTATUS=`cat laststatus`

ping -c 3 $SPACE_IP >> /dev/null;
FOOBAR_STATUS=$?
DATETIME=`date +"%d.%m.%Y %H:%M"`

case $FOOBAR_STATUS in
0)
  if [ $LASTSTATUS -ne 0 ] ; then
    rm htdocs/status.png && ln -s ../open.png htdocs/status.png;
    echo "open" > htdocs/api;
    sed -e "s/{space}/${SPACE}/" -e "s/{status}/offen/" -e "s/{datetime}/${DATETIME}/" -e "s/{phone}/<p>Wie lange ist noch jemand da\?<br \/>Ruf an: ${PHONE}<\/p>/" template.html > htdocs/index.html;
    echo "0" > laststatus;
  fi
  ;;
1)
  if [ $LASTSTATUS -ne 1 ] ; then
    rm htdocs/status.png && ln -s ../closed.png htdocs/status.png;
    echo "closed" > htdocs/api;
    sed -e "s/{space}/${SPACE}/" -e "s/{status}/geschlossen/" -e "s/{datetime}/${DATETIME}/" -e "s/{phone}//" template.html > htdocs/index.html;
    echo "1" > laststatus;
  fi
  ;;
*)
  rm htdocs/status.png && ln -s ../error.png htdocs/status.png;
  echo "error" > htdocs/api;
  sed -e "s/{space}/${SPACE}/" -e "s/{status}/Fehler/" -e "s/{datetime}/${DATETIME}/" -e "s/{phone}//" template.html > htdocs/index.html;
  echo "5" > laststatus;
  ;;
esac

exit 0
