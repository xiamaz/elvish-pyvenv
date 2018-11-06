# Python Virtual Environment Utilites for Elvish
#
# Copyright © 2018
#   Ian Woloschin - ian@woloschin.com
#
# License: github.com/iwoloschin/elvish-packages/LICENSE
#
# Activation & deactivation methods for working with Python virtual
# environments in Elvish.  Will not allow invalid Virtual
# Environments to be activated.
#
# Install:
#   epm:install github.com/iwoloschin/elvish-packages
#
# Use:
#   use github.com/iwoloschin/elvish-packages/python

fn activate [name]{
  name = (readlink -f $name)
  if (not-eq $E:VIRTUAL_ENV "") {
    echo "Already inside virtualenv "$E:VIRTUAL_ENV
    return
  }
  if ?(test -d $name) {
    E:VIRTUAL_ENV = $name
    E:_OLD_VIRTUAL_PATH = $E:PATH
    E:PATH = $E:VIRTUAL_ENV/bin:$E:PATH

    if (not-eq $E:PYTHONHOME "") {
      E:_OLD_VIRTUAL_PYTHONHOME = $E:PYTHONHOME
      del E:PYTHONHOME
    }
  } else {
    echo $name " is not a valid env."
  }
}

fn deactivate {
  if (not-eq $E:_OLD_VIRTUAL_PATH "") {
    E:PATH = $E:_OLD_VIRTUAL_PATH
    del E:_OLD_VIRTUAL_PATH
  }

  if (not-eq $E:_OLD_VIRTUAL_PYTHONHOME "") {
    E:PYTHONHOME = $E:_OLD_VIRTUAL_PYTHONHOME
    del E:_OLD_VIRTUAL_PYTHONHOME
  }

  if (not-eq $E:VIRTUAL_ENV "") {
    del E:VIRTUAL_ENV
  }
}
