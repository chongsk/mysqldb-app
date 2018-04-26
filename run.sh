docker run -d --rm --name my_CONSUL_TPL \
    -v $(pwd):/usr/src/myapp \
	-w /usr/src/myapp \
	--env PHP_SCRIPTNAME=/usr/src/myapp/test/mysql.php \
	--env CONSUL_TEMPLATE_URL=/usr/src/myapp/test/conn.inc.ctmpl \
	--env CONSUL_HTTP_ADDR=172.31.18.9:8500 \
	--env VAULT_ADDR=https://172.31.18.9:8200 \
	--env VAULT_TOKEN=$VAULT_TOKEN \
	cits/mysql_php_consul 
