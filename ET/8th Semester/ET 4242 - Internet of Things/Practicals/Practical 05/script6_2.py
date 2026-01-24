#!/usr/bin/python

import mariadb

db_conn = mariadb.connect(host="localhost", user="sid", passwd="secret", db="lab6")
interct = db_conn.cursor()
interct.execute("SELECT * FROM products")

for row in interct.fetchall():
	print(row)
	
db_conn.close()
