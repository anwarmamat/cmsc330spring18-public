#!/bin/bash

FILENAME=submission.zip

rm -f $FILENAME
zip $FILENAME data.db controller.rb
