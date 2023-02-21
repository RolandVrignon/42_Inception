#!/bin/bash

envsubst < database.sql > database_new.sql

mysqld --user=root --bootstrap < database_new.sql

exec mysqld --user=root $@