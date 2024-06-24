echo "Anything sent to our host on port 4469 will route to here"
docker run -p 4469:6614/udp -it --rm -w /app/ -v ./:/app temp_cont
