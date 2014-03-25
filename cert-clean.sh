#!/bin/bash

host=$1

ssh root@puppet "puppet cert clean $host; "
