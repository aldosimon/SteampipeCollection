select 
association_public_ip as public_ip 
from 
aws_ec2_network_interface 
where 
association_public_ip is not null;
