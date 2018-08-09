import boto
import boto.s3.connection

access_key = "XXXXX"

secret_key = ""

boto.config.add_section('s3')
boto.config.set('s3', 'use-sigv2', 'True')
conn = boto.connect_s3(
    aws_access_key_id = access_key,
    aws_secret_access_key = secret_key,
    host = "magna013.ceph.redhat.com",
    port = 80,
    is_secure=False,
    calling_format = boto.s3.connection.OrdinaryCallingFormat(),
    )

print boto.s3.connection.Location.EU
bucket = conn.create_bucket('tester-new-bucket')
for bucket in conn.get_all_buckets():
    print "{name}\t{created}".format(
        name = bucket.name,
        created = bucket.creation_date,
)

