#!/bin/bash

clear

echo "Welcome to the Google Assistant Automated Setup Tool"
sleep 2
echo "By u/VanishingTacos aka Linux Lord"
sleep 2
clear
echo "A special thanks to Novaspirit Tech (https://goo.gl/8DZhea) for inspiring this project"
sleep 2
clear

#Update Database 
while true; do
    read -p "Do you wish to to update your database? Note: This is necessary to configure the script. (y/n)" yn
    case $yn in
        [Yy]* ) sudo updatedb; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Database was successfully updated!"
sleep 4

clear

#Test if Google Assistant is already setup
echo "Testing if Google Assistant is already setup"
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
sleep .5

clear
	
	googlesamples_assistant=$(locate -n 1 /env/bin/googlesamples-assistant)
	setuptools=$(locate -n 1 /env/lib/python3.5/site-packages/setuptools)
	python_environment=$(locate -n 1 /env/bin/activate)



	if [ -f "$python_environment" ] && [ -d "$setuptools" ] && [ -f "$googlesamples_assistant" ]
		then 
			while true; do
    read -p "It looks like you already have Google Assistant setup! Do you wish to start Google Assistant now? (y/n)" yn
    case $yn in
        [Yy]* ) source $python_environment; python -m googlesamples.assistant;
		break;;
		[Nn]* )echo "okay..."; sleep 2; break;;
       	* ) echo "Please answer yes or no.";;
    esac
done
		else 
			echo "It looks like Google Assistant is not set up yet! The script will continue in 4 seconds."
			sleep 4
		fi
clear

#Configure a Developer Project and Account Settings
while true; do
    read -p "Please follow the directions at https://goo.gl/mCmiVh to configure a developer project and account settings. Do you wish to open the link? (y/n)" yn
    case $yn in
        [Yy]* )echo "Opening in 3 seconds"; sleep 3; x-www-browser https://goo.gl/mCmiVh; break;;
        [Nn]* )echo "Okay.."; sleep 2; break;; 
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Please make sure you have downloaded the client-secret.json file before you continue!"
read -n 1 -s -p "Press any key to continue"
sudo updatedb
clear

echo "Searching for client-secret.json ..."
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
sleep .5

client_secret_json_path=$(locate -n 1 apps.googleusercontent.com.json)


if [ -f "$client_secret_json_path" ]
then
	echo "The client-secret.json has been loaded successfully!" 
	sleep 2
else
	echo "The client-secret.json failed to load! Will exit in 3 seconds..."
	sleep 2
	exit
fi



echo "Please wait while the system loads..."
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
sleep .5
echo "Load complete..."
sleep .5

clear

#Update System
while true; do
    read -p "Do you wish to upgrade your system? (y/n)" yn
    case $yn in
        [Yy]* ) sudo apt-get update && sudo apt-get upgrade; echo "Upgrade completed successfully!"
sleep 2; break;;
		[Nn]* )echo "okay..."; break;;
       	* ) echo "Please answer yes or no.";;
    esac
done

clear

#Install python3-dev & python3-venv
while true; do
    read -p "Do you wish to install python3-dev & python3-venv? (y/n)" yn
    case $yn in
        [Yy]* ) sudo apt-get install python3-dev python3-venv
		break;;
        [Nn]* ) echo "Google Assistant set up failure"; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Installation of python3-dev & python3-venv completed!"
sleep 2

clear

#Install portaudio19-dev, libffi-dev, and libssl-dev
while true; do
    read -p "Do you wish to install portaudio19-dev, libffi-dev, and libssl-dev? (y/n)" yn
    case $yn in
        [Yy]* ) sudo apt-get install portaudio19-dev libffi-dev libssl-dev;

		break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Installation of portaudio19-dev, libffi-dev, and libssl-dev completed successfully!"
sleep 2

clear

#Enable Python Environment 
while true; do
    read -p "Do you wish to enable the python environment? (y/n)" yn
    case $yn in
        [Yy]* ) python3 -m venv env; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

sudo updatedb

clear

python_environment=$(find -i /env/bin/activate)

if [ -f "$python_environment" ]
then
	echo "The python environment has been loaded successfully!" 
	sleep 2
else
	echo "The python environment failed to load!"
	sleep 2
	exit
fi

clear

#Install setuptools 
while true; do
    read -p "Do you wish to install setuptools? (y/n)" yn
    case $yn in
        [Yy]* ) env/bin/python -m pip install pip setuptools --upgrade; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Installation of setuptools completed successfully!"
sleep 2

clear

#Enter the python environment 
while true; do
    read -p "Do you wish to enter the python environment now? (y/n)" yn
    case $yn in
        [Yy]* ) source $python_environment; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Python environment was successfully entered!"
sleep 2

clear

#Install google-assistant-sdk
while true; do
    read -p "Do you wish to install the google-assistant-sdk? (y/n)" yn
    case $yn in
        [Yy]* ) python -m pip install google-assistant-sdk[samples]; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Installation of google-assistant-sdk was completed successfully!"
sleep 2

clear

#Authentication
while true; do
    read -p "Do you wish to authenticate now? (y/n)" yn
    case $yn in
        [Yy]* ) python -m googlesamples.assistant.auth_helpers --client-secrets $client_secret_json_path; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

clear

echo "Authentication was performed successfully!"
read -n 1 -s -p "Press any key to continue"

clear

google=$(locate -n 1 Google.sh)
#Create easy access to Google Assistant

while true; do
    read -p "Would you like create easy access to Google Assistant? This would allow you to type "Google.sh" into the terminal at it would run Google Assistant. (y/n)" yn
    case $yn in
        [Yy]* ) sudo cp $google /usr/local/bin; echo "Now you can type "Google.sh" in a new terminal and will run Google Assistant";
				sleep 3; break;;
        [Nn]* ) echo "okay.."; sleep 5;;
        * ) echo "Please answer yes or no.";;
    esac
done




#Start Google Assistant
while true; do
    read -p "Would you like to start Google Assistant now? (y/n)" yn
    case $yn in
        [Yy]* ) echo "Starting Google Assistant now..."
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
sleep .5
echo "Load complete..."
sleep .5

clear

python -m googlesamples.assistant;

 break;;
        [Nn]* ) echo "Google Assistant failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac

done