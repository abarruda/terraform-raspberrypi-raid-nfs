docker run --name nfs --privileged -v /mnt/raid1/:/share -e SHARED_DIRECTORY=/share -e SYNC=true -e PERMITTED="*" --restart unless-stopped --net=host nfs:test
