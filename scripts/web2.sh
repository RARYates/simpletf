#!/bin/bash

sleep 10
yum install -y httpd
systemctl start httpd
