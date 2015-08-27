# Fyber Mobile Offer API
Simple Ruby Sinatra web application to interact with Fyber's Mobile API.

## Testing

### Unit tests
All the code was written using test/unit and rack/test

## Dependencies

### Application
* Sinatra
* HTTParty

### Tests
* minitest
* rack-test

### Debugging
* pry

## Notes and possible improvements

### About the code
* Right now, any response code other than "OK" sent by the API ends with a "No offers" message rendered on the page.
* Error handling could be improved a lot, but I believe that it should be enough for this exercise.
* Application parameters, such as api key and appid would be better placed on a config file.

### AWS
* The application is deployed at AWS: http://http://ec2-54-191-182-117.us-west-2.compute.amazonaws.com/
