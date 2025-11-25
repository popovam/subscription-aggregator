using SA.Backend;
using SA.Infrastructure.Contexts;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();
builder.Services.AddCors();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddScoped<MainContext>();
builder.Services.AddServices();
builder.Services.AddRepositoties();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors(builder => builder
    .AllowAnyOrigin()
    .AllowAnyHeader()
    .AllowAnyMethod());
app.UseHttpsRedirection();
app.UseDeveloperExceptionPage();
app.UseRouting();
app.MapControllers();

app.Run();
