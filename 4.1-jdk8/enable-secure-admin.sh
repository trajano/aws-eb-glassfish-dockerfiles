#!/bin/bash
if [ "$AS_ADMIN_USERPASSWORD" = "**Random**" ]; then
  unset AS_ADMIN_USERPASSWORD
fi
echo AS_ADMIN_USERPASSWORD=${AS_ADMIN_USERPASSWORD:-$(pwgen -s 12 1)} /password
_word=$( [ ${AS_ADMIN_USERPASSWORD} ] && echo "preset" || echo "random" )

echo "=> Setting glassfish admin user with ${_word} password"
asadmin --user admin --passwordfile /password change-admin-password

echo "=> Enable secure admin"
asadmin --user admin --passwordfile /password enable-secure-admin

echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this Glassfish Server using:"
echo ""
echo "    http://<host>:8080/"
echo "    https://<host>:8181/"
echo "    https://<host>:4848/" with user 'admin' password '${AS_ADMIN_USERPASSWORD}'"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
