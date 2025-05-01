import requests
from bs4 import BeautifulSoup
import datetime

url = "https://pixelford.com/blog"
response = requests.get(url, headers = {'user-agent': 'hello again j'})
# print(response.content)

# print(requests.utils.default_headers())

html = response.content
# soup = BeautifulSoup(html, 'html.parser')

# a_tags = soup.find_all('a', class_='entry-title-link' )

# for a_tag in a_tags:
#     print(a_tag.get_text())

# titles_list = list(map(lambda x: x.get_text() ,a_tags))

# print(titles_list)


soup = BeautifulSoup(html, 'html.parser')
blogs = soup.find_all('article', class_="type-post")

for blog in blogs:
    title = blog.find('a', class_="entry-title-link").get_text()

    blog_datetime_string = blog.find('time', class_="entry-time").get('datetime')
    blog_datetime = datetime.datetime.fromisoformat(blog_datetime_string)
    pretty_date = blog_datetime.strftime("%b %d %Y")

    print(f"{pretty_date} - {title}")

