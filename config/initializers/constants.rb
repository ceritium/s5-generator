FORMATS = %w[markdown textile]
TIME = [['Today', 'today'], ['This week', 'this-week'], ['This month','this-month'], ['All time','all-time']]

ORDER = {:popular => ['views', 'most viewed'], :most_commented => ['comments_count', 'most commented']}
WEBSHOTS = AVATARS = [[:medium, 300], ['thumb', 100], [:minithumb, 60]]


# Estas constantes están definidas en el settings.yml que no está compartido en git
ENV['RECAPTCHA_PUBLIC_KEY'] = APP_CONFIG[:RECAPTCHA_PUBLIC_KEY]
ENV['RECAPTCHA_PRIVATE_KEY'] = APP_CONFIG[:RECAPTCHA_PRIVATE_KEY]


