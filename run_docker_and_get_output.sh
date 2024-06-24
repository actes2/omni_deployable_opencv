echo "Anything sent to actesco.org on 4469 will route to here"
#docker run -p 4469:6614/udp -it --rm -w /app/ -v /copy_and_paste/sailboat/:/app temp_cont
docker run -p 4469:6614/udp -it --rm -w /app/ -v ./:/app temp_cont
