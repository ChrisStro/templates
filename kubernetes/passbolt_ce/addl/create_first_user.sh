#!/bin/bash
echo "Create first passbolt user for admin login"
read -p 'Email: ' EMAIL
read -p 'Firstname: ' FIRSTNAME
read -p 'Lastname: ' LASTNAME
echo
echo "
Email:     $EMAIL
Firstname: $FIRSTNAME
Lastname:  $LASTNAME
"
read -p 'Check your input (y to contiune): ' SUBMIT

[ "$SUBMIT" == "y" ] && {
    kubectl exec -it deploy/passbolt-ce -- /bin/bash -c "bin/cake passbolt register_user -u $EMAIL -f $FIRSTNAME -l $LASTNAME -r admin" -s /bin/bash www-data
    echo
    echo "Check your mailbox!"
} || echo "Canceled"