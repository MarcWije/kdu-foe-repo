#!/usr/bin/python

import mariadb

db_conn = mariadb.connect(host="localhost", user="sid", passwd="secret", db="lab6")
interct = db_conn.cursor()
interct.execute("INSERT INTO products VALUES (NULL, 'abc', 101, 1.99, 'test')")
db_conn.commit()
db_conn.close()
