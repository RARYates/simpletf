#!/bin/bash

sleep 30
yum install -y httpd
systemctl start httpd
