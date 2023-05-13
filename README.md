[Dockerhub](https://hub.docker.com/r/vekaverjj/amvstrmv1)
==

- ### Build Locally
```
git clone https://github.com/Ve-Ka/AmvStrmV1Docker
docker build -t amvstrm --no-cache .
docker run -p 1001:80 -e API_URL=http://YOUR_LOCAL_IP:1000 -d --name amvstrm amvstrm
```
