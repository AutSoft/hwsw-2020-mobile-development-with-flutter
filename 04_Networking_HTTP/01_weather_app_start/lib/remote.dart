const _API_KEY = r"e6932dac2b4ba21c31ba22d19f4ecc56";

const _oneCityRequestUrl = r"http://api.openweathermap.org/data/2.5/find?lat=47.4701997&lon=19.0585203&cnt=1&units=metric&lang=hu&appid=" + _API_KEY;
const _citiesRequestUrl = r"http://api.openweathermap.org/data/2.5/find?lat=47.4701997&lon=19.0585203&cnt=50&units=metric&lang=hu&appid=" + _API_KEY;
const _forecastRequestUrl = r"https://api.openweathermap.org/data/2.5/onecall?lat=47.4701997&lon=19.0585203&units=metric&lang=hu&exclude=minutely,hourly,alerts&appid=" + _API_KEY;