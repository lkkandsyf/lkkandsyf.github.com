all:
	git add .
	bundle exec jekyll serve

# sudo docker run -it -v $PWD:/media -p 4000:4000 lkklinux/ruby-blog /bin/bash
# bundle exec jekyll serve
