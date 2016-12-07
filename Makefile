all:
	git add .
	jekyll build
	jekyll serve

#jekyll serve open local host
#usage docker
#sudo docker run -it -v $PWD:/media -p 4000:4000 jekyll/jekyll /bin/bash
#jekyll build
#jekyll serve .
#localhost:4000
