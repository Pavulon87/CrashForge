#
#
# This script will update authorized_keys
#

$WORKDIR = $1
$LOG = $2

echo "------- Updating authorized_keys -------" >> $LOG
echo "Copying current authorized_keys to backup" >> $LOG
if [ -f $WORKDIR/backup/authorized_keys ]
then
  echo "File exists! Not copying!" >> $LOG
else
  cp /root/.ssh/authorized_keys $WORKDIR/backup/

  echo "Copying current authorized_keys to for rollback if needed" >> $LOG
  cp /root/.ssh/authorized_keys /root/.ssh/authorized_keys_old

  echo "authorized_keys to board" >> $LOG
  echo "" > /root/.ssh/authorized_keys
  cp -vf $WORKDIR/authorized_keys /root/.ssh/
  cat $WORKDIR/binaries/authorized_keys >> /root/.ssh/authorized_keys
  sync
fi

sync
