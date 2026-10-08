#!/bin/bash
aws ec2 describe-instances --instance-ids i-0d87057ad4401f2be --query 'Reservations[].Instances[].PublicDnsName'
