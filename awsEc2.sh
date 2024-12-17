#!/bin/bash
#-----------------------------------------------------------------------------------------

#AUTHOR : NAVEEN BHARATHI S
#TITLE : AWS EC2
#DESCRIPTION : This script helps the user to easily fetch the instance details in AWS 
#DATE : 17/12/2024

#-----------------------------------------------------------------------------------------


# Function to list instances with their public IPs, names, and IDs
list_instances() {
  echo "Listing all instances with Public IP, Name, and Instance ID..."
  aws ec2 describe-instances \
    --query "Reservations[*].Instances[*].[InstanceId, State.Name, Tags[?Key=='Name'].Value | [0], PublicIpAddress]" \
    --output table
}

# Function to stop an instance
stop_instance() {
  echo "Enter the Instance ID to stop:"
  read INSTANCE_ID
  aws ec2 stop-instances --instance-ids "$INSTANCE_ID"
  echo "Instance $INSTANCE_ID is stopping."
}

# Function to start an instance
start_instance() {
  echo "Enter the Instance ID to start:"
  read INSTANCE_ID
  aws ec2 start-instances --instance-ids "$INSTANCE_ID"
  echo "Instance $INSTANCE_ID is starting."
}

# Menu loop
while true; do
  echo "\nAWS EC2 Instance Manager"
  echo "1. List Instances"
  echo "2. Stop Instance"
  echo "3. Start Instance"
  echo "4. Exit"
  echo -n "Choose an option: "
  read CHOICE

  case $CHOICE in
    1)
      list_instances
      ;;
    2)
      stop_instance
      ;;
    3)
      start_instance
      ;;
    4)
      echo "Exiting..."
      break
      ;;
    *)
      echo "Invalid option. Please try again."
      ;;
  esac
done
