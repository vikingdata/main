#!/usr/bin/python2

import re, sys, os, time
import argparse
import boto3


"""
./list_ec2.py -c <Command> <Instance Name>

./list_ec2.py
# With no options, lists out ec2 with status an info

Command : start stop reboot 
Instance Name: The name you give to the ec2 server. 

You need to setup the aws files in ~/.aws with the key file for ssh, the
default.pem file in ~/aws. 

"""

pem_directory = "~/aws"
pem_file = "default.pem"

#-----------------------------------------------------------------
  # Parse command libne arguments.
  # Must have 0 or 2 arguments.
parser = argparse.ArgumentParser(description='Process args.')
parser.add_argument('Command', nargs='?', default='')
parser.add_argument('Name', nargs='?', default='')
args = parser.parse_args()

  # Get all the instances and record info. 
ec2 = boto3.resource('ec2')

re_ = re.compile('^_')

all_info = {}
info = {}
instances = []
all_instances = {}
for inst in ec2.instances.all():
  instances.append(inst) 
  # For each instance, start, stop, restart, or nothing. 
  # Save the values fpr printing later.
  # If an action is taking, reget into for it.

  
for inst in instances:
  vars = [i for i in dir(inst) if not re_.search(str(i)) and hasattr(inst,i) ]

  name = None
  for tag in getattr(inst ,'tags'):
    if tag.has_key(u'Key') and tag.has_key(u'Value') and tag[u'Key'] == 'Name':
      name = tag[u'Value']
#  print "My name is:", name    
  all_instances[name] = inst

  state = "" 
  temp = getattr(inst ,'state')
  if temp.has_key(u'Name') and temp.has_key(u'Code'):
    state = temp[u'Name'] + " " + str(temp[u'Code']) 

  ip =  getattr(inst ,'public_ip_address')   
  instance = getattr(inst ,'instance_id')
  image =  getattr(inst ,'image_id')

  instance_type = getattr(inst ,'instance_type')
  dns = getattr(inst ,'public_dns_name') 
  
  v = [name, state, instance, instance_type, image,dns,ip ]
  info[name]= v
  all_info[name] = {}
  for v in vars:
    g = getattr(inst ,v) 
    all_info[name][v]=g
  
# Check if command and instance is valid.
i_names = info.keys()
if args.Command is None or args.Command == '': pass
elif args.Command not in ['start', 'stop','reboot', 'update', 'upgrade']:
  print "Command ignored, ", args.Command, ",should be one of ",  ['start', 'stop','reboot', 'update', 'upgrade']
elif args.Name not in i_names:
  print "Instance, " , args.Name, " not in ", i_names
else:
  # Do one of the commands.
  # You should have configured ssh with the right pem located at default directory and
  # and set the right username in ssh config. 

  host =  all_info[args.Name]['public_dns_name'] 
  ssh_command = "ssh -i " + pem_directory + "/" + pem_file + " " + host
 
  if args.Command in ["stop", "start", "reboot"] and args.Name in i_names:
    try: 
      if args.Command == "start": all_instances[args.Name].start(); print "Starting:", args.Name
      if args.Command == "stop": all_instances[args.Name].stop(); print "Stopping:", args.Name
      if args.Command == "reboot": all_instances[args.Name].reboot(); print "Rebooting:", args.Name
    except Exception,e:
      print "ERROR: command failed:", sys.exc_info()[0]
      print "  ", e
      
    print "Check in 15 seconds and get the status again."

    not_needed = """ 
    # Reset this instance. 
    instance_id = all_info[args.Name]['instance_id']
    inst = ec2.Instance(instance_id)

    all_info[args.Name][1] = getattr(inst ,'state')
    all_info[args.Name] = {}
    vars = [i for i in dir(inst) if not re_.search(str(i)) and hasattr(inst,i) ]
    for v in vars:
      g = getattr(inst ,v)
      all_info[args.Name][v]=g
    all_instances[args.Name] = inst
    """

i_keys = info.keys()
i_keys.sort()
for i in i_keys:
  print i, info[i]
  
  
