# Imapsync

Pls donate to imapsync! Good tool.

[Docker HUB Page](https://hub.docker.com/r/gilleslamiral/imapsync/)

## ad hoc command
```
docker run --rm gilleslamiral/imapsync imapsync --no-modulesversion --noreleasecheck --automap --ssl1 \
    --tmpdir /tmp --nofoldersizes --addheader --exclude (?i)spam|(?i)junk --delete2duplicates --subscribeall \
    --host1 source.lamiral.info --user1 test1 --password1 'secret1' \
    --host2 target.lamiral.info --user2 test2 --password2 'secret2'
```
