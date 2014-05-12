#!/bin/bash

#(name, version, source)
function install_missing
{
  echo "Testing $1 @version $2"
  test=$(pip show $1 | grep "Version: $2")
  if [[ -z "$test" ]]
  then
    echo "Package missing, installing from $3"
    pip install $3
  else
    echo "Package already installed"
  fi

  echo
}

cd "$(dirname "${BASH_SOURCE[0]}")"
ENV_NAME="shelfenv"
ACTIVATE_NAME="${ENV_NAME}/bin/activate"
VIRTUALENV="virtualenv-2.7"

if [ ! -f $ACTIVATE_NAME ]
then
  echo "Installing virtualenv: ${ENV_NAME} by using ${VIRTUALENV}"

  ${VIRTUALENV} "${ENV_NAME}" || { echo "Failed to install virtualenv: $ENV_NAME"; exit -1; }
fi

echo "Activating virtualenv: ${ENV_NAME}"
source "${ACTIVATE_NAME}" || { echo "Failed to activate virtualenv: $ENV_NAME"; exit -2; }

ACTUAL_PYTHON=$(which python)

echo
echo "Actual python executable: ${ACTUAL_PYTHON}"
read -p "Is it correct? [y/N] "
echo

if [[ ! $REPLY =~ ^[yY]$ ]]
then
  echo "Installation cancelled"
  exit 1;
fi

install_missing django "1.6" git+https://github.com/django-nonrel/django@nonrel-1.6
#django_test=$(pip show django | grep "Version: 1.6")
#if [[ -z "$django_test" ]]
#then
#  pip install git+https://github.com/django-nonrel/django@nonrel-1.6
#fi

install_missing django-dajax "0.9" django_dajax

install_missing djangotoolbox "1.6" git+https://github.com/django-nonrel/djangotoolbox

install_missing django-mongodb-engine "0.5" git+https://github.com/django-nonrel/mongodb-engine

install_missing django-jquery "1.9" django-jquery


