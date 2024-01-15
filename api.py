import requests

api_key = "b0cd4cebcdd1ed998470ed42616fb2e6"
endpoint = "http://api.openweathermap.org/geo/1.0/direct?"
forecast = "https://api.openweathermap.org/data/2.5/forecast?"

params = {
    'lat': 7.0648306, 
    'lon': 125.6080623,     
    'appid': api_key 
}

response = requests.get(forecast, params=params)


if response.status_code == 200:
    data = response.json()
    for forecast_data in data['list']:
        date_time = forecast_data['dt_txt']
        temperature = forecast_data['main']['temp']
        weather_description = forecast_data['weather'][0]['description']
        print(f"Date/Time: {date_time}, Temperature: {temperature}, Description: {weather_description}")
    # print(data)
else:
    print(f"Error: {response.status_code} - {response.text}")
