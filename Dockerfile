# 1️⃣ Use official Apache image (stable & secure)
FROM httpd:2.4

# 2️⃣ Remove default Apache website
RUN rm -rf /usr/local/apache2/htdocs/*

# 3️⃣ Copy your HTML website into Apache document root
COPY html/ /usr/local/apache2/htdocs/

# 4️⃣ Expose Apache port
EXPOSE 80
