#
# Scala Dockerfile based in CentOS
#

FROM centos

RUN yum update -y >/dev/null
RUN yum -y --nogpgcheck install "http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm" >/dev/null
 
# ENV variables 
ENV HOME /root

# Install packages
RUN yum install java-1.7.0-openjdk.x86_64 -y >/dev/null
RUN yum install wget unzip -y >/dev/null
RUN yum install libyaml-devel rubygems ruby-devel which tar -y >/dev/null
RUN yum install python-pip -y >/dev/null

# Aditional Configuration

# Scala
RUN /bin/rpm -ivh http://downloads.typesafe.com/scala/2.11.0/scala-2.11.0.rpm >/dev/null

# Ruby
RUN curl -L get.rvm.io | bash -s stable >/dev/null
RUN /usr/local/rvm/bin/rvm install 2.0.0 >/dev/null
RUN source /etc/profile.d/rvm.sh
RUN echo "./etc/profile.d/rvm.sh" >> ~/.bash_profile
RUN /bin/bash -l -c "rvm use 2.0.0 --default"

# Supervisor
RUN pip install "pip>=1.4,<1.5" --upgrade >/dev/null
RUN pip install supervisor >/dev/null

# Root user
RUN echo 'root:docker' | chpasswd

# Ports
EXPOSE 22

# Run commands
CMD ["supervisord", "-n"]
