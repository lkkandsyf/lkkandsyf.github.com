all:
	git add .
	bundle exec jekyll serve -w --host=0.0.0.0

# sudo docker run -it -v $PWD:/media -p 4000:4000 lkklinux/ruby-blog /bin/bash
# bundle exec jekyll serve
