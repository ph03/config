#!/bin/bash
google-drive-ocamlfuse ~/Private/googledrive
encfs --extpass='gksu -p -m EncFS_PW' $HOME/Private/googledrive/Private/encrypted $HOME/Private/gd_enc_data
