# Word extractor
```python
import requests
import re
import click
from bs4 import BeautifulSoup


def get_html_of(url):
    resp = requests.get(url)

    if resp.status_code != 200:
        #print(f"HTTP status code of {resp.status_code} returned, but 200 was expected. Exiting...")
        print("Invalid status code")
        exit(1)

    return resp.content.decode("latin-1")

def get_all_words_from(url):
    html = get_html_of(url)
    soup = BeautifulSoup(html, 'html.parser')
    raw_text = soup.get_text()
    all_words = re.findall(r'\w+', raw_text)
    return all_words 

def count_occurences_in(all_words):
    word_count = {}
    for word in all_words:
        if word not in word_count:
            word_count[word] = 1
        else:
            current_count = word_count.get(word)
            word_count[word] = current_count + 1
    return word_count

def get_top_words_from(url):
    all_words = get_all_words_from(url)
    word_count = count_occurences_in(all_words)
    top_words = sorted(word_count.items(), key=lambda item: item[1], reverse=True)
    return top_words

@click.command()
@click.option('--url', '-u', prompt='Web URL', help='URL of webpage to extract from.')
@click.option('--length', '-l', default=0, help='Minimum word length (default: 0, no limit).')
def main(url, length):
    top_words= get_top_words_from(url)
    for i in range(length):
       print(top_words[i])


if __name__ == '__main__':
    main()
```