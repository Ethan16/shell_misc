#!/bin/bash

cat << CLOUD
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "https://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <title>
  教授的信息
  <\title>  
  <\head>
  <body>
    <table>
CLOUD

sed -e 's/:/<\/TD><TD>/g' -e 's/^/<tr><td>/g' -e 's/$/<\/td><\/tr>/g'

cat << CLOUD
  </table>
  </body>
  </html>
CLOUD