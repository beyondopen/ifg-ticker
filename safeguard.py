import re

import yaml
from twython import Twython


def sane_timeline():
    """Check if there no duplicated links in the past 200 tweets.

    Returns:
        True if there are no duplicates and False, otherwise
    """
    with open('ttnconfig/config.yaml') as f:
        config = yaml.load(f)

    api_key, api_secret, oauth_token, oauth_secret = [config['twitter'][k] for k in (
        'api_key', 'api_secret', 'oauth_token', 'oauth_secret')]

    twitter = Twython(api_key, api_secret,
                      oauth_token, oauth_secret)

    tweets = twitter.get_user_timeline(count=200)
    all_urls = []

    for t in tweets:
        urls = re.findall(r'(https?://\S+)', t['text'])
        all_urls += urls

    return len(all_urls) == len(set(all_urls))


if __name__ == '__main__':
    print(sane_timeline())
