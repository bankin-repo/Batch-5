#!/bin/bash

TOMCAT_HOST=44.217.192.242
TOMCAT_USER=tomcat
TOMCAT_HOME=/opt/tomcat
WAR_FILE_PATH=./target/*.war

if [ -f $WAR_FILE_PATH ]; then
	echo "Bringing tomcat server down for deployment..."
	ssh $TOMCAT_USER@$TOMCAT_HOST "$TOMCAT_HOME/bin/shutdown.sh"
    echo "Deploying ELPDevOps application..."
    scp $WAR_FILE_PATH $TOMCAT_USER@$TOMCAT_HOST:$TOMCAT_HOME/webapps/
	echo "Starting tomcat server..."
	ssh $TOMCAT_USER@$TOMCAT_HOST "$TOMCAT_HOME/bin/startup.sh"
	echo "Deployment is successful! Email notification has been sent!"
else
    echo "WAR file doesn't exist! Please check the build."
fi
