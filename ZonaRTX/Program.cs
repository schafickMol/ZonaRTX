using ZonaRTX.data;
using ZonaRTX.Models;
using ZonaRTX.Controllers;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Agregar el servicio de controladores y vistas
builder.Services.AddControllersWithViews();

// Registrar el repositorio genérico IBaseRepository para las diferentes entidades
builder.Services.AddScoped<IBaseRepository<CategoriasModel>, BaseRepository<CategoriasModel>>();
builder.Services.AddScoped<IBaseRepository<DetallesPedidosModel>, BaseRepository<DetallesPedidosModel>>();
builder.Services.AddScoped<IBaseRepository<InventarioModel>, BaseRepository<InventarioModel>>();
builder.Services.AddScoped<IBaseRepository<PedidosModel>, BaseRepository<PedidosModel>>();
//.Services.AddScoped<IBaseRepository<ProductosModel>, BaseRepository<ProductosModel>>();
builder.Services.AddScoped<IBaseRepository<ProductosProveedoresModel>, BaseRepository<ProductosProveedoresModel>>();
builder.Services.AddScoped<IBaseRepository<ProveedoresModel>, BaseRepository<ProveedoresModel>>();
builder.Services.AddScoped<IBaseRepository<UsuariosModel>, BaseRepository<UsuariosModel>>();

// Registrar la clase de acceso a datos SQL
builder.Services.AddSingleton<ISqlDataAccess, SqlDataAccess>();

// Registrar los controladores
builder.Services.AddScoped<CategoriasController>();
builder.Services.AddScoped<DetallesPedidosController>();
builder.Services.AddScoped<InventarioController>();
builder.Services.AddScoped<PedidosController>();
builder.Services.AddScoped<ProductosController>();
builder.Services.AddScoped<ProductosProveedoresController>();
builder.Services.AddScoped<ProveedoresController>();
builder.Services.AddScoped<UsuariosController>();
builder.Services.AddScoped<IProductosRepository, ProductosRepository>();
builder.Services.AddScoped<IBaseRepository<DetallesPedidosModel>, DetallesPedidosRepository>();
builder.Services.AddScoped<IBaseRepository<ProductosModel>, ProductosRepository>();



var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

// Configuración de la ruta por defecto
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
