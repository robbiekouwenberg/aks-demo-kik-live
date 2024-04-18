using demo_models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Collections.Generic;

namespace demo_app.Pages
{
    public class IndexModel : PageModel
    {
        public IEnumerable<WeatherForecast> WeatherForecasts { get; set; } = new List<WeatherForecast>();

        public async Task OnGet()
        {
            try
            {
                HttpClient httpClient = new HttpClient();
                httpClient.BaseAddress = new Uri(Environment.GetEnvironmentVariable("DEMO_API_URL"));
                var forecasts = await httpClient.GetFromJsonAsync<IEnumerable<WeatherForecast>>("/weer");
                if (forecasts == null)
                {
                    return;
                }
                WeatherForecasts = forecasts;
            }
            catch (System.Exception)
            {
                //no-op
            }
        }
    }
}