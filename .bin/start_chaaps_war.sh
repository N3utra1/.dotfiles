#!/bin/bash -xe

INSTANCE_ID="i-01050a4d3ef620327"
IDENTITY_PATH="/home/will/ep2-eu-west-2.pem"
STATE=-1

function get_public_ip {
	PUBLIC_DNS=$(aws ec2 describe-instances \
	  --instance-ids "$INSTANCE_ID" \
	  --query "Reservations[0].Instances[0].PublicDnsName" \
	  --output text)

}

function update_state {
	STATE=$(aws ec2 describe-instances \
		  --instance-ids "$INSTANCE_ID" \
		  --query "Reservations[0].Instances[0].State.Name" \
		  --output text)
}

function authorize_ip {
    MY_IP=$(curl -s https://checkip.amazonaws.com)
    CIDR="${MY_IP}/32"

    # Get security group(s) of the instance
    SG_IDS=$(aws ec2 describe-instances \
        --instance-ids "$INSTANCE_ID" \
        --query "Reservations[0].Instances[0].SecurityGroups[*].GroupId" \
        --output text)

    for SG_ID in $SG_IDS; do

        # Check if a rule with description "WAR-DEV" already exists for this IP
        MATCH=$(aws ec2 describe-security-groups \
            --group-ids "$SG_ID" \
            --query "SecurityGroups[0].IpPermissions[?contains(IpRanges[*].Description, 'WAR-DEV')].IpRanges[]" \
            --output json | grep "$CIDR" || true)

        if [ -z "$MATCH" ]; then
            echo "Adding $CIDR to $SG_ID"

      	    aws ec2 authorize-security-group-ingress \
		    --group-id "$SG_ID" \
		    --ip-permissions '[{
			"IpProtocol": "tcp",
			"FromPort": 22,
			"ToPort": 22,
			"IpRanges": [{
			    "CidrIp": "'"$CIDR"'",
			    "Description": "WAR-DEV"
			}]
		    }]'

        else
            echo "$CIDR already authorized in $SG_ID"
        fi
    done
}

function connect {
  ssh ec2-user@$PUBLIC_DNS -i $IDENTITY_PATH
}

update_state
aws ec2 start-instances --instance-ids "$INSTANCE_ID"

while [ "$STATE" != "running" ];
do
  sleep 5
  update_state
done

get_public_ip
authorize_ip
until connect;
do
  sleep 5
done
