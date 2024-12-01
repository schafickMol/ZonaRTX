using Microsoft.AspNetCore.Mvc;
using ZonaRTX.Models;
using ZonaRTX.data;
using System.Diagnostics; // Asegúrate de que esta sea la ubicación correcta de tu repositorio

namespace ZonaRTX.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IProductosRepository _productosRepository; // Agrega tu repositorio de productos aquí

        public HomeController(ILogger<HomeController> logger, IProductosRepository productosRepository)
        {
            _logger = logger;
            _productosRepository = productosRepository; // Inicializa el repositorio
        }

        public async Task<IActionResult> Index()
        {
            // Obtiene todos los productos de la base de datos
            var productos = await _productosRepository.GetAllAsync();
            return View(productos); // Pasa los productos a la vista
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
