using demo_models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseHttpsRedirection();

var summaries = new[]
{
    "Koud", "Winters", "Fris", "Gematigd", "Mild", "Warm", "Zomers", "Heet"
};

app.MapGet("/weer", () =>
{
    var forecast = Enumerable.Range(1, 10).Select(index =>
        new WeatherForecast
        (
            DateTime.Now.AddDays(index),
            Random.Shared.Next(-3, 40),
            summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();
    return forecast;
});

app.MapGet("/health", () => { return "healthy"; });

app.Run();