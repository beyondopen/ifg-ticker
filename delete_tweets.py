import yaml
from twython import Twython


def delete_tweets():
    """Delete tweets.
    """
    with open('ttnconfig/config.yaml') as f:
        config = yaml.load(f)

    api_key, api_secret, oauth_token, oauth_secret = [config['twitter'][k] for k in (
        'api_key', 'api_secret', 'oauth_token', 'oauth_secret')]

    twitter = Twython(api_key, api_secret,
                      oauth_token, oauth_secret)

    tweets = twitter.get_user_timeline(count=200)

    for t in tweets:
        pass
        # if t['text'].startswith('Der Freitag: Aufklärung | Echte Transparenz könnte Sie ja überfordern!'):
        #     print(t['id'])
        #     twitter.destroy_status(id=t['id'])


if __name__ == '__main__':
    delete_tweets()
